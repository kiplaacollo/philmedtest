page 50222 "Defaulter Notifications Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Defaulter Notifications Header";

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Notification Type Period"; Rec."Notification Type Period")
                {

                }
                field("Notification Date"; Rec."Notification Date")
                {

                }
                field("Notification Type"; Rec."Notification Type")
                {

                }

            }
            group("Loan Notifications")
            {
                part(LoanNotifications; "Loan Notifications List Part")
                {
                    SubPageLink = "Document No" = field("Document No");

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load Notification Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;

                trigger OnAction()
                begin
                    ClearNotificationLines();
                    //Check Notification Type From Header

                    ObjLoans.Reset();
                    ObjLoans.SetRange(ObjLoans."Loan Category", ObjLoans."Loan Category"::Loss);
                    ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
                    ObjLoans.SetRange(ObjLoans.Posted, true);
                    if (Rec."Notification Type" = Rec."Notification Type"::"First Defaulter Notification") then
                        ObjLoans.SetRange(ObjLoans."First Defaulter Notification", true);
                    ObjLoans.SetRange(ObjLoans."First Defaulter Notification", false);
                    if rec."Notification Type" = Rec."Notification Type"::"Second Defaulter Notification" then begin
                        ObjLoans.SetRange(ObjLoans."First Defaulter Notification", true);
                        ObjLoans.SetRange(ObjLoans."Second Defaulter Notification", true);
                    end;

                    if Rec."Notification Type" = rec."Notification Type"::"Third Defaulter Notification" then
                        ObjLoans.SetRange(ObjLoans."Second Defaulter Notification", true);
                    if ObjLoans.Find('-') then begin

                        repeat
                            ObjLoans.CalcFields("New Outstanding Loan");
                            //Message('Loading Lines %1');
                            NotificationLines.Init();
                            NotificationLines."Document No" := Rec."Document No";
                            NotificationLines."Member Number" := ObjLoans."Member Number";
                            NotificationLines."Loan Number" := ObjLoans."Loan Number";
                            NotificationLines."Loan Amount" := ObjLoans."Approved Amount";
                            NotificationLines."Outstanding Balance" := ObjLoans."New Outstanding Loan";
                            NotificationLines."Amount In Arrears" := ObjLoans."Amount in Arrears";
                            NotificationLines."Date Issued" := ObjLoans."Disbursement Date";
                            NotificationLines."Notification Type" := rec."Notification Type";
                            NotificationLines."Received Message" := ObjLoans."Received Message";
                            NotificationLines."Received Email" := ObjLoans."Received Email";
                            NotificationLines."Last Date Notified" := ObjLoans."Last Updated";
                            NotificationLines."Notification Date" := Rec."Notification Date";
                            NotificationLines."Entry No" := entryNo;
                            NotificationLines."Phone Number" := ObjLoans."Mobile Number";
                            NotificationLines."Member Name" := ObjLoans."Full Name";
                            NotificationLines.Insert(true);

                        until ObjLoans.Next = 0;
                    end;
                    Message('Loan Notification entries generated successfully.');
                end;


            }

        }
    }

    procedure ClearNotificationLines()
    begin
        NotificationLines.Reset();
        NotificationLines.SetRange(NotificationLines."Document No", Rec."Document No");
        if NotificationLines.FindSet() then begin
            NotificationLines.DeleteAll();

        end;
    end;

    var
        myInt: Integer;
        NotificationLines: record "Loan Notifications Table";
        ObjLoans: Record Loans;
        entryNo: Integer;
}