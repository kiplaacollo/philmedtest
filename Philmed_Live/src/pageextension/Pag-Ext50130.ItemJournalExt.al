pageextension 50130 ItemJournalExt extends "Item Journal"
{
    actions
    {

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Item Journal Posting" then
                        error('You do not have permission to post item journals');
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Item Journal Posting" then
                        error('You do not have permission to post item journals');
            end;
        }

    }
    trigger OnOpenPage()
    var

    begin
        Rec.Validate(Rec."Item No.");
    end;
}