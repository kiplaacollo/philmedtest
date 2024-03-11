pageextension 50109 PostedSalesInvoiceExt extends "Posted Sales Invoice"
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
        addbefore(Closed)
        {
            field("Cash Sale Order"; Rec."Cash Sale Order")
            {
                ApplicationArea = all;
            }

            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = all;
            }
            field("Urgent Comments"; Rec."Urgent Comments")
            {
                ApplicationArea = all;
            }

        }

    }
    actions
    {
        addbefore(Print)
        {


            action("Print Invoice")
            {

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    InvoiceHeader: report "Philmed Sales - Invoice";
                    CashSale: report "Philmed Cash Sales - Invoice";
                    CRL: Record "Custom Report Layout";


                begin

                    if Rec."Cash Sale Order" = false then begin
                        SalesInvHeader.SetRange("No.", Rec."No.");
                        CashSale.SetTableView(SalesInvHeader);
                        CashSale.Run()

                    end else

                        if Rec."Cash Sale Order" = true then begin
                            SalesInvHeader.SetRange("No.", Rec."No.");
                            InvoiceHeader.SetTableView(SalesInvHeader);
                            InvoiceHeader.Run();
                            // InvoiceHeader.Run()

                        end
                        else begin
                            SalesInvHeader := Rec;
                            CurrPage.SetSelectionFilter(SalesInvHeader);
                            SalesInvHeader.PrintRecords(true);
                        end;
                    //Error('');
                end;

            }
        }
        modify(Print)
        {
            Visible = false;


        }


    }


}
