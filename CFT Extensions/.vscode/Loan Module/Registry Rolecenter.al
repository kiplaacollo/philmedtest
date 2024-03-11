page 51001 "Registry Rolecenter1"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(RoleCenter)
        {
            part(systemadminheadline; "System Admin Headline")
            {
                ApplicationArea = basic, suite;
            }
            part(systemadminactivities; "Sacco Activities")
            {
                ApplicationArea = basic, suite;
            }
            // part(myaccounts; "My Accounts")
            // {
            //     ApplicationArea = basic, suite;
            // }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Sacco)
            {
                group("Basic Configurations")
                {
                    action(Employers)
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50102;
                    }
                    action("Employer Departments")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50103;
                    }
                    action(Counties)
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50104;
                    }
                    action("Back Office Groups")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50120;
                    }
                    action("Notifications Setup")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50105;
                    }
                    action("Common Direct Posting G/Ls")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50106;
                    }
                    action("BO General Setup")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50101;
                    }
                    action("Savings Products")
                    {
                        ApplicationArea = all;
                        RunObject = page 50084;
                    }
                    action("cr transaction types")
                    {
                        ApplicationArea = all;
                        RunObject = page "cr transaction types list";
                    }
                }
                group("Registry Module")
                {

                    group("Back Office")
                    {
                        action("BO Application List")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50121;
                        }
                        action("BO Member Register")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50126;
                        }
                    }
                    group("Front Office")
                    {
                        action("Savings Application List")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50080;
                        }
                        action("Savings Accounts List")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50082;
                        }
                    }
                }
                group("Loan Module")
                {
                    group(Configurations)
                    {

                        action("Loan Products")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50108;
                        }

                        action("Payslip Items Setup")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50110;
                        }
                        action("Loan IFRS Provision Setup")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50148;
                        }
                        action("Loan Classification")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50149;
                        }
                        action("Loan Purpose Setup")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50213;
                        }
                        action("Repayment Holiday")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page 50218;
                        }
                    }
                    group("Loan Processes")
                    {
                        action("Loans List(New)")
                        {
                            RunObject = page 50140;
                        }
                        action("Loans List(Pending)")
                        {
                            RunObject = page 50142;
                        }
                        action("Loans List(Approved)")
                        {
                            RunObject = page 50144;
                        }
                        action("Loans List(Posted)")
                        {
                            RunObject = page 50146;
                        }
                        action("Loans List(Rejected)")
                        {
                            RunObject = page 50231;
                        }
                        action("Interest Accrual")
                        {
                            RunObject = page "Accrual Header List";
                        }
                        action("Interest Accrual(Posted)")
                        {
                            RunObject = page "Accrual Header List posted";
                        }
                        action("Defaulter Notifications")
                        {
                            RunObject = page "Defaulter Notifications List";
                        }

                    }
                    group("Loan Disbursement")
                    {
                        action("Disbursement List(New)")
                        {
                            RunObject = page 50162;
                        }
                        action("Disbursement List(Pending)")
                        {
                            RunObject = page 50164;
                        }
                        action("Disbursement List(Approved)")
                        {
                            RunObject = page 50166;
                        }
                        action("Disbursement List(Posted)")
                        {
                            RunObject = page 50168;
                        }
                    }
                }
                group(Utilities)
                {
                    action("Loan Calculation List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50178;
                    }
                    action("Deviation Matrix Details")
                    {
                        ApplicationArea = basic, suite;
                    }
                }
                group("Collateral Module")
                {
                    action("Collateral Register List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50185;
                    }
                }

                group(Checkoff)
                {
                    action("Checkoff Advice List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50203;
                    }
                    action("Checkoff Summary")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50212;
                    }
                    action("Checkoff list(Open)")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Checkoff header list";
                    }
                    action("Checkoff List(Posted)")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Checkoff List(Posted)";
                    }
                }
            }

            group("Financial Management")

            {
                Caption = 'Financial Management';
                group("General Ledger")
                {
                    action("Chart of Accounts")
                    {
                        RunObject = page 16;
                    }
                    action("General Journals")
                    {
                        RunObject = page 39;
                    }
                }
                group("Cash Management")
                {
                    action("Bank Accounts")
                    {
                        RunObject = page 371;
                    }
                }
                group("Cost Accounting")
                {
                    action("Cost Journals")
                    {
                        RunObject = page 1108;
                    }
                }
                action("Cash Flow")
                {
                    ApplicationArea = basic, suite;
                }
                action(Receivables)
                {
                    ApplicationArea = basic, suite;
                }
                action("Fixed Assets")
                {
                    ApplicationArea = basic, suite;
                }
                action(Inventory)
                {
                    ApplicationArea = basic, suite;
                }


            }

            group("HR & Payroll")
            {
                group("Payroll Configurations")
                {
                    action("Payroll Periods")
                    {
                        ApplicationArea = all;
                        RunObject = page 50420;
                    }
                    action("NSSF Rates")
                    {
                        ApplicationArea = all;
                        RunObject = page 50422;
                    }
                    action("NHIF Rates")
                    {
                        RunObject = page 50421;
                    }
                    action("RM Rewards")
                    {
                        RunObject = page 50431;
                    }
                    action("Tax Brackets Setup")
                    {
                        ApplicationArea = all;
                        RunObject = page 50111;
                    }
                    action("Payroll Transaction Types")
                    {
                        ApplicationArea = all;
                        RunObject = page 50423;
                    }
                    action("Payroll Statutory Transactions Types")
                    {
                        ApplicationArea = all;
                        RunObject = page 50430;
                    }
                    action("Annual Holidays")
                    {
                        ApplicationArea = all;
                        RunObject = page 50550;
                    }
                    action("Payroll General Setup")
                    {
                        ApplicationArea = all;
                        RunObject = page 50428;
                    }
                }
                group("Employees Management")
                {
                    action("Payroll Employees")
                    {
                        ApplicationArea = all;
                        RunObject = page 50425;
                    }
                    action("Payroll Exited Employees List")
                    {
                        ApplicationArea = all;
                        RunObject = page 50426;
                    }
                }
                group("Leave Management")
                {
                    action("HR Setup")
                    {
                        ApplicationArea = all;
                        RunObject = page 50445;
                    }
                    action("HR Leave Types")
                    {
                        ApplicationArea = all;
                        RunObject = page 50441;
                    }
                }
                group("Periodic Activities")
                {
                    action("Payroll Journal Transfer")
                    {
                        ApplicationArea = all;
                        RunObject = report 50422;
                    }
                    action("Netpay Journal Transfer")
                    {
                        ApplicationArea = all;
                        RunObject = report 50423;
                    }
                    action("General Journal")
                    {
                        ApplicationArea = all;
                        RunObject = page 39;
                    }
                }
            }
            group("Funds Management")
            {
                group("Cheques/Cash/Transfers")
                {
                    action("Petty Cash List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50012;
                    }
                    action("Payment Voucher List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50000;
                    }
                    action("Trade Customer Receipt List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50024;

                    }
                    action("Bank Transfer list")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50030;
                    }


                    action("Member Receipt List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50061;
                    }

                }
                group("Imprest Requisitions")
                {
                    action("Imprest Requisition List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50036;
                    }
                    action("Imprest Surrender List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50039;
                    }
                }
                group("Posted Documents")
                {
                    action("Posted BO Receipt List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50064;
                    }
                    action("Posted Receipt Header List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50027;
                    }
                    action("Posted PettyCash Payment List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50015;
                    }
                    action("Posted Funds Transfer List ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50033;
                    }
                    action("Posted Payments Voucher")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50003;
                    }
                    action("Posted Imprest Requisition List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50043;
                    }
                    action("Posted Imprest Surrender List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50046;
                    }
                }
                group(Setup)
                {
                    action("Funds User Setup")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50051;
                    }
                    action("Budgetary Control Setup")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50060;
                    }
                    action("General Setup")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50050;
                    }
                    action("Payment Types List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page 50054;
                    }

                }

            }
        }
        area(Processing)
        {
            action("Deposits Report")
            {
                ApplicationArea = basic, suite;
                RunObject = report DepositsReport;
                Image = "Report";
            }
            action("Loan List as per SASRA")
            {
                ApplicationArea = basic, suite;
                RunObject = report LoanListAsPerSasra;
                Image = Report;
            }
            action("Share Capital Report")
            {
                ApplicationArea = basic, suite;
                RunObject = report ShareCapitalReport;
                Image = Report;
            }
            action("Member List Report")
            {
                ApplicationArea = basic, suite;
                RunObject = report MemberListReport;
                Image = Report;
            }
            action("Member Application List Report")
            {
                ApplicationArea = basic, suite;
                RunObject = report MemberApplicationListReport;
                Image = Report;
            }
            action("Loan Balances Report")
            {
                ApplicationArea = basic, suite;
                RunObject = report LoanBalancesReport;
                Image = Report;
            }
            action(Risk)
            {
                ApplicationArea = basic, suite;
                RunObject = report "Risk Classification Report";
                Image = Report;
            }
        }

    }

    var
        myInt: Integer;
}
profile "System Administrator"
{
    Caption = 'System Administrator';
    RoleCenter = "Registry Rolecenter1";
}