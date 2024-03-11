codeunit 50010 "Full Name"
{
    procedure GenerateFullName(var rec: Record "BO Applications")

    begin
        FullName := Rec."First Name" + Rec."Middle Name" + Rec."Last Name";
        Rec."Full Name" := FullName;


    end;

    var
        FullName: Text[100];
        Rec: Record "BO Applications";
}