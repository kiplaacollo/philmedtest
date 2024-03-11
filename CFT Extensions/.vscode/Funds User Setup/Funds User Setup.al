table 50013 "Funds User Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "User Setup";
        }
        field(11; "Receipt Journal Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(12; "Receipt Journal Batch"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Journal Template"));
            trigger OnValidate()
            begin
                // Check if the batch has been allocated to another user
                // UserTemp.Reset();
                // UserTemp.SetRange(UserTemp."Receipt Journal Template", "Receipt Journal Template");
                // UserTemp.SetRange(UserTemp."Receipt Journal Batch", "Receipt Journal Batch");
                // if UserTemp.FindFirst then begin
                //     repeat
                //         if (UserTemp."User ID" <> "User ID") and ("Receipt Journal Batch" <> '') then begin
                //             Error('Another User has been assigned to the batch:%1', "Receipt Journal Batch");
                //         end;
                //     until UserTemp.Next = 0;
                // end;
            end;
        }
        field(13; "Payment Journal Template"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(14; "Payment Journal Batch"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
            trigger OnValidate()
            begin
                // Check if the batch has been allocated to another user
                // UserTemp.Reset();
                // UserTemp.SetRange(UserTemp."Payment Journal Template", "Payment Journal Template");
                // UserTemp.SetRange(UserTemp."Payment Journal Batch", "Payment Journal Batch");
                // if UserTemp.FindFirst then begin
                //     repeat
                //         if (UserTemp."User ID" <> Rec."User ID") and ("Payment Journal Batch" <> '') then begin
                //             Error('Another User has been assigned to the batch:%1', "Receipt Journal Batch", "Payment Journal Batch");
                //         end;
                //     until UserTemp.Next = 0;
                // end;
            end;
        }
        field(15; "Petty Cash Template"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name;// where(Type = const(Payments));
        }
        field(16; "Petty Cash Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Template"));
            trigger OnValidate()
            begin
                // Check if the batch has been allocated to another user
                // UserTemp.Reset();
                // UserTemp.SetRange(UserTemp."Petty Cash Template", "Petty Cash Template");
                // UserTemp.SetRange(UserTemp."Petty Cash Batch", "Petty Cash Batch");
                // if UserTemp.FindFirst() then begin
                //     repeat
                //         if (UserTemp."User ID" <> Rec."User ID") and ("Petty Cash Batch" <> '') then begin
                //             Error('Another User has been assigned to the batch:%1', "Receipt Journal Batch", "Petty Cash Batch");
                //         end;
                //     until UserTemp.Next = 0;
                // end;
            end;
        }
        field(17; "FundsTransfer Template Name"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(18; "FundsTransfer Batch Name"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
            trigger OnValidate()
            begin
                // Check if the batch has been allocated to another user
                // UserTemp.Reset();
                // UserTemp.SetRange(UserTemp."FundsTransfer Template Name", "FundsTransfer Template Name");
                // UserTemp.SetRange(UserTemp."FundsTransfer Batch Name", "FundsTransfer Batch Name");
                // if UserTemp.FindFirst then begin
                //     repeat
                //         if (UserTemp."User ID" <> Rec."User ID") and ("FundsTransfer Batch Name" <> '') then begin
                //             Error('Another User has been assigned to the batch:%1', "Receipt Journal Batch", "Petty Cash Batch");
                //         end;
                //     until UserTemp.Next = 0;
                // end;
            end;
        }
        field(19; "Default Receipts Bank"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account"."No.";
        }
        field(20; "Default Payment Bank"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(21; "Default Petty Cash Bank"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account"."No.";
        }
        field(22; "Max. Cash Collection"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Max. Cheque Collection"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Max. Deposit Slip Collection"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Supervisor ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Bank Pay in Journal Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(27; "Bank Pay in Journal Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Pay in Journal Template"));
        }
        field(28; "Imprest Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(29; "Imprest Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(30; "Claim Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(31; "Claim Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Claim Template"));
        }
        field(32; "Advance Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(33; "Advance Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Template"));
        }
        field(34; "Advance Surr Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(35; "Advance Surr Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Surr Template"));
        }
        field(36; "Dim Change Journal Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(37; "Dim Change Journal Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Dim Change Journal Template"));
        }
        field(38; "Journal Voucher Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(39; "Journal Voucher Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Voucher Template"));
        }
        field(40; "Primary Key"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Payroll Template"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Payroll Batch"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Biling Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(44; "Biling Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch";
        }

    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        UserTemp: Record "Funds User Setup";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}