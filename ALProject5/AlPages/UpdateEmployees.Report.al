report 50436 "Update Employees"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateEmployees.rdlc';

    dataset
    {
        dataitem("Update Items to Install"; "Update Items to Install")
        {

            trigger OnAfterGetRecord()
            begin

                itemledger.Reset;
                itemledger.SetRange(itemledger."Serial No.", "Update Items to Install"."Serial No");
                itemledger.SetRange(itemledger.Quantity, 1);
                if itemledger.Find('-') then begin
                    "Update Items to Install"."Location Code" := itemledger."Location Code";
                    "Update Items to Install".Modify;
                end;



                /*
                
                items.RESET;
                items.SETRANGE(items."No.","Update Items to Install"."Item No");
                IF items.FIND('-') THEN BEGIN
                "Update Items to Install"."Item Name":=items.Description;
                "Update Items to Install".MODIFY;
                END;
                
                customer.RESET;
                customer.SETRANGE(customer."No.","Update Items to Install"."Customer No");
                IF customer.FIND('-') THEN BEGIN
                "Update Items to Install"."Customer Name":=customer.Name;
                "Update Items to Install".MODIFY;
                END;
                
                
                employee.RESET;
                Employees.SETRANGE(Employees.st_no,"Update Items to Install"."Staff No");
                IF Employees.FIND('-') THEN BEGIN
                "Update Items to Install"."Staff Name":=Employees.Name;
                "Update Items to Install".MODIFY;
                END;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjCust: Record Customer;
        membledger: Record "Member Ledger Entry";
        iEntryNo: Integer;
        CFTfactory: Codeunit "CFT Factory";
        employee: Record pr_employees;
        prtransactions: Record pr_transaction_types;
        tspecification: Record "Tracking Specification";
        sourceref: Integer;
        prEmployees: Record pr_allowances_and_deductions;
        RequisitionHeader: Record "Store Requistion Headerr";
        ReqHeader: Record "Store Requistion Headerr";
        ItemImportation: Record "Item importation";
        itemledger: Record "Item Ledger Entry";
        ccount: Decimal;
        NoSeries: Record "No. Series Line";
        serialNo: Code[40];
        ledger: Record "Item Ledger Entry";
        items: Record Item;
        customer: Record Customer;
        Employees: Record pr_employees;
}

