tableextension 50105 ItemExtension extends Item
{
    fields
    {
        field(50100; "Minimum Unit Price"; Decimal)
        {
            Caption = 'Minimum Unit Price';
        }
        field(50101; "Discount % Allowed"; Decimal)
        {
            Caption = 'Discount % Allowed';
        }
        field(50102; "Retail Price"; Decimal)
        {
            Caption = 'Retail Price';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Sales Price"."Unit Price" WHERE("Item No." = field("No.")));
        }
        field(50103; "HS Code"; code[30])
        {
            Caption = 'HS Code';

        }
        field(50104; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Item Classification"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            var
                lvItem: Record Item;
            begin
                If Description <> '' Then begin
                    lvItem.SetRange("Search Description", UpperCase(Description));
                    if lvItem.FindFirst() then
                        Error('Item No. %1 exists with the same Description!', lvItem."No.");
                end;
            end;
        }
    }
    trigger OnAfterModify()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Modify Items" then
            Error('You have no user rights to Modify Item Record');

        If (Description <> xRec.Description) AND (Description = '') then
            Error('Item Description cannot be Blank!')

    end;
}
