table 50179 "Loan Repayment Holiday Schedul"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Closed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Client Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Monthly Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Amount Repayed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Principal Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Remaining Debt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Instalment No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Actual Loan Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Repayment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Loan Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Actual Principal Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Actual Interest Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Actual Installment Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "GracePeriod Principle"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "GracePeriod Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Repayment Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Repayment Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Repayment Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; Billed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client No.", "Repayment Date")
        {
            Clustered = true;
        }
        key(kay2; "Client No.")
        {

        }
        key(key3; Paid)
        {

        }
        key(key4; "Loan No.", "Client No.", Paid)
        {

        }
        key(key5; "Loan Category")
        {

        }
        key(key6; "Loan No.", "Client No.", Paid, "Loan Category")
        {

        }
    }

    var
        myInt: Integer;

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