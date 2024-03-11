report 50464 "Counter Requisition Formm"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CounterRequisitionFormm.rdlc';

    dataset
    {
        dataitem("Store Requistion Headerr"; "Store Requistion Headerr")
        {
            column(DocumentNo; "Store Requistion Headerr"."No.")
            {
            }
            column(PointOfIssue; "Store Requistion Headerr"."Issuing Store")
            {
            }
            column(PointofUse; "Store Requistion Headerr"."Responsibility Center")
            {
            }
            column(Date; "Store Requistion Headerr"."Request date")
            {
            }
            column(CompName; CompName)
            {
            }
            column(Pic; CompInfo.Picture)
            {
            }
            column(Address; CompInfo."Address 2" + ',')
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(USER; "Store Requistion Headerr"."User ID")
            {
            }
            column(Dept; Dept)
            {
            }
            dataitem("Store Requistion Liness"; "Store Requistion Liness")
            {
                DataItemLink = "Requistion No" = FIELD ("No.");
                column(ItemNo; "Store Requistion Liness"."No.")
                {
                }
                column(Description; "Store Requistion Liness".Description)
                {
                }
                column(UnitofIssue; "Store Requistion Liness"."Unit of Measure")
                {
                }
                column(QuantitiyIssued; "Store Requistion Liness".Quantity)
                {
                }
                column(QuantityRequested; "Store Requistion Liness"."Quantity Requested")
                {
                }
                column(LastDateofIssue; "Store Requistion Liness"."Last Date of Issue")
                {
                }
                column(LastQuantityIssued; "Store Requistion Liness"."Last Quantity Issued")
                {
                }
                column(Remarks; "Store Requistion Liness".Remarks)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                // Logos.RESET;
                // Logos.SETRANGE(Logos.Code,Table51516102."Global Dimension 1 Code");
                // IF Logos.FIND('-') THEN BEGIN
                //   Logos.CALCFIELDS(Logos.Picture);
                // END ELSE BEGIN
                //   Logos.RESET;
                //   Logos.SETRANGE(Logos.Default,TRUE);
                //   Logos.CALCFIELDS(Logos.Picture);
                // END;
                // DimValue.RESET;
                // DimValue.SETRANGE(DimValue.Code,Table51516102."Shortcut Dimension 2 Code");
                // IF DimValue.FIND ('-') THEN
                // Dept:=DimValue.Name;
            end;

            trigger OnPreDataItem()
            begin
                if CompInfo.Get then
                    CompInfo.CalcFields(CompInfo.Picture);
                CompName := CompInfo.Name;
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
        CompInfo: Record "Company Information";
        CompName: Text[100];
        DimValue: Record "Dimension Value";
        Dept: Text[100];
}

