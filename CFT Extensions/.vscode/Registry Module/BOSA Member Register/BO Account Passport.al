page 50118 "BO Account Passport"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Accounts";

    layout
    {
        area(Content)
        {
            field("Passport Photo"; Rec."Passport Photo")
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    rec: record "BO Applications";
                    Insrt: InStream;
                    filedt: File;
                    filename: text;
                begin
                    // if rec."Passport Photo".HasValue then
                    //     if not Confirm('Sure to upload & Ovewrite the pic?', false) then exit;
                    // UploadIntoStream('The Stream to Upload', '', 'Image File|*.png;*.jpg', filename, Insrt);
                    // rec."Passport Photo".ImportStream(Insrt, filename);
                    // rec.Modify();


                end;
            }
        }
    }

    var
        file: file;
        picturefilepath: text;
        instream: InStream;
        filemanagement: Codeunit "File Management";
        BOAccount: Record "BO Applications";

}