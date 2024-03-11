report 50006 "Update Deferred"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateDeferred.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                ObjCust.Reset;
                ObjCust.SetRange("No.", Customer."No.");
                if ObjCust.Find('-') then begin
                    ObjCust.Deffered := 'REV-1MO';
                    ObjCust.Modify;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjCust: Record Customer;
}

