tableextension 50100 "Shipping Agents" extends "Shipping Agent"
{

    fields
    {
        field(50100; Branch; Code[20])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
    }
}

pageextension 50100 ShippingAgentList extends "Shipping Agents"
{
    layout
    {
        addafter(Name)
        {
            field(Branch; Rec.Branch)
            { }
        }
    }


}

