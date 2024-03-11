tableextension 50120 "G/L Entry ext" extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        modify("Source No.")
        {
            TableRelation = if ("Source Type" = const(Member)) "BO Accounts";
        }
    }

    var
        myInt: Integer;
}