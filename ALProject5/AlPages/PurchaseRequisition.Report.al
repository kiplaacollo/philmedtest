report 50461 "Purchase Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseRequisition.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(CompanyInfo1Picture; CompanyInfo1.Picture)
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(CompanyINfoName; CompanyINfo.Name)
            {
            }
            column(CompanyINfoAdd; CompanyINfo.Address)
            {
            }
            column(CompanyINfoPicture; CompanyINfo.Picture)
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(LocationCode_PurchaseHeader; "Purchase Header"."Location Code")
            {
            }
            column(dim1name; Dim1Name)
            {
            }
            column(Narration_PurchaseHeader; "Purchase Header".Narration)
            {
            }
            column(dim2name; Dim2Name)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(ExpectedReceiptDate_PurchaseLine; "Purchase Line"."Expected Receipt Date")
                {
                }
                column(sno; SNo)
                {
                }
                column(inventory; Inventory)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                    if Type = Type::Item then begin
                        Item.Get("No.");
                        Item.CalcFields(Inventory);
                        Inventory := Item.Inventory;
                    end else
                        Inventory := 0;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = WHERE ("Document Type" = CONST (Quote), Status = CONST (Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
                if DimVal.FindFirst then
                    Dim1Name := DimVal.Name;
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimVal.FindFirst then
                    Dim2Name := DimVal.Name;

                CompanyInfo1.CalcFields(CompanyInfo1.Picture);
            end;

            trigger OnPreDataItem()
            begin


                CompanyInfo1.CalcFields(CompanyInfo1.Picture);
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
        CompanyINfo: Record "Company Information";
        Inventory: Decimal;
        SNo: Integer;
        Item: Record Item;
        DimVal: Record "Dimension Value";
        Dim1Name: Text;
        Dim2Name: Text;
        CompanyInfo1: Record "Company Information";
}

