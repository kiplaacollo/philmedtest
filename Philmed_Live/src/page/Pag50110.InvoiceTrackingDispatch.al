page 50110 "Invoice Tracking Dispatch"
{
    Caption = 'Invoice Tracking Dispatch';
    PageType = List;
    SourceTable = "Sales Inv. Tracking Dispatch";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tracker; Tracker)
                {
                    Caption = 'Tracking Executive';
                    TableRelation = Employee."No.";
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        Employee: Record Employee;
                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Dispatch";
                    begin
                        If Tracker <> '' then begin
                            Employee.Get(Tracker);
                            if Employee."Global Dimension 1 Code" <> '' then begin
                                BranchCode := Employee."Global Dimension 1 Code";

                                lvSalesInvoiceTracking.Reset();
                                Rec.Reset();
                                If rec.FindSet() then
                                    rec.DeleteAll();

                                lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                                lvSalesInvoiceTracking.SetFilter("Dispatch Time", '%1', 0DT);
                                //lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '<>%1', 0);
                                lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '<>%1', 0);
                                lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                                if lvSalesInvoiceTracking.FindFirst() then
                                    repeat
                                        Rec.Init();
                                        Rec := lvSalesInvoiceTracking;
                                        Rec.Insert();
                                    until lvSalesInvoiceTracking.Next() = 0;
                            end;
                        end;

                    end;
                }
                field(BranchCode; BranchCode)
                {
                    Caption = 'Branch Code';
                    ApplicationArea = all;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = filter(1));
                    trigger OnValidate()
                    Var
                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Dispatch";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();

                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("Dispatch Time", '%1', 0DT);
                        //lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '<>%1', 0);
                        lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '<>%1', 0);
                        lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                        if lvSalesInvoiceTracking.FindFirst() then
                            repeat
                                Rec.Init();
                                Rec := lvSalesInvoiceTracking;
                                Rec.Insert();
                            until lvSalesInvoiceTracking.Next() = 0;
                    end;
                }
            }
            group(Lines)
            {
                repeater(Line)
                {
                    field("Invoice No."; Rec."Invoice No.")
                    {
                        ToolTip = 'Specifies the value of the Invoice No. field.';
                        Editable = false;
                        ApplicationArea = all;
                    }
                    field("Customer No."; Rec."Customer No.")
                    {
                        ToolTip = 'Specifies the value of the Customer No. field.';
                        ApplicationArea = all;
                    }
                    field("Customer Name"; Rec."Customer Name")
                    {
                        ToolTip = 'Specifies the value of the Customer Name field.';
                        ApplicationArea = all;
                    }
                    field("No. of Lines"; Rec."No. of Lines")
                    {
                        ToolTip = 'Specifies the value of the No. of Lines field.';
                        ApplicationArea = all;
                    }
                    field("Amount Including VAT"; Rec."Amount Including VAT")
                    {
                        ToolTip = 'Specifies the value of the Amount Including VAT field.';
                        ApplicationArea = All;
                    }
                    field(Rider; Rec.Rider)
                    {
                        ApplicationArea = all;
                    }
                    field("Dispatch Personnel"; Rec."Dispatch Personnel")
                    {
                        ApplicationArea = all;
                    }
                    field("Trip No."; Rec."Trip No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Route Plan"; Rec."Route Plan")
                    {
                        ApplicationArea = all;
                    }
                    field("Dispatch Time"; Rec."Dispatch Time")
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(Dispatch)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dispatch Invoice';
                Image = EndingText;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Dispatch";
                    lvSalesInvoiceTrackingMaster: Record "Sales Invoice Tracking";
                begin
                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Dispatch Personnel" = '' then
                            Error('Input the Dispatch Personnel First');

                        If rec."Trip No." = 0 then
                            Error('Input the Trip No.');
                        If rec.Rider = '' then
                            Error('Input the Rider');
                        If rec."Route Plan" = '' then
                            Error('Input the Route Plan');
                        if Rec."Dispatch Time" <> 0DT then
                            Error('This Invoice is already Dispatched!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Dispatch Personnel" := rec."Dispatch Personnel";
                        lvSalesInvoiceTracking."Trip No." := rec."Trip No.";
                        lvSalesInvoiceTracking."Route Plan" := rec."Route Plan";
                        lvSalesInvoiceTracking.Rider := rec.Rider;
                        lvSalesInvoiceTracking."Dispatch Time" := CurrentDateTime;
                        lvSalesInvoiceTracking."Overall TAT(Hours)" := (CurrentDateTime - rec."Entry Time In") / 3600000;

                        lvSalesInvoiceTracking.Modify();

                        lvSalesInvoiceTrackingMaster.SetRange("Invoice No.", Rec."Invoice No.");
                        If lvSalesInvoiceTrackingMaster.FindFirst() then
                            lvSalesInvoiceTrackingMaster.Delete();

                        lvSalesInvoiceTrackingMaster.Init();
                        lvSalesInvoiceTrackingMaster.TransferFields(lvSalesInvoiceTracking);
                        lvSalesInvoiceTrackingMaster.Insert();

                        lvSalesInvoiceTracking.Delete();

                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Dispatch Time", '%1', 0DT);
                    //lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '<>%1', 0);
                    lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '<>%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                    if lvSalesInvoiceTracking.FindFirst() then
                        repeat
                            Rec.Init();
                            Rec := lvSalesInvoiceTracking;
                            Rec.Insert();
                        until lvSalesInvoiceTracking.Next() = 0;
                end;
            }
            action(ViewTodaysList)
            {

                Caption = 'View Todays Dispatch List';
                ApplicationArea = Basic, Suite;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingList: page "Invoice Tracking Dispatch List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("Dispatch Time", '<>%1', 0DT);
                    pgTrackingList.SetTableView(lvSalesInvoiceTracking);
                    pgTrackingList.Run();

                end;
            }
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Dispatch";
                begin
                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Dispatch Time", '%1', 0DT);
                    //lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '<>%1', 0);
                    lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '<>%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                    if lvSalesInvoiceTracking.FindFirst() then
                        repeat
                            Rec.Init();
                            Rec := lvSalesInvoiceTracking;
                            Rec.Insert();
                        until lvSalesInvoiceTracking.Next() = 0;

                end;
            }
            action(DispatchSheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Dispatch Sheet';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DispatchSheet: Report "Dispatch Sheet Summary";
                    InvoiceTracking: Record "Sales Invoice Tracking";
                begin
                    InvoiceTracking.SetFilter("Posting Date", '%1', Today);
                    DispatchSheet.SetTableView(InvoiceTracking);
                    DispatchSheet.Run();
                end;
            }
            action(DispatchSheetSmall)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Dispatch Sheet - Small';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DispatchSheet: Report DispatchSheetSummarySmall;
                    InvoiceTracking: Record "Sales Invoice Tracking";
                begin
                    InvoiceTracking.SetFilter("Posting Date", '%1', Today);
                    DispatchSheet.SetTableView(InvoiceTracking);
                    DispatchSheet.Run();
                end;
            }
        }
    }
    var
        BranchCode: Code[20];
        Tracker: Code[20];

    trigger OnOpenPage()
    begin
        /*rec.SetFilter("Branch Code", 'BranchCode');
        rec.SetFilter("Dispatch Time", '%1', 0DT);
        rec.SetFilter("Second Confirm. TAT (Mins)", '<>%1', 0);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        //CurrPage.Update();
        CurrPage.Activate(true);*/
    end;
}
