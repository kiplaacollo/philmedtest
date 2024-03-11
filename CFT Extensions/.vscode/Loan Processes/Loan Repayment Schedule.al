table 50150 "Loan Repayment Shedule"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Client No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Loan Category"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Closed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Interest Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Monthly Repayment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Client Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Monthly Interest"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Amount Repayed"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Repayment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Principal Repayment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; Paid; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Remaining Debt"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Instalment No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(45; "Actual Loan Repayment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Repayment Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Loan Application No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(49; "Actual Principal Paid"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50; "Actual Interest Paid"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Actual Installment Paid"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(52; "GracePeriod Principle"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(53; "GracePeriod Interest"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(54; "Repayment Day"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(55; "Repayment Month"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(56; "Repayment Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(57; "Loan Balance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(58; Billed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(59; Holiday; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client No.", "Repayment Date")
        {
            Clustered = true;
            SumIndexFields = "Monthly Interest", "Principal Repayment", "Monthly Repayment";
        }
        key(key2; "Client No.")
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