table 50170 "Repayment Holidays Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Installment; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Installment Month"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ObjLoans.Reset();
                ObjLoans.SetRange(ObjLoans."Loan Number", "Loan Number");
                if ObjLoans.Find('-') then begin
                    if ObjLoans."Repayment Debut Date" = 0D then
                        Error('Repayment Debut Date Must have a Value!!')
                    ELSE
                        "Installment Month" := CALCDATE((FORMAT(DATE2DMY(ObjLoans."Repayment Debut Date", 1)) + 'D-1D'), (CALCDATE('-CM', "Installment Month")));
                    if Moratorium = true then begin
                        if Format("Moratorium Period") <> '' then
                            "Moratorium End Date" := CALCDATE("Moratorium Period", "Installment Month");
                    end;
                end;
            end;
        }
        field(3; "Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans."Loan Number";
        }
        field(4; "Holiday Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Moratorium Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Moratorium Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Moratorium = true then begin
                    IF FORMAT("Moratorium Period") <> '' THEN
                        "Moratorium End Date" := CALCDATE("Moratorium Period", "Installment Month");
                end;
            end;
        }
        field(7; "Moratorium End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Moratorium; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Number", Installment, "Installment Month")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        ObjLoans: Record Loans;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}