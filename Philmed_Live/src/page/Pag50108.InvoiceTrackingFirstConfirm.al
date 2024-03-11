page 50108 "Invoice Tracking First Confirm"
{
    Caption = 'Invoice Tracking First Confirm';
    PageType = List;
    SourceTable = "Sales Inv. Tracking Confirm 1";
    SourceTableTemporary = true;
    //SourceTableView = sorting("Invoice No.") order(descending) where("First Confirm. TAT (Mins)" = filter(0), "Entry Time In" = filter(<> 0DT));
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

                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 1";
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
                                lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
                                lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '<>%1', 0);
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
                        lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 1";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();

                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
                        lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '<>%1', 0);
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
                    field("First Confirm. Executive"; Rec."First Confirm. Executive")
                    {
                        ApplicationArea = all;
                    }
                    field("First Confirmation Time In"; Rec."First Confirmation Time In")
                    {
                        ApplicationArea = all;
                    }
                    field("First Confirmation Time Out"; Rec."First Confirmation Time Out")
                    {
                        ApplicationArea = all;
                    }
                    field("First Confirm. TAT (Mins)"; Rec."First Confirm. TAT (Mins)")
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
                Caption = 'First Confirmation Sign In';
                Image = Timeline;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 1";

                begin
                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."First Confirm. Executive" = '' then
                            Error('Input the First Confirmation Executive First!');
                        if Rec."First Confirmation Time In" <> 0DT then
                            Error('This Invoice is already signed in the First Confirmation!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."First Confirm. Executive" := Rec."First Confirm. Executive";
                        lvSalesInvoiceTracking."First Confirmation Time In" := CurrentDateTime;
                        lvSalesInvoiceTracking.Modify();

                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '<>%1', 0);
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
                Caption = 'First Confirmation Sign Out';
                Image = EndingText;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 1";
                    //lvSalesInvoiceTrackingConfirm2: Record "Sales Inv. Tracking Confirm 2";
                    lvSalesInvoiceTrackingDispatch: Record "Sales Inv. Tracking Dispatch";
                begin
                    /* if Rec."First Confirmation Time Out" = 0DT then begin
                         If rec."First Confirm. Executive" = '' then
                             Error('Input the First Confirmation Executive First');

                         If rec."First Confirmation Time In" = 0DT then
                             Error('Sign in the Invoice First');
                         //Lock Tables
                         Rec.LockTable(true, false);
                         rec."First Confirmation Time Out" := CurrentDateTime;
                         rec."First Confirm. TAT (Mins)" := (Rec."First Confirmation Time Out" - rec."First Confirmation Time In") / 60000;
                         rec.Modify();
                     end else
                         Error('This Invoice is already signed out from the First Confirmation!');
                    */

                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."First Confirm. Executive" = '' then
                            Error('Input the First Confirmation Executive First!');
                        If rec."First Confirmation Time In" = 0DT then
                            Error('Sign in the Invoice First');
                        if Rec."First Confirmation Time Out" <> 0DT then
                            Error('This Invoice is already signed out from the First Confirmation!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."First Confirmation Time Out" := CurrentDateTime;
                        lvSalesInvoiceTracking."First Confirm. TAT (Mins)" := (CurrentDateTime - rec."First Confirmation Time In") / 60000;
                        lvSalesInvoiceTracking.Modify();

                        /*lvSalesInvoiceTrackingConfirm2.Init();
                        lvSalesInvoiceTrackingConfirm2.TransferFields(lvSalesInvoiceTracking);
                        lvSalesInvoiceTrackingConfirm2.Insert();

                        lvSalesInvoiceTracking.Delete();*/

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
                    lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '<>%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                    if lvSalesInvoiceTracking.FindFirst() then
                        repeat
                            Rec.Init();
                            Rec := lvSalesInvoiceTracking;
                            Rec.Insert();
                        until lvSalesInvoiceTracking.Next() = 0;
                end;
            }
            action(ViewTodaysFirstConfirm)
            {

                Caption = 'View Todays First Confirmation';
                Image = Check;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingList: page "Tracking First Confirm List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("First Confirmation Time In", '<>%1', 0DT);
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
                    lvSalesInvoiceTracking: Record "Sales Inv. Tracking Confirm 1";
                begin
                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '<>%1', 0);
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
        rec.SetFilter("First Confirm. TAT (Mins)", '%1', 0);
        rec.SetFilter("Stores TAT (Mins)", '<>%1', 0);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        //CurrPage.Update();
        CurrPage.Activate(true);*/
    end;
}
