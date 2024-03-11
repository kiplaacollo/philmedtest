tableextension 50129 LocationExtension extends Location
{
    fields
    {
        field(50100; "Block Sales From Location"; Boolean)
        {
            Caption = 'Block Sales From Location';

        }
        field(50101; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Branch ID"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "KRA Branch Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
    }
}
