page 50186 "Collateral Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Collateral Register";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    Visible = false;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {

                }
                field("Registration No"; Rec."Registration No")
                {
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Registered To"; Rec."Registered To")
                {
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field(Value; Rec.Value)
                {
                    Visible = false;
                }
                field("New Book Value"; Rec."New Book Value")
                {
                    Caption = 'Book Value';
                }
                field(Code; Rec.Code)
                {
                    ShowMandatory = true;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {

                }
                field("Guarantee Value"; Rec."Guarantee Value")
                {
                    Editable = false;
                    Caption = 'Discounted Value';
                }
                field("Security Details"; Rec."Security Details")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field("Assesment Done"; Rec."Assesment Done")
                {

                }
                field("Title Deed No."; Rec."Title Deed No.")
                {

                }
                field("New Comitted Collateral Value"; Rec."New Comitted Collateral Value")
                {
                    Caption = 'Comitted Collateral Value';
                    Editable = false;
                }
                field("Free Collateral"; Rec."Free Collateral")
                {
                    Editable = false;
                }
                field("Valuation Type"; Rec."Valuation Type")
                {

                }
                field("Appreciation/Depreciation %"; Rec."Appreciation/Depreciation %")
                {

                }

            }
            group("Other Details")
            {
                field("Vehicle Make"; Rec."Vehicle Make")
                {

                }
                field("Collateral Type"; Rec."Collateral Type")
                {

                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {

                }
                field("Insurance Type"; Rec."Insurance Type")
                {

                }
                field("Insurance Provider"; Rec."Insurance Provider")
                {

                }
                field("Commencing Date"; Rec."Commencing Date")
                {

                }
                field("Expiry Date"; Rec."Expiry Date")
                {

                }
                field(Owner; Rec.Owner)
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Missing Documents"; Rec."Missing Documents")
                {

                }
                field("Contact No."; Rec."Contact No.")
                {

                }
                field("Email Address"; Rec."Email Address")
                {

                }
                field("Title Contents"; Rec."Title Contents")
                {

                }
                field("Date Released"; Rec."Date Released")
                {

                }
                field("Date Charged"; Rec."Date Charged")
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