page 50164 "Disbursement List(Pending)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Disbursement";
    Editable = false;
    CardPageId = "Disbursement Card(Pending)";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Posted = const(false), Status = const("Pending Approval"));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client No"; Rec."Client No")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field("Approval Date"; Rec."Approval Date")
                {

                }
                field("Approved Amount"; Rec."Approved Amount")
                {

                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Editable = false;
                }
                field("Balance Outstanding"; Rec."Balance Outstanding")
                {
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {

                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Booked By"; Rec."Booked By")
                {
                    Editable = false;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {

                }
                field("Cheque No/Reference No"; Rec."Cheque No/Reference No")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}