table 50112 "Inventory Transfer User Matrix"
{
    Caption = 'Inventory Transfer User Matrix';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transfer Type"; Enum "Transfer Type")
        {
            Caption = 'Transfer Type';
            DataClassification = ToBeClassified;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }
    keys
    {
        key(PK; "Transfer Type", "User ID", "Location Code")
        {
            Clustered = true;
        }
    }
}
