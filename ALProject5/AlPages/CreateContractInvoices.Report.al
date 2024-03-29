report 6030 "Create Contract Invoices"
{
    ApplicationArea = Service;
    Caption = 'Create Service Contract Invoices';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Service Contract Header"; "Service Contract Header")
        {
            DataItemTableView = SORTING ("Bill-to Customer No.", "Contract Type", "Combine Invoices", "Next Invoice Date") WHERE ("Contract Type" = CONST (Contract), Status = CONST (Signed), "Change Status" = CONST (Locked));
            RequestFilterFields = "Bill-to Customer No.", "Contract No.";

            trigger OnAfterGetRecord()
            begin
                OnBeforeServiceContractHeaderOnAfterGetRecord("Service Contract Header");

                Counter1 := Counter1 + 1;
                Counter2 := Counter2 + 1;
                if Counter2 >= CounterBreak then begin
                    Counter2 := 0;
                    Window.Update(1, Round(Counter1 / CounterTotal * 10000, 1));
                end;
                Clear(ServContractMgt);
                ServContractMgt.InitCodeUnit;
                ServContractHeader := "Service Contract Header";
                with ServContractHeader do begin
                    TestField("Serv. Contract Acc. Gr. Code");
                    ServContractAccGr.Get("Serv. Contract Acc. Gr. Code");
                    ServContractAccGr.TestField("Non-Prepaid Contract Acc.");
                    if Prepaid then
                        ServContractAccGr.TestField("Prepaid Contract Acc.");
                    Cust.Get("Customer No.");
                    ResultDescription := '';
                    ServContractMgt.GetNextInvoicePeriod(ServContractHeader, InvoiceFrom, InvoiceTo);
                    ContractExist := CheckIfCombinationExists("Service Contract Header");
                    if "Amount per Period" > 0 then begin
                        if not ServContractMgt.CheckIfServiceExist(ServContractHeader) then
                            ResultDescription := Text006;
                        if ResultDescription = '' then begin
                            InvoicedAmount := Round(
                                ServContractMgt.CalcContractAmount(ServContractHeader, InvoiceFrom, InvoiceTo),
                                Currency."Amount Rounding Precision");
                            if InvoicedAmount = 0 then
                                CurrReport.Skip;
                            if not "Combine Invoices" or (LastCustomer <> "Bill-to Customer No.") or not LastContractCombined
                            then begin
                                InvoiceNo := ServContractMgt.CreateServHeader(ServContractHeader, PostingDate, ContractExist);
                                NoOfInvoices := NoOfInvoices + 1;
                            end;
                            ResultDescription := InvoiceNo;
                            ServContractMgt.CreateAllServLines(InvoiceNo, ServContractHeader);
                            LastCustomer := "Bill-to Customer No.";
                            LastContractCombined := "Combine Invoices";
                        end;
                    end else
                        if "Annual Amount" = 0 then
                            ResultDescription := StrSubstNo(Text009, FieldCaption("Annual Amount"))
                        else
                            ResultDescription := '';
                end;
                ServContractMgt.FinishCodeunit;

                OnAfterServiceContractHeaderOnAfterGetRecord("Service Contract Header", InvoiceNo);
            end;

            trigger OnPostDataItem()
            begin
                if not HideDialog then begin
                    if CreateInvoices = CreateInvoices::"Create Invoices" then
                        if NoOfInvoices > 1 then
                            Message(Text010, NoOfInvoices)
                        else
                            Message(Text011, NoOfInvoices);
                end;

                OnAfterServiceContractHeaderOnPostDataItem;
            end;

            trigger OnPreDataItem()
            var
                ConfirmManagement: Codeunit "Confirm Management";
            begin
                if CreateInvoices = CreateInvoices::"Print Only" then begin
                    Clear(ContractInvoicingTest);
                    ContractInvoicingTest.InitVariables(PostingDate, InvoiceToDate);
                    ContractInvoicingTest.SetTableView("Service Contract Header");
                    ContractInvoicingTest.RunModal;
                    CurrReport.Break;
                end;

                if PostingDate = 0D then
                    Error(Text000);

                if not HideDialog then
                    if PostingDate > WorkDate then
                        if not ConfirmManagement.ConfirmProcess(Text001, true) then
                            Error(Text002);

                if InvoiceToDate = 0D then
                    Error(Text003);

                if not HideDialog then
                    if InvoiceToDate > WorkDate then
                        if not ConfirmManagement.ConfirmProcess(Text004, true) then
                            Error(Text002);

                LastCustomer := '';
                LastContractCombined := false;
                SetFilter("Next Invoice Date", '<>%1&<=%2', 0D, InvoiceToDate);
                if GetFilter("Invoice Period") <> '' then
                    SetFilter("Invoice Period", GetFilter("Invoice Period") + '&<>%1', "Invoice Period"::None)
                else
                    SetFilter("Invoice Period", '<>%1', "Invoice Period"::None);
                ServContractMgt.CheckMultipleCurrenciesForCustomers("Service Contract Header");
                Window.Open(
                  Text005 +
                  '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

                CounterTotal := Count;
                Counter1 := 0;
                Counter2 := 0;
                CounterBreak := Round(CounterTotal / 100, 1, '>');
                Currency.InitRoundingPrecision;

                OnAfterServiceContractHeaderOnPreDataItem("Service Contract Header", PostingDate, InvoiceToDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Service;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the date that you want to use as the posting date on the service invoices created.';
                    }
                    field(InvoiceToDate; InvoiceToDate)
                    {
                        ApplicationArea = Service;
                        Caption = 'Invoice to Date';
                        ToolTip = 'Specifies the date up to which you want to invoice contracts. The batch job includes contracts with next invoice dates on or before this date.';
                    }
                    field(CreateInvoices; CreateInvoices)
                    {
                        ApplicationArea = Service;
                        Caption = 'Action';
                        OptionCaption = 'Create Invoices,Print Only';
                        ToolTip = 'Specifies the desired action for service contracts that are due for invoicing.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if not SetOptionsCalled then
            PostingDate := WorkDate;
        NoOfInvoices := 0;
    end;

    var
        Text000: Label 'You have not filled in the posting date.';
        Text001: Label 'The posting date is later than the work date.\\Confirm that this is the correct date.';
        Text002: Label 'The program has stopped the batch job at your request.';
        Text003: Label 'You must fill in the Invoice-to Date field.';
        Text004: Label 'The Invoice-to Date is later than the work date.\\Confirm that this is the correct date.';
        Text005: Label 'Creating contract invoices...\\';
        Text006: Label 'Service Order is missing.';
        Text009: Label '%1 is missing.';
        Text010: Label '%1 invoices were created.';
        Text011: Label '%1 invoice was created.';
        Cust: Record Customer;
        ServContractHeader: Record "Service Contract Header";
        ServContractAccGr: Record "Service Contract Account Group";
        Currency: Record Currency;
        ContractInvoicingTest: Report "Contract Invoicing";
        ServContractMgt: Codeunit ServContractManagement;
        Window: Dialog;
        InvoicedAmount: Decimal;
        NoOfInvoices: Integer;
        CounterTotal: Integer;
        Counter1: Integer;
        Counter2: Integer;
        CounterBreak: Integer;
        ResultDescription: Text[80];
        InvoiceNo: Code[20];
        LastCustomer: Code[20];
        InvoiceFrom: Date;
        InvoiceTo: Date;
        PostingDate: Date;
        InvoiceToDate: Date;
        LastContractCombined: Boolean;
        CreateInvoices: Option "Create Invoices","Print Only";
        ContractExist: Boolean;
        HideDialog: Boolean;
        SetOptionsCalled: Boolean;

    local procedure CheckIfCombinationExists(FromServContract: Record "Service Contract Header"): Boolean
    var
        ServContract2: Record "Service Contract Header";
    begin
        ServContract2.SetCurrentKey("Customer No.", "Bill-to Customer No.");
        ServContract2.SetFilter("Contract No.", '<>%1', FromServContract."Contract No.");
        ServContract2.SetRange("Customer No.", FromServContract."Customer No.");
        ServContract2.SetRange("Bill-to Customer No.", FromServContract."Bill-to Customer No.");
        exit(ServContract2.FindFirst);
    end;

    procedure SetOptions(NewPostingDate: Date; NewInvoiceToDate: Date; NewCreateInvoices: Option "Create Invoices","Print Only")
    begin
        SetOptionsCalled := true;
        PostingDate := NewPostingDate;
        InvoiceToDate := NewInvoiceToDate;
        CreateInvoices := NewCreateInvoices;
    end;

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterServiceContractHeaderOnPreDataItem(var ServiceContractHeader: Record "Service Contract Header"; PostingDate: Date; InvoiceToDate: Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterServiceContractHeaderOnAfterGetRecord(var ServiceContractHeader: Record "Service Contract Header"; InvoiceNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterServiceContractHeaderOnPostDataItem()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeServiceContractHeaderOnAfterGetRecord(var ServiceContractHeader: Record "Service Contract Header")
    begin
    end;
}

