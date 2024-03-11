table 50045 "Lead Records"
{

    fields
    {
        field(1; "Lead Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Customer Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Package Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Packages"."Package Code";

            trigger OnValidate()
            begin
                SalesPackages.Get("Package Code");
                "Package Price" := SalesPackages."Package +Installation";
            end;
        }
        field(7; "Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Payment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Paid,Pending Refund,Refunded';
            OptionMembers = Pending,Paid,"Pending Refund",Refunded;
        }
        field(17; "Amount Received"; Decimal)
        {
            CalcFormula = - Sum ("G/L Entry".Amount WHERE ("G/L Account No." = CONST ('14301'),
                                                         "External Document No." = FIELD ("Lead Number"),
                                                         Reversed = CONST (false),
                                                         Amount = FILTER (< 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Mpesa Ref Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Package Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Refund_code; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Amount Refunded"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; region_id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Lead Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SalesPackages: Record "Sales Packages";
}

