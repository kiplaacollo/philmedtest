pageextension 50126 PostedPurchasesSubforms extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = all;
            }
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = all;
            }
        }
    }
}

pageextension 50127 PostedPurchReceiptSubform extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("Order Date")
        {
            field("Batch No."; Rec."Batch No.")
            { }
            field("Expiry Date"; Rec."Expiry Date")
            { }
        }
    }
}
pageextension 50128 PostedPurchCredMemoSubform extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Batch No."; Rec."Batch No.")
            { }
            field("Expiry Date"; Rec."Expiry Date")
            { }
        }
    }
}
pageextension 50141 PostedPurchaseInvHeader extends "Posted Purchase Invoice"
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
}
pageextension 50142 PurchaseInvHeader extends "Purchase Invoice"
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
    }
}
pageextension 50143 SalesInvHeader extends "Sales Invoice"
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
    }
}
