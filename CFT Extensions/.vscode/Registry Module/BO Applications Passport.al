page 50123 "BO Applications Passport"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";
    InsertAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;

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
                    FileName: Text;
                    FileManagement: Codeunit "File Management";
                    ClientFileName: Text;
                begin
                    // Rec.TestField(No);
                    // if Rec."Full Name" = ''
                    // then
                    //     Error('Must Specify Name');
                    // if rec."Passport Photo".HasValue then
                    //     exit;





                end;
            }

        }
    }

    var

        file: File;
        picturefilepath: text;
        instream: InStream;
        outstream: OutStream;
        filemanagement: Codeunit "File Management";

}