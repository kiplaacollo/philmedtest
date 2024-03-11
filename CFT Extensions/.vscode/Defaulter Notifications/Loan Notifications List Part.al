page 50224 "Loan Notifications List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Notifications Table";
    Caption = 'Functions';

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Member Number"; Rec."Member Number")
                {

                }
                field("Member Name"; Rec."Member Name")
                {

                }
                field("Phone Number"; Rec."Phone Number")
                {

                }
                field("Loan Amount"; Rec."Loan Amount")
                {

                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {

                }
                field("Guaranteed Amount"; Rec."Guaranteed Amount")
                {

                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {

                }
                field("Date Issued"; Rec."Date Issued")
                {

                }
                field("Received Message"; Rec."Received Message")
                {

                }
                field("Received Email"; Rec."Received Email")
                {

                }
                field("Notification Date"; Rec."Notification Date")
                {

                }
                field("Notification Type"; Rec."Notification Type")
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Preview Demand Notice")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin

                end;

            }
            action("View Member Guarantors")
            {
                ApplicationArea = All;
                RunObject = page "Guarantors(New)";
                RunPageLink = "Loan Number" = field("Loan Number");
            }
            action("Send SMS  to defaulter Only")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                    notLines.Reset();
                    notLines.SetRange(notLines."Loan Number", Rec."Loan Number");
                    if notLines.Find('-') then begin

                        txtmessage := '';
                        amountArrears := notLines."Amount In Arrears";
                        MemberName := notLines."Member Name";

                        //txtmessage := 'Dear ' + notLines."Member Name" + ',You are in default of your obligation to make payments on your {{{loan_product}}} of Ksh ' + Format(amountArrears) + ' and outstanding balance of ksh' + Format(notLines."Outstanding Balance") + ' .Unless the full amount is received within 15 days, we have no choice but to begin the recovery process and take a full fledged legal action against you to recover the amount. Dial *670# to Confirm your balances';
                        txtmessage := 'Dear ' + notLines."Member Name" + ',You are in default of your obligation to make payments on your {{{loan_product}}} of Ksh ' + Format(amountArrears) + ' and outstanding balance of ksh' + Format(notLines."Outstanding Balance");
                        cftfactory.fnsendmessage(notLines."Member Number", notLines."Phone Number", 'DEFAULTER NOTIFICATION', txtmessage);

                        Message('Notifications to Defaulter successfully sent');
                        notLines."Received Message" := true;
                        notLines."Last Date Notified" := TODAY;
                        notLines.Modify();
                        objloans.Reset();
                        objloans.SetRange(objloans."Loan Number", notLines."Loan Number");
                        if objloans.Find('-') then
                            if notLines."Notification Type" = notLines."Notification Type"::"First Defaulter Notification" then begin
                                objloans."Received Message" := true;
                                objloans."First Defaulter Notification" := true;
                                objloans."Last Updated" := notLines."Date Issued";
                            end;
                        if notLines."Notification Type" = notLines."Notification Type"::"Second Defaulter Notification" then begin
                            objloans."Received Message" := true;
                            objloans."Second Defaulter Notification" := true;
                            objloans."Last Updated" := notLines."Date Issued";
                        end;
                        if notLines."Notification Type" = notLines."Notification Type"::"Third Defaulter Notification" then begin
                            objloans."Received Message" := true;
                            objloans."Third Defaulter Notification" := true;
                            objloans."Last Updated" := notLines."Date Issued";
                        end;

                        objloans.Modify();

                    end;
                end;
            }
            action("Send SMS Notifications to Defaulter And Guarantors")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    notLines.Reset();
                    notLines.SetRange(notLines."Loan Number", Rec."Loan Number");
                    if notLines.Find('-') then begin

                        txtmessage := '';
                        amountArrears := notLines."Amount In Arrears";
                        MemberName := notLines."Member Name";

                        //txtmessage := 'Dear ' + notLines."Member Name" + ',You are in default of your obligation to make payments on your loan of Ksh ' + Format(amountArrears) + ' and outstanding balance of ksh' + Format(notLines."Outstanding Balance") + ' .Unless the full amount is received within 15 days, we have no choice but to begin the recovery process and take a full fledged legal action against you to recover the amount.';
                        txtmessage := 'Dear ' + notLines."Member Name" + ', You are in default of your obligation to make payments on your {{{loan_product}}} of Ksh ' + Format(amountArrears) + ' and outstanding balance of ksh' + Format(notLines."Outstanding Balance");
                        cftfactory.fnsendmessage(notLines."Member Number", notLines."Phone Number", 'DEFAULTER NOTIFICATION', txtmessage);


                        //Notify Guarantors
                        objGuarantors.Reset();
                        objGuarantors.SetRange(objGuarantors."Loan Number", notLines."Loan Number");
                        if objGuarantors.Find('-') then begin
                            repeat
                                //Set SMS
                                guarantorPhone := objGuarantors."Phone No";

                                txtmessage := '';
                                amountArrears := notLines."Amount In Arrears";
                                MemberName := notLines."Member Name";
                                notLines.CalcFields(notLines."Guaranteed Amount");
                                gd := (objGuarantors."Guaranteed Amount" / notLines."Guaranteed Amount") * notLines."Outstanding Balance";

                                txtmessage := 'Loan Default Notice ' + objGuarantors."Guarantor Full Name" + ',you guaranteed ' + objGuarantors."Loanee Full Name" + ' an amount of ' + Format(objGuarantors."Guaranteed Amount") + ' The loanee has since defaulted in payment. Liase with the sacco office on how to pay Ksh ' + Format(gd) + ' being the guarantee due.';
                                cftfactory.fnsendmessage(objGuarantors."Guarantor Full Name", guarantorPhone, 'DEFAULTER NOTIFICATION', txtmessage);

                            until objGuarantors.Next = 0;
                        end;
                        //End
                        //Update Notification Lines
                        notLines."Received Message" := true;
                        notLines."Last Date Notified" := TODAY;
                        notLines.Modify();

                        objloans.Reset();
                        objloans.SetRange(objloans."Loan Number", notLines."Loan Number");
                        if objloans.Find('-') then
                            if notLines."Notification Type" = notLines."Notification Type"::"First Defaulter Notification" then begin
                                objloans."Received Message" := true;
                                objloans."First Defaulter Notification" := true;
                                objloans."Last Updated" := notLines."Date Issued";
                            end;
                        if notLines."Notification Type" = notLines."Notification Type"::"Second Defaulter Notification" then begin
                            objloans."Received Message" := true;
                            objloans."Second Defaulter Notification" := true;
                            objloans."Last Updated" := notLines."Date Issued";
                        end;
                        if notLines."Notification Type" = notLines."Notification Type"::"Third Defaulter Notification" then begin
                            objloans."Received Message" := true;
                            objloans."Third Defaulter Notification" := true;
                            objloans."Last Updated" := notLines."Date Issued";
                        end;

                        objloans.Modify();


                    end;
                    Message('Notifications to Defaulter And Guarantors successfully sent');
                end;

            }
            action("Send Email To Defaulter Only")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
            action("Send Emails To Defaulter And Guarantors")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }

    }

    var
        myInt: Integer;
        notLines: Record "Loan Notifications Table";
        txtmessage: Text;
        cftfactory: Codeunit "CFT Factory";
        amountArrears: Decimal;
        MemberName: Text[50];
        objloans: Record Loans;
        objGuarantors: Record "Guarantors Table";
        guarantorPhone: Code[20];
        gd: Decimal;

}