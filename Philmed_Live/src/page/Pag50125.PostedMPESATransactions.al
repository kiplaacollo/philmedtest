page 50125 "Posted MPESA Transactions"
{
    ApplicationArea = All;
    Caption = 'Posted MPESA Transactions';
    PageType = List;
    SourceTable = "Posted MPESA Transaction";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    ApplicationArea = All;
                }
                field(TransTime; Rec.TransTime)
                {
                    ToolTip = 'Specifies the value of the TransTime field.';
                    ApplicationArea = All;
                }
                field(TransID; Rec.TransID)
                {
                    ToolTip = 'Specifies the value of the TransID field.';
                    ApplicationArea = All;
                }
                field(BusinessShortCode; Rec.BusinessShortCode)
                {
                    ToolTip = 'Specifies the value of the BusinessShortCode field.';
                    ApplicationArea = All;
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ToolTip = 'Specifies the value of the TransAmount field.';
                    ApplicationArea = All;
                }
                field("TransactionType"; Rec."TransactionType")
                {
                    ToolTip = 'Specifies the value of the TransactionType field.';
                    ApplicationArea = All;
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ToolTip = 'Specifies the value of the MSISDN field.';
                    ApplicationArea = All;
                }
                field(FirstName; Rec.FirstName)
                {
                    ToolTip = 'Specifies the value of the FirstName field.';
                    ApplicationArea = All;
                }
                field(LastName; Rec.LastName)
                {
                    ToolTip = 'Specifies the value of the LastName field.';
                    ApplicationArea = All;
                }
                field("Posted Document No."; Rec."Posted Document No.")
                {
                    ToolTip = 'Specifies the value of the Posted Document No. field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
