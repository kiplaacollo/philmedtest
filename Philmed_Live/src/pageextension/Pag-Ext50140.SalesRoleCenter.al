pageextension 50140 "Sales RoleCenter" extends "Sales Manager Role Center"
{

    layout
    {
        addafter(Control1)
        {
            part(bchart; BranchTargetChart)
            {
                ApplicationArea = all;
            }




        }
    }
}
