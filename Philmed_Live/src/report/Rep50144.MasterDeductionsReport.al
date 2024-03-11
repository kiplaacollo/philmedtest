report 50144 "Master Deductions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedMasterDeductionsRpt.rdlc';
    ApplicationArea = All;
    Caption = 'Master Deductions Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Payroll No." = filter(<> ''));
            RequestFilterFields = "No.", "Payroll No.";
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(PayrollNo; "Payroll No.")
            {
            }
            column(Food_Deductions; "Food Deductions")
            {
            }
            column(Drugs_Deductions; "Drugs Deductions")
            {

            }
            column(Payments_By_Date; "Payments By Date")
            {

            }
            column(Food; Food)
            { }
            column(Drugs; Drugs)
            { }
            column(Salary; Salary)
            { }
            column(Damages; Damages)
            { }
            column(Loan; Loan)
            { }
            column(Fuel; Fuel)
            { }
            column(Expired; Expired)
            { }
            column(StockVariance; StockVariance)
            { }
            column(PPE; PPE)
            { }
            column(DrivingLicense; DrivingLicense)
            { }
            column(LawOffence; LawOffence)
            { }
            column(LostItems; LostItems)
            { }
            column(TotalSales; TotalSales)
            { }
            column(Payments; Payments)
            { }
            column(ReportFilters; ReportFilters)
            { }

            trigger OnAfterGetRecord()
            var
                ValueEntry: Record "Value Entry";
                CustomerLedgerEntry: Record "Cust. Ledger Entry";
            begin
                Food := 0;
                Drugs := 0;
                Salary := 0;
                Damages := 0;
                Loan := 0;
                Fuel := 0;
                Expired := 0;
                StockVariance := 0;
                PPE := 0;
                DrivingLicense := 0;
                LawOffence := 0;
                LostItems := 0;
                TotalSales := 0;
                Payments := 0;

                Customer.SETFILTER("Date Filter", '%1..%2', StartDate, EndDate);
                Customer.CalcFields("Food Deductions", "Drugs Deductions", "Payments By Date");

                /* ValueEntry.Reset();
                 ValueEntry.SetRange("Posting Date", StartDate, EndDate);
                 ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                 ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
                 ValueEntry.SetRange("Source No.", Customer."No.");
                 if ValueEntry.FindFirst() then
                     repeat
                         ValueEntry.CalcFields("Item Category Code");

                         If ValueEntry."Inventory Posting Group" <> '' then begin
                             case ValueEntry."Inventory Posting Group" of
                                 'FOOD':
                                     Food += ValueEntry."Sales Amount (Actual)";
                                 'NON-FOOD':
                                     Food += ValueEntry."Sales Amount (Actual)";
                                 'NON-PHARMACY':
                                     Drugs += ValueEntry."Sales Amount (Actual)";
                                 'OTC':
                                     Drugs += ValueEntry."Sales Amount (Actual)";
                                 'PHARMACY':
                                     Drugs += ValueEntry."Sales Amount (Actual)";

                                 ELSE
                             //Do Nothing;

                             end;
                         end else begin //No Inventory Posting Group

                             case ValueEntry."Item Category Code" of
                                 'DAMAGES':
                                     Damages += ValueEntry."Sales Amount (Actual)";
                                 'LOAN':
                                     Loan += ValueEntry."Sales Amount (Actual)";
                                 'SALARY ADVANCE':
                                     Salary += ValueEntry."Sales Amount (Actual)";
                                 'FUEL':
                                     Fuel += ValueEntry."Sales Amount (Actual)";
                                 'EXPIRED':
                                     Expired += ValueEntry."Sales Amount (Actual)";

                                 'STOCK VARIANCE':
                                     StockVariance += ValueEntry."Sales Amount (Actual)";
                                 'PPE':
                                     PPE += ValueEntry."Sales Amount (Actual)";
                                 'DRIVING LICENSE':
                                     DrivingLicense += ValueEntry."Sales Amount (Actual)";
                                 'LAW OFFENSE':
                                     LawOffence += ValueEntry."Sales Amount (Actual)";
                                 'LOST ITEMS':
                                     LostItems += ValueEntry."Sales Amount (Actual)";

                                 ELSE
                             //Do Nothing;
                             end;

                         end;

                         TotalSales += ValueEntry."Sales Amount (Actual)";

                     until ValueEntry.Next() = 0;


                 //Payments
                 CustomerLedgerEntry.Reset();
                 CustomerLedgerEntry.SetRange("Document Type", CustomerLedgerEntry."Document Type"::Payment);
                 CustomerLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                 CustomerLedgerEntry.SetRange(Reversed, false);
                 CustomerLedgerEntry.SetRange("Customer No.", Customer."No.");
                 if CustomerLedgerEntry.FindSet() then
                     repeat
                         CustomerLedgerEntry.CalcFields(Amount);
                         Payments += CustomerLedgerEntry.Amount;
                     until CustomerLedgerEntry.Next() = 0;*/


            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if StartDate = 0D then
            Error('Start Date must be specified');
        if EndDate = 0D then
            Error('End Date must be specified');

        ReportFilters := 'Start Date: ' + Format(StartDate) + ' End Date: ' + Format(EndDate) + ' ' + Customer.GetFilters;

        Customer.SETFILTER("Date Filter", '%1..%2', StartDate, EndDate);
    end;


    var
        Food: Decimal;
        Drugs: Decimal;
        Salary: Decimal;
        Damages: Decimal;
        Loan: Decimal;
        Fuel: Decimal;
        Expired: Decimal;
        StockVariance: Decimal;
        PPE: Decimal;
        DrivingLicense: Decimal;
        LawOffence: Decimal;
        LostItems: Decimal;
        TotalSales: Decimal;
        StartDate: Date;
        EndDate: Date;
        ReportFilters: Text;
        Payments: Decimal;
}
