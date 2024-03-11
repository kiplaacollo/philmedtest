page 52005 "Checkoff Advice Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Advice";

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field("No."; Rec."No.")
                {

                }
                field("Last Advice Date"; Rec."Last Advice Date")
                {

                }
                field("Entry Date"; Rec."Entry Date")
                {

                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Name"; Rec."Employer Name")
                {

                }
                field("Total Count"; Rec."Total Count")
                {

                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
            }
            group("Checkoff Lines")
            {
                part(checkofflines; "Checkoff Advice Lines")
                {
                    SubPageLink = "No." = field("No.");
                }
            }
            group("Checkoff Allocation Lines")
            {
                Visible = false;

                part(checkoffallocations; "Checkoff Allocation Lines")
                {
                    SubPageLink = "No." = field("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load Advice Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = List;

                trigger OnAction()


                begin

                    clearcheckoffadvlines(Rec."No.");
                    boemployer.Reset();
                    boemployer.SetRange("Employer Code", Rec."Employer Code");
                    if boemployer.Find('-') then begin

                        repeat
                            fngeneratecheckofflinesdepositcontribution();

                            fninsertloans();
                        until boemployer.Next = 0;
                    end;
                end;
            }
            action("Load Checkoff Summary Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = List;

                trigger OnAction()
                begin
                    clearcheckoffsummary(Rec."No.");
                    Loadcheckoffsummarylines();
                    updatesummarytable(Rec."No.");
                    Message('Checkoff summary lines loaded successfully');
                end;
            }
            action("Generate Checkoff")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = List;
                trigger OnAction()
                begin
                    checkoffheader.Init();
                    if checkoffheader."No." = '' then begin
                        recGeneralSetup.Get();
                        recGeneralSetup.TestField(recGeneralSetup."Checkoff Header NOS");
                        NoSeriesMngt.InitSeries(recGeneralSetup."Checkoff Header NOS", recGeneralSetup."Checkoff Header NOS", 0D, checkoffheader."No.", recGeneralSetup."Checkoff Header NOS");
                    end;
                    checkoffheader."Employer Code" := Rec."Employer Code";
                    checkoffheader."Employer Name" := Rec."Employer Name";
                    checkoffheader."Manual Checkoff" := true;
                    checkoffheader."Global Dimension Code 1" := 'BOSA';
                    checkoffheader."Account Type" := 'Customer';
                    checkoffheader."Document No" := Rec."No.";
                    checkoffheader."Checkoff Type" := checkoffheader."Checkoff Type"::Distributed;
                    checkoffheader."Posting Date" := Rec."Posting Date";
                    checkoffheader."Loan Cutoff Date" := Rec."Loan Cutoff Date";
                    checkoffheader.Remarks := Rec.Remarks;
                    employer.Reset();
                    employer.SetRange(Code, Rec."Employer Code");
                    if employer.Find('-') then begin
                        checkoffheader."Account No" := employer."Associated Customer No";
                        checkoffheader."Account Name" := employer.Description;
                    end;
                    checkoffheader.Insert(true);
                    loadlines();
                    clearallocationlines();
                    generateallocations();

                    Message('Checkoff Generated Successfully');
                end;
            }
        }
    }

    procedure clearcheckoffadvlines(No: Code[50])
    begin
        checkofflines.Reset();
        checkofflines.SetRange(checkofflines."No.", No);
        if checkofflines.FindSet() then begin
            checkofflines.DeleteAll();

        end;
    end;

    procedure clearcheckoffsummary(No: Code[50])
    begin
        checkoffsummary.Reset();
        checkoffsummary.SetRange(checkoffsummary."No.", No);
        if checkoffsummary.FindSet() then begin
            checkoffsummary.DeleteAll();
        end;
    end;

    procedure fngeneratecheckofflinesdepositcontribution()
    var
    // boemployer: Record Customer;
    begin
        monthlydeductions.Reset();
        monthlydeductions.SetRange("Client Code", boemployer."No.");
        if monthlydeductions.Find('-') then begin

            repeat
                checkofflines.Init();
                checkofflines."No." := Rec."No.";
                checkofflines."Client Code" := boemployer."No.";
                checkofflines."Client Name" := boemployer."Full Name";
                checkofflines."Payroll Number" := boemployer."Payroll Number";
                checkofflines."Entry No" := Entryno;
                checkofflines."Transaction Type" := monthlydeductions."Transaction Type";
                checkofflines.Description := monthlydeductions."Transaction Type";
                checkofflines."Deduction Code" := monthlydeductions."Transaction Type";
                checkofflines."Employer Code" := Rec."Employer Code";
                checkofflines.Amount := monthlydeductions.Amount;
                checkofflines."Phone No" := boemployer."Mobile Number";
                if checkofflines.Amount > 0 then
                    checkofflines.Insert(true);

            until monthlydeductions.Next = 0;
        end;

    end;


    procedure fninsertloans()
    begin
        // Error('outstanding loan is:%1');
        loans.Reset();
        loans.SetRange("Member Number", boemployer."No.");
        loans.SetRange(Posted, true);
        loans.SetFilter("Repayment Debut Date", '<=%1', Rec."Loan Cutoff Date");

        loans.SetFilter("New Outstanding Loan", '>%1', 0);
        if loans.Find('-') then begin
            repeat
                checkofflines.Init();
                checkofflines."No." := Rec."No.";
                checkofflines."Client Code" := boemployer."No.";
                checkofflines."Client Name" := boemployer."Full Name";
                checkofflines."Payroll Number" := boemployer."Payroll Number";
                checkofflines."Entry No" := Entryno;
                checkofflines."Transaction Type" := 'Loan Repayment';
                checkofflines.Description := 'Loan Repayment';
                checkofflines."Deduction Code" := loans."Loan Product";
                checkofflines."Employer Code" := Rec."Employer Code";
                checkofflines.Amount := ((loans."Principal Repayment") + (loans."Outstanding Interest"));
                checkofflines."Loan Number" := loans."Loan Number";
                checkofflines.Principal := loans."Principal Repayment";
                checkofflines.Interest := loans."Outstanding Interest";
                checkofflines."Phone No" := boemployer."Mobile Number";
                // Error('outstanding loan is:%1', loans."New Outstanding Loan");
                if checkofflines.Amount > 0 then
                    checkofflines.Insert(true);

            until loans.Next = 0;
        end;
    end;

    procedure fninsertfosasavings()
    begin
        checkofflines.Init();
        checkofflines."No." := Rec."No.";
        checkofflines."Client Code" := boemployer."No.";
        checkofflines."Client Name" := boemployer."Full Name";
        checkofflines."Payroll Number" := boemployer."Payroll Number";
        checkofflines."Entry No" := Entryno;
        checkofflines."Transaction Type" := 'Savings';
        checkofflines.Description := boemployer."FO Account Type";
        checkofflines."Deduction Code" := boemployer."FO Account Type";
        checkofflines."Employer Code" := Rec."Employer Code";
        checkofflines.Amount := boemployer."Share Capital";
        if checkofflines.Amount > 0 then
            checkofflines.Insert(true);
    end;

    procedure Loadcheckoffsummarylines()
    begin
        boemployer.Reset();
        boemployer.SetRange("Employer Code", Rec."Employer Code");
        // Error('Employer Code is%1', Rec."Employer Code");
        if boemployer.find('-') then begin
            repeat
                checkoffsummary.Init();
                checkoffsummary."No." := Rec."No.";
                checkoffsummary."Client Code" := boemployer."No.";
                checkoffsummary."Client Name" := boemployer."Full Name";
                checkoffsummary."Payroll Number" := boemployer."Payroll Number";
                checkoffsummary."Entry No" := Entryno;
                checkoffsummary."Phone Number" := boemployer."Mobile Number";

                if checkoffsummary."Client Code" <> '' then
                    checkoffsummary.Insert(true);

            until boemployer.Next = 0;
        end;
    end;

    procedure updatesummarytable(No: Code[50])
    begin
        checkoffsummary.Reset();
        checkoffsummary.SetRange(checkoffsummary."No.", No);
        if checkoffsummary.Find('-')
        then begin
            repeat
                checkofflines.Reset();
                checkofflines.SetRange("No.", No);
                checkofflines.SetRange("Client Code", checkoffsummary."Client Code");
                if checkofflines.Find('-') then begin
                    repeat
                        if checkofflines."Transaction Type" = 'Share Capital' then begin
                            checkoffsummary."Share Capital" := checkofflines.Amount;
                        end;
                        if checkofflines."Transaction Type" = 'Deposit Contribution' then begin
                            checkoffsummary."Deposit Contribution" := checkofflines.Amount;
                        end;
                        if checkofflines."Transaction Type" = 'Registration Fees' then begin
                            checkoffsummary."Registration Fees" := checkofflines.Amount;
                        end;
                        //Dev Principle
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Principal > 0) AND (checkofflines."Deduction Code" = 'DEV') then begin
                            checkoffsummary."Dev Prin" := checkofflines.Amount;
                            Message('Development amount for member%1,%2', checkoffsummary."Client Code", checkofflines.Amount);
                        end;
                        // Dev Interest
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Interest > 0) AND (checkofflines."Deduction Code" = 'DEV') then begin
                            checkoffsummary."Dev Int" := checkofflines.Amount;
                        end;
                        //Bridge Principle
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Principal > 0) AND (checkofflines."Deduction Code" = 'BRIDGE') then begin
                            checkoffsummary."Bridge Prin" := checkofflines.Amount;
                        end;
                        // Bridge Interest
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Interest > 0) AND (checkofflines."Deduction Code" = 'BRIDGE') then begin
                            checkoffsummary."Bridge Int" := checkofflines.Amount;
                        end;
                        //Flexi Principle
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Principal > 0) AND (checkofflines."Deduction Code" = 'FLEXI') then begin
                            checkoffsummary."Flexi Prin" := checkofflines.Amount;
                        end;
                        // Flexi Interest
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Interest > 0) AND (checkofflines."Deduction Code" = 'FLEXI') then begin
                            checkoffsummary."Flexi Int" := checkofflines.Amount;
                        end;
                        //Platinum Principle
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Principal > 0) AND (checkofflines."Deduction Code" = 'PLATINUM') then begin
                            checkoffsummary."Platinum Prin" := checkofflines.Amount;
                        end;
                        // Platinum Interest
                        if (checkofflines."Transaction Type" = 'Loan') AND (checkofflines.Interest > 0) AND (checkofflines."Deduction Code" = 'PLATINUM') then begin
                            checkoffsummary."Platinum Int" := checkofflines.Amount;
                        end;
                    // Message('Development amount for member%1,%2,%3', checkoffsummary."Client Code", checkofflines.Amount, checkofflines."Deduction Code");


                    until checkofflines.Next = 0;
                    checkoffsummary.Modify(true);
                end;

            until checkoffsummary.Next = 0;
        end;
    end;

    procedure loadlines()
    begin

        checkoffsummary.Reset();
        checkoffsummary.SetRange("No.", Rec."No.");
        if checkoffsummary.Find('-') then begin
            repeat
                checkoffsummary.CalcFields(Total);
                checkoffheaderlines.Init();
                checkoffheaderlines."No." := checkoffheader."No.";
                checkoffheaderlines."Entry No" := Entryno;
                checkoffheaderlines."Client Code" := checkoffsummary."Client Code";
                checkoffheaderlines."Client Name" := checkoffsummary."Client Name";
                checkoffheaderlines."Payroll Number" := checkoffsummary."Payroll Number";
                checkoffheaderlines."Employer Code" := Rec."Employer Code";
                checkoffheaderlines."Phone No" := checkoffsummary."Phone Number";
                checkoffheaderlines.Amount := checkoffsummary.Total;
                if checkoffheaderlines.Amount <> 0
                then
                    checkoffheaderlines.Insert(true);
            until checkoffsummary.Next() = 0;

        end;
    end;

    procedure generateallocations()
    begin
        checkofflines.Reset();
        checkofflines.SetRange(checkofflines."No.", rec."No.");
        // Message('Members found%1', checkofflines."Client Code");
        if checkofflines.Find('-') then begin
            repeat

                checkoffallocationlines.Init();
                checkoffallocationlines."No." := checkofflines."No.";
                checkoffallocationlines."Entry No" := Entryno;
                checkoffallocationlines."Advice No" := checkoffheader."No.";
                checkoffallocationlines."Transaction Type" := checkofflines."Transaction Type";
                checkoffallocationlines.Amount := checkofflines.Amount;
                checkoffallocationlines."Client Code" := checkofflines."Client Code";
                checkoffallocationlines."Client Name" := checkofflines."Client Name";
                checkoffallocationlines."Loan No" := checkofflines."Loan Number";
                checkoffallocationlines.Insert(true);

            until checkofflines.Next = 0;
        end;

    end;

    procedure clearallocationlines()
    begin
        checkoffallocationlines.Reset();
        checkoffallocationlines.SetRange(checkoffallocationlines."No.", Rec."No.");
        if checkoffallocationlines.FindSet() then begin
            checkoffallocationlines.DeleteAll();
        end;
    end;

    var
        myInt: Integer;
        checkofflines: Record "Checkoff Adv Line";
        boemployer: Record Customer;

        Entryno: Integer;
        loans: Record Loans;
        monthlydeductions: Record "Member deductions table";
        checkoffsummary: Record "Checkoff Summary Table";
        checkoffheader: Record "Checkoff Header";
        recGeneralSetup: Record "Funds General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        employer: Record "BO Employer";
        checkoffheaderlines: Record "Checkoff Lines Table";
        checkoffallocationlines: Record "Checkoff Allocation Lines";
}