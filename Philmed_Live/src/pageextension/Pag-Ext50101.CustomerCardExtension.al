pageextension 50101 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            field("Current Balance"; Rec."Current Balance")
            {
                ApplicationArea = All;
            }
        }
        addafter(MobilePhoneNo)
        {
            field("MPESA Phone No."; Rec."MPESA Phone No.")
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("Customer Type"; Rec."Cash Sale Customer")
            {
                ApplicationArea = all;
            }

            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Customer Region"; Rec."Customer Region")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Cash Sale Customer"; Rec."Cash Sale Customer")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Eligible For Sales Gift"; Rec."Eligible For Sales Gift")
            {
                Visible = true;
                ApplicationArea = all;
            }

            field("Payroll No."; Rec."Payroll No.")
            {
                ApplicationArea = all;
            }
            field("Our Account No."; Rec."Our Account No.")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Customer Target"; "Customer Target")
            {
                Visible = true;
                ApplicationArea = all;
            }

        }
        addlast(Payments)
        {
            field("Last Payment Date"; Rec."Last Payment Date")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field(Dormant; Rec.Dormant)
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("PD Cheques Total"; Rec."PD Cheques Total")
            {
                ToolTip = 'Post Dated Cheques Total Issued by the Customer';
                ApplicationArea = all;
            }
            field("Account Creation Date"; Rec."Account Creation Date")
            {
                ApplicationArea = all;
            }


        }
        modify("Balance (LCY)")
        {
            Visible = false;
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }

        modify("Currency Code")
        {
            ShowMandatory = true;
        }

    }
    actions
    {
        modify("Report Statement")
        {
            trigger OnBeforeAction()

            var
                Customer: Record Customer;
                CustomReportSelection: Record "Custom Report Selection";
                CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                RecRef: RecordRef;
                StatementFileNameTxt: Label 'Statement', Comment = 'Shortened form of ''Customer Statement''';
            begin
                RecRef.Open(Database::Customer);
                CustomLayoutReporting.SetOutputFileBaseName(StatementFileNameTxt);
                CustomReportSelection.SetRange(Usage, "Report Selection Usage"::"C.Statement");
                if CustomReportSelection.FindFirst() then
                    CustomLayoutReporting.SetTableFilterForReportID(CustomReportSelection."Report ID", "No.")
                else
                    CustomLayoutReporting.SetTableFilterForReportID(Report::"Philmed Standard Statement", "No.");
                CustomLayoutReporting.ProcessReportData(
                    "Report Selection Usage"::"C.Statement", RecRef, Customer.FieldName("No."),
                    Database::Customer, Customer.FieldName("No."), true);

                //Skip The standard
                Error('');
            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        rec.CalcFields("Last Payment Date", Balance);
        if rec."Last Payment Date" <> 0D then begin
            if (Today - Rec."Last Payment Date" >= 120) and (Rec.Balance <> 0) then
                rec.Dormant := true
            else
                rec.Dormant := False;

            Rec.Modify()
        end;
    end;

    trigger OnClosePage()
    begin
        TestField("Currency Code");
    end;

}
