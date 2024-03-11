page 50126 "MPESA Transactions View"
{
    ApplicationArea = All;
    Caption = 'MPESA Transactions View';
    PageType = List;
    SourceTable = "MPESA Transaction";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(TransID; Rec.TransID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TransID field.';
                }
                field(TransTime; Rec.TransTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TransTime field.';
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TransAmount field.';
                }
                field("TransactionType"; Rec."TransactionType")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TransactionType field.';
                }
                field(BillRefNumber; Rec.BillRefNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BillRefNumber field.';
                }
                field(BusinessShortCode; Rec.BusinessShortCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BusinessShortCode field.';
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DocumentNo field.';
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FirstName field.';
                }
                field(MiddleName; Rec.MiddleName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MiddleName field.';
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LastName field.';
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MSISDN field.';
                }
                field(PostingDate; Rec.PostingDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PostingDate field.';
                }
                field("Posted Document No."; Rec."Posted Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Document No. field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(PostingTime; Rec.PostingTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PostingTime field.';
                }
            }
        }
    }
}
