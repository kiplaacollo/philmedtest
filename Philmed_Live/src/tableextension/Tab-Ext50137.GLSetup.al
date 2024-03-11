tableextension 50137 "GL Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50100; "Work Start Time"; Time)
        {
            Caption = 'Work Start Time';
            DataClassification = ToBeClassified;
        }
        field(50101; "Work End Time"; Time)
        {
            Caption = 'Work Emd Time';
            DataClassification = ToBeClassified;
        }
    }
}
