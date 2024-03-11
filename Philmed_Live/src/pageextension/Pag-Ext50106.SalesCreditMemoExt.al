pageextension 50106 SalesCreditMemoExt extends "Sales Credit Memo"
{
    layout
    {
        addafter("Applies-to Doc. No.")
        {

            field("Invoice Date"; "Invoice Date")
            {
                ApplicationArea = all;
                Editable = false;

                trigger OnValidate()
                var

                    Duration: Integer;
                    DD: Integer;



                begin

                    if Duration = "Invoice Date" - "Document Date" then
                        if Duration > 24 then
                            Message('Sorry, Duration has exceeded 24 hours, KIndly Contact your Supervisor');
                    Clear(Rec."Applies-to Doc. No.");
                    Clear(Rec."Invoice Date");
                end;
            }
        }
        modify("Reason Code")
        {
            Visible = true;
            Importance = Standard;
            ShowMandatory = true;
        }

    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                If NOT UserSetup."Sales. Cre. Memo Wthout Appl." then begin
                    Rec.TestField("Applies-to Doc. Type");
                    Rec.TestField("Applies-to Doc. No.");
                end;
            end;
        }


        modify(PostAndSend)
        {
            trigger OnBeforeAction()


            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                If NOT UserSetup."Sales. Cre. Memo Wthout Appl." then begin
                    Rec.TestField("Applies-to Doc. Type");
                    Rec.TestField("Applies-to Doc. No.");
                end;
            end;
        }
        modify("Preview Posting")
        {
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                If NOT UserSetup."Sales. Cre. Memo Wthout Appl." then begin
                    Rec.TestField("Applies-to Doc. Type");
                    Rec.TestField("Applies-to Doc. No.");
                end;
            end;
        }

    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean

    begin
        TestField("Reason Code");
        if "Reason Code" = '' then begin
            Error('Reason code field cannot be empty');
            exit(false);
        end else begin
            if "Reason Code" <> '' then
                exit(true);

        end;
    end;

    trigger OnOpenPage()

    var
        lvUserSetup: Record "User Setup";
    begin
        if lvUserSetup.get(UserId) then
            if not lvUserSetup."Create Sales Memo" then
                error('You do not have permission to create sales memo');
    end;
}
