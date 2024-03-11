page 50106 "Invoice Tracking Entry"
{
    Caption = 'Invoice Tracking Entry';
    PageType = List;
    SourceTable = "Sales Invoice Tracking Entry";
    SourceTableTemporary = true;
    //SourceTableView = sorting("Invoice No.") order(descending) where("Entry Time In" = filter(0DT));
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = true;

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
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking Entry";
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
                                lvSalesInvoiceTracking.SetFilter("Entry Time In", '%1', 0DT);
                                if lvSalesInvoiceTracking.FindFirst() then
                                    repeat
                                        Rec.Init();
                                        Rec := lvSalesInvoiceTracking;
                                        Rec.Insert();
                                    until lvSalesInvoiceTracking.Next() = 0;

                                //CurrPage.Update();
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
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking Entry";
                    begin
                        lvSalesInvoiceTracking.Reset();
                        Rec.Reset();
                        If rec.FindSet() then
                            rec.DeleteAll();
                        lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                        lvSalesInvoiceTracking.SetFilter("Entry Time In", '%1', 0DT);
                        if lvSalesInvoiceTracking.FindFirst() then
                            repeat
                                Rec.Init();
                                Rec := lvSalesInvoiceTracking;
                                Rec.Insert();
                            until lvSalesInvoiceTracking.Next() = 0;
                        //CurrPage.Update();
                    end;
                }
                field(NewInvoiceNo; NewInvoiceNo)
                {
                    Caption = 'Enter Sales Invoice No.';
                    ApplicationArea = all;
                    //TableRelation = "Sales Invoice Header"."No.";//WHERE( = field("Branch Code"));
                    trigger OnValidate()
                    Var
                        lvSalesInvoiceHeader: Record "Sales Invoice Header";
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking Entry";
                        lvSalesInvoiceTrackingMaster: Record "Sales Invoice Tracking";
                    begin
                        If NewInvoiceNo <> '' then begin
                            If lvSalesInvoiceTracking.Get(NewInvoiceNo) then
                                Error('This Invoice is already logged for Tracking  on %1', lvSalesInvoiceTracking."Entry Time In");

                            //Master Tracking Table
                            If lvSalesInvoiceTrackingMaster.Get(NewInvoiceNo) then
                                Error('This Invoice is already logged for Tracking  on %1', lvSalesInvoiceTrackingMaster."Entry Time In");

                            lvSalesInvoiceHeader.Get(NewInvoiceNo);
                            if lvSalesInvoiceHeader."Shortcut Dimension 1 Code" <> BranchCode then
                                Error('This Invoice does not belong to the Branch Code %1', BranchCode);

                            //lvSalesInvoiceTracking.LockTable(true, false);
                            lvSalesInvoiceTracking.Init();
                            lvSalesInvoiceTracking."Invoice No." := NewInvoiceNo;
                            lvSalesInvoiceTracking.Validate("Invoice No.");
                            lvSalesInvoiceTracking.Insert(true);

                            //Log in Master Table                            
                            lvSalesInvoiceTrackingMaster.Init();
                            lvSalesInvoiceTrackingMaster."Invoice No." := NewInvoiceNo;
                            lvSalesInvoiceTrackingMaster.Validate("Invoice No.");
                            lvSalesInvoiceTrackingMaster.Insert(true);

                            lvSalesInvoiceTracking.Reset();
                            Rec.Reset();
                            If rec.FindSet() then
                                rec.DeleteAll();
                            lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                            lvSalesInvoiceTracking.SetFilter("Entry Time In", '%1', 0DT);
                            if lvSalesInvoiceTracking.FindFirst() then
                                repeat
                                    Rec.Init();
                                    Rec := lvSalesInvoiceTracking;
                                    Rec.Insert();
                                until lvSalesInvoiceTracking.Next() = 0;
                            //CurrPage.Update();
                        end;

                    end;
                }
            }
            group(Lines)
            {
                repeater(Line)
                {
                    field("Invoice No."; Rec."Invoice No.")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the Invoice No. field.';
                        trigger OnValidate()
                        begin
                            if rec."Branch Code" <> BranchCode then
                                Error('This Invoice does not belong to the Branch Code %1', BranchCode);
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
                    field("Branch Code"; Rec."Branch Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Route Plan"; Rec."Route Plan")
                    {
                        ApplicationArea = all;
                    }
                    field("Entry Time In"; Rec."Entry Time In")
                    {
                        ApplicationArea = all;
                    }
                    field("Reset Date"; Rec."Reset Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Reset Host"; Rec."Reset Host")
                    {
                        ApplicationArea = all;
                    }
                    field("Reset By User ID"; Rec."Reset By User ID")
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

            action(CheckIn)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check In';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking Entry";
                    lvSalesInvoiceTrackingStores: Record "Sales Invoice Tracking Stores";
                begin
                    lvSalesInvoiceTracking.SetRange("Invoice No.", Rec."Invoice No.");
                    If lvSalesInvoiceTracking.FindFirst() then begin
                        lvSalesInvoiceTracking."Entry Time In" := CurrentDateTime;
                        lvSalesInvoiceTracking.Modify();

                        lvSalesInvoiceTrackingStores.Init();
                        lvSalesInvoiceTrackingStores.TransferFields(lvSalesInvoiceTracking);
                        lvSalesInvoiceTrackingStores.Insert();

                        lvSalesInvoiceTracking.Delete();
                    end;

                    lvSalesInvoiceTracking.Reset();
                    Rec.Reset();
                    If rec.FindSet() then
                        rec.DeleteAll();
                    lvSalesInvoiceTracking.SetFilter("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '%1', 0DT);
                    if lvSalesInvoiceTracking.FindFirst() then
                        repeat
                            Rec.Init();
                            Rec := lvSalesInvoiceTracking;
                            Rec.Insert();
                        until lvSalesInvoiceTracking.Next() = 0;

                end;
            }
            action(ViewTodaysCheckIn)
            {

                Caption = 'View Todays Check Ins';
                Image = Check;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    pgTrackingEntry: page "Invoice Tracking Entry List";
                begin
                    If BranchCode = '' then
                        Error('Select the Branch Code');
                    lvSalesInvoiceTracking.SetRange("Branch Code", BranchCode);
                    lvSalesInvoiceTracking.SetRange("Posting Date", Today);
                    lvSalesInvoiceTracking.SetFilter("Entry Time In", '<>%1', 0DT);
                    pgTrackingEntry.SetTableView(lvSalesInvoiceTracking);
                    pgTrackingEntry.Run();


                end;
            }

        }
    }
    var
        BranchCode: Code[20];
        NewInvoiceNo: Code[20];
        Tracker: Code[20];

    trigger OnOpenPage()
    begin
        /*rec.SetFilter("Branch Code", 'BranchCode');
        Rec.SetFilter("Entry Time In", '%1', 0DT); 
        CurrPage.Update();*/
    end;
}
