report 50003 "Deferrals Test Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DeferralsTestReport.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Package Amount Excl VAT", "Package Excise Duty", "Infrastructure Amount";
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Message('The Entered Amount %1, Package Amount %2', TestAmount, (Customer."Package Amount Excl VAT" + Customer."Package Excise Duty" + Customer."Infrastructure Amount"));
                if (TestAmount < Customer."Package Amount Excl VAT" + Customer."Package Excise Duty" + Customer."Infrastructure Amount") then
                    Error('The Entered Amount %1 does not Match the Assigned Package Amount %2', TestAmount, (Customer."Package Amount Excl VAT" + Customer."Package Excise Duty" + Customer."Infrastructure Amount"));
                CFTFactory.FnGenerateInvoice(Customer."No.", PDate, TestAmount, DocNo);
            end;

            trigger OnPreDataItem()
            begin
                if Confirm('This is an Automated Process Report. It will Automatically post the Test Amount to the Customer Ledgers.' +
                  ' To test ensure you are on a test environment. Are you sure you want to proceed?', false) = false then
                    exit;

                if PDate = 0D then
                    Error('The Posting Date must be set!!');

                if TestAmount = 0 then
                    Error('The Test Amount Must be set!!');

                CustFilter := Customer.GetFilter("No.");
                if CustFilter = '' then
                    Error('The Customer Must be Selected first!');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PDate)
                {
                }
                field("Test Amount"; TestAmount)
                {
                }
                field(DocNo; DocNo)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PDate: Date;
        TestAmount: Decimal;
        CustFilter: Text;
        CFTFactory: Codeunit "CFT Factory";
        DocNo: Code[50];
}

