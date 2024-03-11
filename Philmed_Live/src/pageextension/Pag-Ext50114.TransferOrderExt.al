pageextension 50114 TransferOrderExt extends "Transfer Order"
{
    layout
    {
        addafter(General)
        {
            field("Awaiting Kra Posting"; "Awaiting Kra Posting")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA"; "Posted To KRA")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA Error"; "Posted To KRA Error")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Kra Error Descripion"; "Kra Error Descripion")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                Rec."Awaiting Kra Posting" := true;
                Rec.Modify();
            end;

        }
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                TransferHeader: Record "Transfer Header";
                TransferOrder: report "Philmed Transfer Order";
            begin
                TransferHeader.SetRange("No.", Rec."No.");
                TransferOrder.SetTableView(TRansferHeader);
                TransferOrder.Run();
                Error('');
            end;

        }

    }
}

pageextension 50115 TransferShipmentExt extends "Posted Transfer Shipment"
{
    layout
    {

        addafter(General)
        {

            field("Awaiting Kra Posting"; "Awaiting Kra Posting")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA"; "Posted To KRA")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA Error"; "Posted To KRA Error")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Kra Error Descripion"; "Kra Error Descripion")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
    }
    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                TransferShipment: Record "Transfer Shipment Header";
                TransferShipmentRpt: report "Philmed Transfer Shipment";
            begin
                TransferShipment.SetRange("No.", Rec."No.");
                TransferShipmentRpt.SetTableView(TransferShipment);
                TransferShipmentRpt.Run();
                Error('');


            end;

            trigger OnAfterAction()
            var
                TransferShipments: Record "Transfer Shipment Header";
            begin
                if TransferShipments.Find('+') then
                    repeat
                        TransferShipments."No. Printed" := TransferShipments."No. Printed" + 1;
                        TransferShipments.Modify;
                    UNTIL TransferShipments.NEXT = 0;

            end;




        }


    }
}