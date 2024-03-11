page 50112 "cr Transaction Types"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "cr transaction types table";

    layout
    {
        area(Content)
        {
            group("Transaction Type Details")
            {
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Loan Type"; Rec."Loan Type")
                {

                }
                field("Fosa Transaction"; Rec."Fosa Transaction")
                {

                }
                field("Global Transaction Type"; Rec."Global Transaction Type")
                {

                }
                field("Contra Global Transaction Type"; Rec."Contra Global Transaction Type")
                {

                }
                field("Account No"; Rec."Account No")
                {

                }
                field("Recovery Since Founding Date"; Rec."Recovery Since Founding Date")
                {

                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {

                }
                field("Activity Code"; Rec."Activity Code")
                {

                }
                field("Minimum Contribution"; Rec."Minimum Contribution")
                {

                }
                field("Unallocated Funds Account"; Rec."Unallocated Funds Account")
                {

                }
                field("USSD Account"; Rec."USSD Account")
                {

                }
                field("Show on Receipt"; Rec."Show on Receipt")
                {

                }
                field("Show on Accruals"; Rec."Show on Accruals")
                {

                }
                field("Show on Checkoff Advice"; Rec."Show on Checkoff Advice")
                {

                }
                field("Show on pv"; Rec."Show on pv")

                {

                }
                field("Process Checkoff"; Rec."Process Checkoff")
                {

                }
                field("Takes Balance"; Rec."Takes Balance")
                {

                }
                field("Appears in Transaction report"; Rec."Appears in Transaction report")
                {

                }
                field(Chargeable; Rec.Chargeable)
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