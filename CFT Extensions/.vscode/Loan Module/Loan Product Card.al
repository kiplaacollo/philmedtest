page 50109 "Loan Product Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Products";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {

                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    Caption = 'Interest Calculation Method';
                }
                field("Min Interest Rate"; Rec."Min Interest Rate")
                {
                    Caption = 'Min Interest Rate';
                }
                field("Max Interest Rate"; Rec."Max Interest Rate")
                {
                    Caption = 'Max Interest Rate';
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    Caption = 'Penalty Calculation Method';
                }
                field("Penalty Rate"; Rec."Penalty Rate")
                {
                    Caption = 'Penalty Rate';
                }
                field("Repayment Bounce Charge"; Rec."Repayment Bounce Charge")
                {
                    Caption = 'Repayment Bounce Charge';
                }
                field("Max Installments"; Rec."Max Installments")
                {
                    Caption = 'Max Installments';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    Caption = 'Repayment Frequency';
                }
                field("Min Guarantors"; Rec."Min Guarantors")
                {
                    Caption = 'Min Guarantors';
                }
                field("Max Guarantors"; Rec."Max Guarantors")
                {
                    Caption = 'Max Guarantors';
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    Caption = 'Recovery Mode';
                }
                field("Min Loan Amount"; Rec."Min Loan Amount")
                {
                    Caption = 'Min Loan Amount';
                }
                field("Max Loan Amount"; Rec."Max Loan Amount")
                {
                    Caption = 'Max Loan Amount';
                }
                field("Deposit Factor"; Rec."Deposit Factor")
                {
                    Caption = 'Deposit Factor';
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Caption = 'Activity Code';
                }
                field("Allow Self Guarantee"; Rec."Allow Self Guarantee")
                {
                    Caption = 'Allow Self Guarantee';
                }

            }
            group("Qualification Options")
            {
                field("Qualify by Deposits"; Rec."Qualify by Deposits")
                {
                    Caption = 'Qualify by Deposits';
                }
                field("Qualify by Salary"; Rec."Qualify by Salary")
                {
                    Caption = 'Qualify by Salary';
                }
                field("Qualify by Guarantors"; Rec."Qualify by Guarantors")
                {
                    Caption = 'Qualify by Guarantors';
                }
                field("Qualify by Dividend"; Rec."Qualify by Dividend")
                {
                    Caption = 'Qualify by Dividend';
                }
                field("Qualify by Collateral"; Rec."Qualify by Collateral")
                {
                    Caption = 'Qualify by Collateral';
                }

            }
            group(Accounts)
            {
                field("Loan Book Account"; Rec."Loan Book Account")
                {
                    Caption = 'Loan Book Account';
                }
                field("Interest Receivable Account"; Rec."Interest Receivable Account")
                {
                    Caption = 'Interest Receivable Account';
                }
                field("Interest Income Account"; Rec."Interest Income Account")
                {
                    Caption = 'Interest Income Account';
                }
                field("Penalty Receivable Account"; Rec."Penalty Receivable Account")
                {
                    Caption = 'Penalty Receivable Account';
                }
                field("Penalty Income Account"; Rec."Penalty Income Account")
                {
                    Caption = 'Penalty Income Account';
                }
                field("Interest Receivable Suspense"; Rec."Interest Receivable Suspense")
                {
                    Caption = 'Interest Receivable Suspense';
                }
                field("Interest Suspense Liability Ac"; Rec."Interest Suspense Liability Ac")
                {
                    Caption = 'Interest Suspense Liability Ac';
                }
                field("Penalty Receivable Suspense"; Rec."Penalty Receivable Suspense")
                {
                    Caption = 'Penalty Receivable Suspense';
                }
                field("Penalty Suspense Liability Ac"; Rec."Penalty Suspense Liability Ac")

                {
                    Caption = 'Penalty Suspense Liability Ac';
                }
                field("Write Off Provision Account"; Rec."Write Off Provision Account")
                {
                    Caption = 'Write Off Provision Account';
                }
                field("Write Off Recoveries Account"; Rec."Write Off Recoveries Account")
                {
                    Caption = 'Write Off Recoveries Account';
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Loan Charges")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Agreement;
                RunObject = page 50170;
                RunPageLink = Code = field(Code);

            }
        }
    }

    var
        myInt: Integer;
}