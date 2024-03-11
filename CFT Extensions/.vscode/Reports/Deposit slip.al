report 50102 DepositSlip
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Deposit slip.rdl';

    dataset
    {
        dataitem(DataItemName; "BO Receipt Header.al")
        {
            RequestFilterFields = "Client Code", "Posting Date";
            column(ReceiptNo; "No.") { }
            column(MemberName; "Client Name") { }
            column(MemberNo; "Client Code") { }
            column(ReceiptAmount; Amount) { }
            column(PostingDate; "Posting Date") { }
            column(companyName; CompanyName) { }
            column(CompanyPic; CompanyInfo.Picture) { }
            column(Member_details_Report; Member_details_Report) { }
            dataitem("Receipt Line"; "BO Receipt Line")
            {
                DataItemTableView = sorting("No.");
                DataItemLink = "Client Code" = field("Client Code");
                //DataItemLink = "" = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Business Unit Code" = FIELD("Business Unit Filter");
                column(No_; "No.") { }
                column(Member_No; "Client Code") { }
                column(Member_Name; "Client Name") { }
                column(Transaction_Type; "Transaction Type") { }
                column(Loan_No; "Loan No") { }
                column(Amount; Amount) { }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CalcFields(CompanyInfo.Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        Member_details_Report: Label 'Member Receipt';
}