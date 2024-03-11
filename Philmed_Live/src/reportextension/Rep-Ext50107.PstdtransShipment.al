reportextension 50107 "Pstd trans Shipment" extends "Transfer Shipment"
{


    trigger OnPreReport()
    var
        Transfer: Record "Transfer Header";
    begin

        //  "No. Printed" := "No. Printed" + 1;

        if CurrReport.Preview then begin
            Error('You can not preview this report.');


        end;
        // if CurrReport.Print(Report::"Transfer Shipment", TransferShipment)

    end;

}

