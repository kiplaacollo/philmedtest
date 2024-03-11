report 50132 "Update MPESA Phone No."
{
    ApplicationArea = All;
    Caption = 'Update MPESA Phone No.';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(customer; customer)
        {
            trigger OnAfterGetRecord()
            begin
                customer.Validate("Mobile Phone No.");
                customer.Modify();
            end;

        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
}
