page 50124 "BO Applications Signature"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";

    layout
    {
        area(Content)
        {
            field(Signature; Rec.Signature)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Signature")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    mypicturerec: Record "BO Applications";
                    filename: text;
                    importfile: File;
                    imageInStream: InStream;
                    imageID: Guid;
                    Text000: Label 'Image has been imported';
                    InStreamPic: InStream;
                    FromFileName: Text;
                begin
                    // if mypicturerec.FindFirst() then begin
                    //     repeat begin
                    //         filename := 'C:\images' + Format(mypicturerec.No) + '.jpg';
                    //         if File.Exists(filename) then begin
                    //             importfile.Open(filename);
                    //             importfile.CreateInStream(imageInStream);
                    //         end;

                    //     end until mypicturerec.Next < 1;
                    // end;



                end;
            }
        }
    }

    var
        myInt: Integer;
}