page 50109 "Invoice Track Second Confirm"
{
    Caption = 'Invoice Track Second Confirm';
    PageType = List;
    SourceTable = "Sales Inv. Tracking Confirm 2";
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
                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 2";
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
                                lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
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
                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 2";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();

                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
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
                    field("Second Confirm. Executive"; rec."Second Confirm. Executive")
                    {
                        ApplicationArea = all;
                    }
                    field("Second Confirm. Time In"; rec."Second Confirm. Time In")
                    {
                        ApplicationArea = all;
                    }
                    field("Second Confirm. Time Out"; rec."Second Confirm. Time Out")
                    {
                        ApplicationArea = all;
                    }
                    field("Second Confirm. TAT (Mins)"; Rec."Second Confirm. TAT (Mins)")
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

            action(SignInInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Second Confirmation Sign In';
                Image = Timeline;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 2";
                begin
                    /*if Rec."Second Confirm. Time In" = 0DT then begin
                        If rec."Second Confirm. Executive" = '' then
                            Error('Input the Second Confirmation Executive First!');
                        //Lock Tables
                        Rec.LockTable(true, false);
                        rec."Second Confirm. Time In" := CurrentDateTime;
                        rec.Modify();
                    end else
                        Error('This Invoice is already signed in the Second Confirmation!');*/

                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Second Confirm. Executive" = '' then
                            Error('Input the Second Confirmation Executive First!');
                        if Rec."Second Confirm. Time In" <> 0DT then
                            Error('This Invoice is already signed in the Second Confirmation!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Second Confirm. Executive" := rec."Second Confirm. Executive";
                        lvSalesInvoiceTracking."Second Confirm. Time In" := CurrentDateTime;
                        lvSalesInvoiceTracking.Modify();
                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
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
            action(SignoutInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Second Confirmation Sign Out';
                Image = EndingText;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 2";
                    lvSalesInvoiceTrackingDispatch: Record "Sales Inv. Tracking Dispatch";
                begin
                    /*if Rec."Second Confirm. Time Out" = 0DT then begin
                        If rec."Second Confirm. Executive" = '' then
                            Error('Input the Second Confirmation Executive First');

                        If rec."Second Confirm. Time In" = 0DT then
                            Error('Sign in the Invoice First');
                        //Lock Tables
                        Rec.LockTable(true, false);
                        rec."Second Confirm. Time Out" := CurrentDateTime;
                        rec."Second Confirm. TAT (Mins)" := (Rec."Second Confirm. Time Out" - rec."Second Confirm. Time In") / 60000;
                        rec.Modify();
                    end else
                        Error('This Invoice is already signed out from the Second Confirmation!');*/

                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Second Confirm. Executive" = '' then
                            Error('Input the Second Confirmation Executive First');
                        If rec."Second Confirm. Time In" = 0DT then
                            Error('Sign in the Invoice First');
                        if Rec."Second Confirm. Time Out" <> 0DT then
                            Error('This Invoice is already signed out from the Second Confirmation!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Second Confirm. Time Out" := CurrentDateTime;
                        lvSalesInvoiceTracking."Second Confirm. TAT (Mins)" := (CurrentDateTime - rec."Second Confirm. Time In") / 60000;
                        lvSalesInvoiceTracking.Modify();

                        lvSalesInvoiceTrackingDispatch.Init();
                        lvSalesInvoiceTrackingDispatch.TransferFields(lvSalesInvoiceTracking);
                        lvSalesInvoiceTrackingDispatch.Insert();

                        lvSalesInvoiceTracking.Delete();
                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
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

                Caption = 'View Todays Second Confirmation';
                ApplicationArea = Basic, Suite;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingList: page "Tracking Second Confirm List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("Second Confirm. Time In", '<>%1', 0DT);
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
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 2";
                begin
                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
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
    }
    var
        BranchCode: Code[20];
        Tracker: Code[20];

    trigger OnOpenPage()
    begin
        /*rec.SetFilter("Branch Code", 'BranchCode');
        rec.SetFilter("Second Confirm. TAT (Mins)", '%1', 0);
        rec.SetFilter("First Confirm. TAT (Mins)", '<>%1', 0);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        //CurrPage.Update();
        CurrPage.Activate(true);*/
    end;
}
