page 50121 "Reset Invoice Tracking"
{
    ApplicationArea = All;
    Caption = 'Reset Invoice Tracking';
    PageType = List;
    SourceTable = "Sales Invoice Tracking";
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
                field(BranchCode; BranchCode)
                {
                    Caption = 'Branch Code';
                    ApplicationArea = all;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = filter(1));
                    trigger OnValidate()
                    begin
                        rec.SetFilter("Branch Code", BranchCode);
                        Rec.SetFilter("Entry Time In", '%1', 0DT);
                        CurrPage.Update();
                    end;
                }
                field(NewInvoiceNo; NewInvoiceNo)
                {
                    Caption = 'Enter Sales Invoice No.';
                    ApplicationArea = all;
                    TableRelation = "Sales Invoice Tracking"."Invoice No.";
                    trigger OnValidate()
                    Var
                        lvSalesInvoiceHeader: Record "Sales Invoice Header";
                        lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
                    begin

                        lvSalesInvoiceHeader.Get(NewInvoiceNo);
                        if lvSalesInvoiceHeader."Shortcut Dimension 1 Code" <> BranchCode then
                            Error('This Invoice does not belong to the Branch Code %1', BranchCode);


                    end;

                }
            }

        }
    }
    actions
    {
        area(Processing)
        {

            action(ResetInvoiceTracking)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reset Invoice Tracking';
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    InvoiceTracking: Record "Sales Invoice Tracking";
                    ActiveSession: Record "Active Session";
                    ComputerName: Code[50];
                begin
                    if NewInvoiceNo <> '' then begin
                        If NOT Confirm('Are you sure you want to reset the Tracking of this Invoice?') then
                            exit;
                        ComputerName := '';
                        ActiveSession.RESET;
                        ActiveSession.SETRANGE("Session ID", SESSIONID);
                        IF ActiveSession.FINDFIRST THEN
                            ComputerName := ActiveSession."Client Computer Name";

                        InvoiceTracking.Get(NewInvoiceNo);
                        InvoiceTracking.Delete();

                        Rec.Init();
                        Rec.Validate("Invoice No.", NewInvoiceNo);
                        Rec."Reset By User ID" := UserId;
                        Rec."Reset Date" := CurrentDateTime;
                        Rec."Reset Host" := ComputerName;
                        Rec.Insert(true);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
    var
        BranchCode: Code[20];
        NewInvoiceNo: Code[20];
        Tracker: Code[20];

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Allow Reset Invoice Tracking" then
            Error('You have no rights to reset an Invoice Tracking Entry!');
    end;
}
