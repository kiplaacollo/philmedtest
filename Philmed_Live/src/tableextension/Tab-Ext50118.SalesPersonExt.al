tableextension 50118 SalesPersonExt extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;

            trigger OnValidate()
            var
                lvLocation: Record Location;
            begin
                if "Location Code" <> '' then begin
                    lvLocation.Get("Location Code");
                    if lvLocation."Block Sales From Location" then
                        Error('This Location is Blocked for use in Sales Orders!');
                end;
            end;

        }
        field(50101; "Daily Sales Target Amount"; Decimal)
        {
            Caption = 'Daily Sales Target Amount';
        }
        field(50102; "Daily Customers Target"; Integer)
        {
            Caption = 'Daily Customers Target';
        }
        /*  field(50103; "Blocked"; Boolean)
         {
             Caption = 'Blocked';
         } */
    }
}
