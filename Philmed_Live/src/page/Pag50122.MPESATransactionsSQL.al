page 50122 "MPESA Transactions SQL"
{
    ApplicationArea = All;
    Caption = 'MPESA Transactions SQL';
    PageType = List;
    SourceTable = "MPESA Transactions SQL";
    SourceTableView = SORTING(ID) ORDER(Descending);
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(TransTime; Rec.TransTime)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Transactiontime; Transactiontime)
                {
                    ApplicationArea = all;
                }
                field(TransID; Rec.TransID)
                {
                    ApplicationArea = All;
                }
                field(BusinessShortCode; Rec.BusinessShortCode)
                {
                    ApplicationArea = All;
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ApplicationArea = All;
                }
                field("TransactionType"; Rec."TransactionType")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ApplicationArea = All;
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                }
                field(MiddleName; Rec.MiddleName)
                {
                    ApplicationArea = All;
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                begin
                    //CurrPage.Update();
                    CurrPage.Activate(true);
                end;
            }
        }
    }
    var
        Transactiontime: DateTime;

    trigger OnInit()
    var
        SQLConnection: Codeunit "MPESA SQLConnection";
    begin
        SQLConnection.Run();
    end;

    trigger OnAfterGetRecord()
    begin
        Transactiontime := Rec.TransTime - (10800000);
    end;

}
