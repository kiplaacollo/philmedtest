page 50143 "Loans Card(Pending)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    SourceTableView = where("Approval Status" = const("Pending Approval"));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                Editable = false;
                field("Loan Number"; Rec."Loan Number")
                {
                    Visible = false;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Importance = Promoted;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Importance = Promoted;
                }
                field("ID Number"; Rec."ID Number")
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {

                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    Importance = Additional;
                }
                field("RM Code"; Rec."RM Code")
                {

                }
                field("RM Name"; Rec."RM Name")
                {
                    Editable = false;
                }
            }
            group("Loan Information")
            {
                Editable = false;
                field("Loan Product"; Rec."Loan Product")
                {
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field(Installments; Rec.Installments)
                {

                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {

                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {

                }
                field("Deposits Factor"; Rec."Deposits Factor")
                {

                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    Importance = Promoted;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Importance = Promoted;
                }
                field("Credit Life Type"; Rec."Credit Life Type")
                {

                }
                field("Credit Life Rate"; Rec."Credit Life Rate")
                {

                }
                field("Total Offset Amount"; Rec."Total Offset Amount")
                {

                }
                field("Total Upfront Deductions"; Rec."Total Upfront Deductions")
                {

                }
                field("New Collateral Amount"; Rec."New Collateral Amount")
                {
                    Importance = Additional;
                }
            }
            group("Loans Collateral")
            {
                part(loancollateral; "Loan Collateral Security")
                {
                    SubPageLink = "Loan No" = field("Loan Number");
                    Editable = false;
                }
            }
            group("Guarantor Details")
            {
                part(GuarantorDetails; "Guarantors(New)")
                {
                    SubPageLink = "Loan Number" = field("Loan Number");
                }
            }
            group("Credit Ratios")
            {
                Visible = false;
                Editable = false;
                field("Fee Collection Rate(%)"; Rec."Fee Collection Rate(%)")
                {

                }
                field("Maximum Possible DBR(%)"; Rec."Maximum Possible DBR(%)")
                {

                }
                field("Profitability Margin(%)"; Rec."Profitability Margin(%)")
                {

                }
                field("Appraised Obligations Monthly"; Rec."Appraised Obligations Monthly")
                {

                }
            }
            group("Bank Details")
            {
                Visible = false;
                Editable = false;
                group("Main Bank")
                {
                    field("Bank Code"; Rec."Bank Code")
                    {

                    }
                    field("Bank Name"; Rec."Bank Name")
                    {

                    }
                    field("Bank Branch"; Rec."Bank Branch")
                    {

                    }
                    field("Bank Branch Name"; Rec."Bank Branch Name")
                    {

                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {

                    }
                    field("Swift Code"; Rec."Swift Code")
                    {

                    }
                }
                group("Alternative Bank")
                {
                    field("Bank Code 2"; Rec."Bank Code 2")
                    {

                    }
                    field("Bank Name 2"; Rec."Bank Name 2")
                    {

                    }
                    field("Bank Branch 2"; Rec."Bank Branch 2")
                    {

                    }
                    field("Bank Branch Name 2"; Rec."Bank Branch Name 2")
                    {

                    }
                    field("Bank Account No. 2"; Rec."Bank Account No. 2")
                    {

                    }
                    field("Swift Code 2"; Rec."Swift Code 2")
                    {

                    }
                }
                group("ABB Bank Details")
                {
                    Visible = false;
                    field("ABB Bank1 Details"; Rec."ABB Bank1 Details")
                    {

                    }
                    field("ABB Bank2 Details"; Rec."ABB Bank2 Details")
                    {

                    }
                    field("ABB Bank3 Details"; Rec."ABB Bank3 Details")
                    {

                    }
                }
            }
            group("Audit Information")
            {
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {

                }
                field("Guarantors Notified"; Rec."Guarantors Notified")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(Appraisalstatistics; "Appraisal Statistics")
            {
                SubPageLink = "Loan Number" = field("Loan Number");
            }
            part(Customerstatistics; "BO Statistics")
            {
                SubPageLink = "No." = field("Member Number");
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