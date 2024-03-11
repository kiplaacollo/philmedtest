page 50032 "Funds Transfer Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field("Bank Balance"; Rec."Bank Balance")
                {

                }
                field("Bank Balance(LCY)"; Rec."Bank Balance(LCY)")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Amount to Receive"; Rec."Amount to Receive")
                {

                }
                field("Amount to Receive(LCY)"; Rec."Amount to Receive(LCY)")
                {

                }
                field("External Doc No."; Rec."External Doc No.")
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ObjFtransfer.Reset();
        ObjFtransfer.SetRange(ObjFtransfer."Cheque/Doc. No", Rec."Document No");
        if ObjFtransfer.Find('-') then begin
            Rec."External Doc No." := ObjFtransfer."Cheque/Doc. No";
        end;
    end;

    var
        myInt: Integer;
        ObjFtransfer: Record "Funds Transfer Header";
}