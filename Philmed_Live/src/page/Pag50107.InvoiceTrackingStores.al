page 50107 "Invoice Tracking Stores"
{
    ApplicationArea = All;
    Caption = 'Invoice Tracking Stores';
    PageType = List;
    SourceTable = "Sales Invoice Tracking Stores";
    SourceTableTemporary = true;
    //SourceTableView = sorting("Invoice No.") order(descending) where("Stores TAT (Mins)" = filter(0), "Entry Time In" = filter(<> 0DT));
    UsageCategory = Lists;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tracker; Tracker)
                {
                    Caption = 'Tracking Executive';
                    ApplicationArea = all;
                    TableRelation = Employee."No.";
                    trigger OnValidate()
                    var
                        Employee: Record Employee;
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking Stores";
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
                                lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '%1', 0);
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
                    var
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking Stores";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();

                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '%1', 0);
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
                        trigger OnValidate()
                        begin
                            if rec."Branch Code" <> BranchCode then
                                Error('This Invoice does not below to the Branch Code %1', BranchCode);
                        end;

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
                    field("Stores Executive"; Rec."Stores Executive")
                    {
                        ToolTip = 'Specifies the value of the Stores Executive field.';
                        ApplicationArea = All;
                    }
                    field("Stores Time In"; Rec."Stores Time In")
                    {
                        ToolTip = 'Specifies the value of the Stores Time In field.';
                        ApplicationArea = All;
                    }
                    field("Stores Time Out"; Rec."Stores Time Out")
                    {
                        ToolTip = 'Specifies the value of the Stores Time Out field.';
                        ApplicationArea = All;
                    }
                    field("Stores TAT (Mins)"; Rec."Stores TAT (Mins)")
                    {
                        ToolTip = 'Specifies the value of the Stores TAT (Mins) field.';
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
                Caption = 'Stores Sign In';
                Image = Timeline;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking Stores";
                begin
                    /*if Rec."Stores Time In" = 0DT then begin
                        If rec."Stores Executive" = '' then
                            Error('Input the Stores Executive First');
                        //Lock Tables
                        Rec.LockTable(true, false);
                        rec."Stores Time In" := CurrentDateTime;
                        rec.Modify();
                    end else
                        Error('This Invoice is already signed in the Stores!');*/

                    lvSalesInvoiceTracking.Reset();
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Stores Executive" = '' then
                            Error('Input the Stores Executive First');
                        if Rec."Stores Time In" <> 0DT then
                            Error('This Invoice is already signed in the Stores!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Stores Executive" := Rec."Stores Executive";
                        lvSalesInvoiceTracking."Stores Time In" := CurrentDateTime;
                        lvSalesInvoiceTracking.Modify();
                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '%1', 0);
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
                Caption = 'Stores Sign Out';
                Image = EndingText;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking Stores";
                    lvSalesInvoiceTrackingConfirm1: Record "Sales Inv. Tracking Confirm 1";
                begin
                    /*if Rec."Stores Time Out" = 0DT then begin
                        If rec."Stores Executive" = '' then
                            Error('Input the Stores Executive First');

                        If rec."Stores Time In" = 0DT then
                            Error('Sign in the Invoice First');

                        //Lock Tables
                        Rec.LockTable(true, false);
                        rec."Stores Time Out" := CurrentDateTime;
                        rec."Stores TAT (Mins)" := (Rec."Stores Time Out" - rec."Stores Time In") / 60000;
                        rec.Modify();
                    end else
                        Error('This Invoice is already signed out from the Stores!');*/

                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        If rec."Stores Executive" = '' then
                            Error('Input the Stores Executive First');
                        If rec."Stores Time In" = 0DT then
                            Error('Sign in the Invoice First');
                        if Rec."Stores Time Out" <> 0DT then
                            Error('This Invoice is already signed out from the Stores!');

                        //Lock Tables
                        //lvSalesInvoiceTracking.LockTable(true, false);
                        lvSalesInvoiceTracking."Stores Executive" := Rec."Stores Executive";
                        lvSalesInvoiceTracking."Stores Time Out" := CurrentDateTime;
                        lvSalesInvoiceTracking."Stores TAT (Mins)" := (CurrentDateTime - rec."Stores Time In") / 60000;
                        lvSalesInvoiceTracking.Modify();

                        lvSalesInvoiceTrackingConfirm1.Init();
                        lvSalesInvoiceTrackingConfirm1.TransferFields(lvSalesInvoiceTracking);
                        lvSalesInvoiceTrackingConfirm1.Insert();

                        lvSalesInvoiceTracking.Delete();

                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '%1', 0);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                    if lvSalesInvoiceTracking.FindFirst() then
                        repeat
                            Rec.Init();
                            Rec := lvSalesInvoiceTracking;
                            Rec.Insert();
                        until lvSalesInvoiceTracking.Next() = 0;

                end;
            }
            action(ViewTodaysStoreCheckIn)
            {

                Caption = 'View Todays Stores Check Ins';
                Image = Check;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingStores: page "Invoice Tracking Stores List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("Stores Time In", '<>%1', 0DT);
                    pgTrackingStores.SetTableView(lvSalesInvoiceTracking);
                    pgTrackingStores.Run();


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
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking Stores";
                begin
                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();

                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Stores TAT (Mins)", '%1', 0);
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
        Rec.SetFilter("Stores TAT (Mins)", '%1', 0);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        //CurrPage.Update();
        CurrPage.Activate(true);*/
    end;
}
