report 50470 "Qr Mgmnt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './QrMgmnt.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE ("Posting Date" = FILTER (> 20230101D), "Code Generated" = FILTER (false), "KRA Url" = FILTER (<> ''));

            trigger OnAfterGetRecord()
            begin
                if ("Sales Invoice Header"."Posting Date" = CalcDate('-1D', Today)) or ("Sales Invoice Header"."Posting Date" = Today) then begin
                    QrMngmnt.BarcodeForServiceInvoice("Sales Invoice Header");
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
        QrMngmnt: Codeunit "QRCode Mgt";
}

