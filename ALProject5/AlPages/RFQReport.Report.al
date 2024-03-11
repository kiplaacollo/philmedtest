report 50460 "RFQ Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RFQReport.rdlc';

    dataset
    {
        dataitem("Purchase Quote Header"; "Purchase Quote Header")
        {
            RequestFilterFields = "No.", "Vendor Filter";
            column(No_PurchaseQuoteHeader; "No.")
            {
            }
            column(ShiptoCode_PurchaseQuoteHeader; "Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseQuoteHeader; "Ship-to Name")
            {
            }
            column(ShiptoAddress_PurchaseQuoteHeader; "Ship-to Address")
            {
            }
            column(LocationCode_PurchaseQuoteHeader; "Location Code")
            {
            }
            column(ShortcutDimension1Code_PurchaseQuoteHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseQuoteHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(PostingDescription_PurchaseQuoteHeader; "Posting Description")
            {
            }
            column(ExpectedClosingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Expected Opening Date")
            {
            }
            column(CompayInfoName; CompayInfo.Name)
            {
            }
            column(CompayInfoPicture; CompayInfo.Picture)
            {
            }
            column(PostingDate_PurchaseQuoteHeader; "Posting Date")
            {
            }
            column(ReleasedBy_PurchaseQuoteHeader; "Released By")
            {
            }
            column(ReleaseDate_PurchaseQuoteHeader; "Release Date")
            {
            }
            dataitem("Quotation Request Vendors"; "Quotation Request Vendors")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Requisition Document No." = FIELD ("No."), "Vendor No." = FIELD ("Vendor Filter");
                column(VendorNo_QuotationRequestVendors; "Vendor No.")
                {
                }
                column(VendorName_QuotationRequestVendors; "Vendor Name")
                {
                }
                column(VendorAddress; Vendor.Address)
                {
                }
                column(RequisitionDocumentNo_QuotationRequestVendors; "Quotation Request Vendors"."Requisition Document No.")
                {
                }
                column(VendorAddress2; Vendor."Address 2")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Vendor.Get("Quotation Request Vendors"."Vendor No.");
                    ;
                end;
            }
            dataitem("Purchase Quote Line"; "Purchase Quote Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                column(Type_PurchaseQuoteLine; Type)
                {
                }
                column(No_PurchaseQuoteLine; "No.")
                {
                }
                column(Description_PurchaseQuoteLine; Description)
                {
                }
                column(UnitofMeasure_PurchaseQuoteLine; "Unit of Measure")
                {
                }
                column(Quantity_PurchaseQuoteLine; Quantity)
                {
                }
                column(LineNo_PurchaseQuoteLine; "Line No.")
                {
                }
                column(DESC2; "Purchase Quote Line"."Description 2")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompayInfo.CalcFields(CompayInfo.Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompayInfo.CalcFields(CompayInfo.Picture);
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
        CompayInfo: Record "Company Information";
        Vendor: Record Vendor;
}

