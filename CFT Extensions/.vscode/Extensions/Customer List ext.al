pageextension 50100 CustomerExt extends "Customer List"
{
    layout
    {

    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Member Account Type", Rec."Member Account Type"::" ");
    end;
}
