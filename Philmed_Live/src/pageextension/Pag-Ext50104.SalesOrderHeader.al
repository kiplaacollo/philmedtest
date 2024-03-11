pageextension 50104 SalesOrderHeader extends "Sales Order"
{
    layout
    {
        modify("Sell-to Customer Name")
        {
            Visible = false;
            ApplicationArea = all;
        }
        addafter("Sell-to Customer No.")
        {
            field("PFX_Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Editable = false;
            }
        }
        addbefore("Salesperson Code")
        {
            field("PFX_Sell-to Customer No."; "Sell-to Customer No.")
            {
                ApplicationArea = ALL;
                Visible = false;

            }
        }



        addbefore(Status)
        {
            field("Cash Sale Order"; Rec."Cash Sale Order")
            {
                ApplicationArea = all;
            }
            field("Urgent Comments"; Rec."Urgent Comments")
            {
                MultiLine = true;
                ApplicationArea = all;
            }
            field("Time Created"; "Time Created")
            {
                ApplicationArea = all;
            }
        }
        addafter("Combine Shipments")
        {
            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
            Importance = Promoted;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = false;
        }



        movebefore(Status; "Shortcut Dimension 1 Code", "Location Code")

    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                lvCustomer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                if Rec."Sell-to Customer No." <> '' then begin

                    If Rec."Cash Sale Order" then begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", TRUE);
                        Rec.Modify();
                    end else begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", false);
                        Rec.Modify();
                    end;
                end;
                Rec.CheckCustomerCreditLimit(Rec);
                Rec.CalcFields(Amount);
                If Rec.Amount = 0 then
                    Error('There is Nothing to Post!');
            end;

        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            var
                lvCustomer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                if Rec."Sell-to Customer No." <> '' then begin

                    If Rec."Cash Sale Order" then begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", TRUE);
                        Rec.Modify();
                    end else begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", false);
                        Rec.Modify();
                    end;
                end;
                Rec.CheckCustomerCreditLimit(Rec);
                Rec.CalcFields(Amount);
                If Rec.Amount = 0 then
                    Error('There is Nothing to Post!');
            end;

        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            var
                lvCustomer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                if Rec."Sell-to Customer No." <> '' then begin

                    If Rec."Cash Sale Order" then begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", TRUE);
                        Rec.Modify();
                    end else begin
                        Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", false);
                        Rec.Modify();
                    end;
                end;
                Rec.CheckCustomerCreditLimit(Rec);
                Rec.CalcFields(Amount);
                If Rec.Amount = 0 then
                    Error('There is Nothing to Post!');
            end;

        }
        modify("Request Approval")
        {
            Visible = false;
        }

        modify(Release)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Visible = false;
        }
        modify(CopyDocument)
        {
            Visible = false;
        }
        modify(GetRecurringSalesLines)
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(SendEmailConfirmation)
        {
            Visible = false;
        }
        modify("Print Confirmation")
        {
            Visible = false;
        }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }

        addbefore(PostAndNew)
        {

            action("PostAndPrint")
            {
                ApplicationArea = all;
                Image = TaskList;
                Caption = 'Post & Print';

                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    lvCustomer: Record Customer;
                    SalesSetup: Record "Sales & Receivables Setup";
                    CurrentOrderNo: Code[20];
                    SalesPost: Codeunit "Sales-Post (Yes/No)";
                    SalesInv: Report "Philmed Sales - Invoice";
                    SalesInvCash: Report "Philmed Cash Sales - Invoice";
                    SalesInvHeader: Record "Sales Invoice Header";

                begin
                    if Rec."Sell-to Customer No." <> '' then begin


                        If Rec."Cash Sale Order" then begin
                            Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", TRUE);
                            Rec.Modify();
                        end else begin
                            Rec."Posting No. Series" := SelectNoSeries(Rec."Shortcut Dimension 1 Code", false);
                            Rec.Modify();

                        end;
                    end;
                    Rec.CheckCustomerCreditLimit(Rec);
                    Rec.CalcFields(Amount);
                    If Rec.Amount = 0 then
                        Error('There is Nothing to Post!');


                    CurrentOrderNo := Rec."No.";
                    SalesPost.Run(Rec);
                    //Print 
                    SalesInvHeader.SetRange("Order No.", CurrentOrderNo);
                    if SalesInvHeader.FindFirst() then begin
                        if SalesInvHeader."Cash Sale Order" then begin
                            SalesInvCash.SetTableView(SalesInvHeader);
                            SalesInvCash.RunModal();
                        end else begin
                            SalesInv.SetTableView(SalesInvHeader);
                            SalesInv.RunModal();
                        end;
                    end;

                end;
            }
        }

        addbefore(GetRecurringSalesLines)
        {
            action("Insert Cash Sale Gift Item")
            {
                ApplicationArea = all;
                Image = TaskList;

                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvCustomer: Record Customer;
                begin
                    if Rec."Sell-to Customer No." <> '' Then begin
                        lvCustomer.GET(rec."Sell-to Customer No.");
                        if not lvCustomer."Eligible For Sales Gift" then
                            Error('This customer is NOT elligible for Sales Gift Items!');
                        Rec.InsertCashSaleGiftItem(Rec);
                    end;
                end;
            }
        }



    }
    Procedure SelectNoSeries(BranchCode: Code[20]; CashSalesOrder: Boolean): Code[20]

    var
        DimensionValue: Record "Dimension Value";
        SalesSetup: Record "Sales & Receivables Setup";
    Begin
        SalesSetup.Get();
        DimensionValue.SetRange("Global Dimension No.", 1);
        DimensionValue.SetRange(Code, BranchCode);
        If DimensionValue.FindFirst() then begin
            if CashSalesOrder then begin
                if DimensionValue."Cash Sale Nos." <> '' then
                    exit(DimensionValue."Cash Sale Nos.")
                else
                    exit(SalesSetup."Cash Sale Posting Nos.");

            end else begin
                if DimensionValue."Sales Invoice Nos." <> '' then
                    exit(DimensionValue."Sales Invoice Nos.")
                else
                    exit(SalesSetup."Posted Invoice Nos.");
            end;
        end;
    End;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        D: Date;
        D1: DateTime;
        GLSetup: record "General Ledger Setup";
        CurrentTime: Time;
        user: Code[20];
        UsersSetup: Record "User Setup";
    begin
        D := Today;
        "Time Created" := CreateDateTime(D, 0T);

        UsersSetup.Get(UserId);
        CurrentTime := System.Time;
        user := UserId;

        if (CurrentTime < UsersSetup."Work Start Time") OR (CurrentTime > UsersSetup."Work End Time")
        then begin
            Error('You cannot work outside working hours');
            CurrPage.Close();
        end;
    end;

    trigger OnOpenPage()

    var
        GLSetup: record "General Ledger Setup";
        CurrentTime: Time;
        userId: Code[20];

    begin

        // UserSetup.Get(UserId);



    end;
}
