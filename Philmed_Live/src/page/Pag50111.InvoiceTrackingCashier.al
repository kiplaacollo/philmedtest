page 50111 "Invoice Tracking Cashier"
{
    Caption = 'Invoice Tracking Cashier';
    PageType = List;
    SourceTable = "Sales Invoice Tracking";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    InsertAllowed = false;
    //SourceTableView = sorting("Invoice No.") order(descending) where("Posting Date" = filter(today), "Entry Time In" = filter(<> 0DT));
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
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
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
                                lvSalesInvoiceTracking.SetFilter("Dispatch Time", '<>%1', 0DT);
                                lvSalesInvoiceTracking.SetRange(Cleared, False);
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
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();

                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("Dispatch Time", '<>%1', 0DT);
                        lvSalesInvoiceTracking.SetRange(Cleared, False);
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
                        Editable = false;
                        ApplicationArea = all;
                    }
                    field("Cashier Name"; Rec."Cashier Name")
                    {
                        ApplicationArea = all;
                    }
                    field("Payment Amount"; Rec."Payment Amount")
                    {
                        ApplicationArea = all;
                    }
                    field("Credit Memo Amount"; Rec."Credit Memo Amount")
                    {
                        ApplicationArea = all;
                    }
                    field(Dev; Rec.Dev)
                    {
                        ApplicationArea = all;
                    }
                    field("Clearing Comments"; Rec."Clearing Comments")
                    {
                        ApplicationArea = all;
                    }
                    field(Cleared; Rec.Cleared)
                    {
                        Editable = false;
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

            action(ClearInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Invoice';
                Image = EndingText;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                begin
                    /* if Rec."Cashier Clearing Time" = 0DT then begin
                         If rec."Cashier Name" = '' then
                             Error('Input the Cashier Name First');
                         //Lock Tables
                         Rec.LockTable(true, false);
                         rec."Cashier Clearing Time" := CurrentDateTime;
                         rec.Cleared := true;
                         rec.Modify();
                     end else
                         Error('This Invoice is already Cleared!');*/

                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Cashier Name" = '' then
                            Error('Input the Cashier Name First');

                        if Rec."Cashier Clearing Time" <> 0DT then
                            Error('This Invoice is already Cleared!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Cashier Name" := rec."Cashier Name";
                        lvSalesInvoiceTracking."Payment Amount" := rec."Payment Amount";
                        lvSalesInvoiceTracking."Credit Memo Amount" := rec."Credit Memo Amount";
                        lvSalesInvoiceTracking.Dev := rec.Dev;
                        lvSalesInvoiceTracking."Clearing Comments" := rec."Clearing Comments";
                        lvSalesInvoiceTracking."Cashier Clearing Time" := CurrentDateTime;
                        lvSalesInvoiceTracking.Cleared := true;

                        lvSalesInvoiceTracking.Modify();
                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Dispatch Time", '<>%1', 0DT);
                    lvSalesInvoiceTracking.SetRange(Cleared, False);
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

                Caption = 'View Todays Cashier List';
                ApplicationArea = Basic, Suite;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingList: page "Invoice Tracking Cashier List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    //lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("Cashier Clearing Time", '<>%1', 0DT);
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
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                begin
                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Dispatch Time", '<>%1', 0DT);
                    lvSalesInvoiceTracking.SetRange(Cleared, False);
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
    }
    var
        BranchCode: Code[20];
        Tracker: Code[20];

    trigger OnOpenPage()
    begin
        /*rec.SetFilter("Branch Code", 'BranchCode');
        rec.SetFilter("Dispatch Time", '<>%1', 0DT);
        rec.SetRange(Cleared, False);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        //CurrPage.Update();
        CurrPage.Activate(true);*/
    end;
}
