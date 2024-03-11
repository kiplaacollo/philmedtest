tableextension 50001 "Customer Posting Group Ext" extends "Customer Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Deposit Contribution"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50002; "Share Capital"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50003; "Benevolent Fund"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50004; "UnAllocated Funds"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}