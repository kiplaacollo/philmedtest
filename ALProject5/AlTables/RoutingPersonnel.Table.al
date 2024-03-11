table 99000803 "Routing Personnel"
{
    Caption = 'Routing Personnel';

    fields
    {
        field(1; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            NotBlank = true;
            TableRelation = "Routing Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; "Version Code"; Code[20])
        {
            Caption = 'Version Code';
            TableRelation = "Routing Version"."Version Code" WHERE ("Routing No." = FIELD ("Routing No."));
        }
        field(21; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            NotBlank = true;
            TableRelation = "Routing Line"."Operation No." WHERE ("Routing No." = FIELD ("Routing No."),
                                                                  "Version Code" = FIELD ("Version Code"));
        }
    }

    keys
    {
        key(Key1; "Routing No.", "Version Code", "Operation No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure Caption(): Text[100]
    var
        RtngHeader: Record "Routing Header";
    begin
        if GetFilters = '' then
            exit('');

        if "Routing No." = '' then
            exit('');

        RtngHeader.Get("Routing No.");

        exit(
          CopyStr(StrSubstNo('%1 %2 %3',
              "Routing No.", RtngHeader.Description, "Operation No."), 1, 100));
    end;
}
