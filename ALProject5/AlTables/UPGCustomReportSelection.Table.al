table 104053 "UPG Custom Report Selection"
{

    fields
    {
        field(1; "Source Type"; Integer)
        {
        }
        field(2; "Source No."; Code[20])
        {
        }
        field(3; Usage; Option)
        {
            Caption = 'Usage';
            OptionMembers = "S.Quote","S.Order","S.Invoice","S.Cr.Memo","S.Test","P.Quote","P.Order","P.Invoice","P.Cr.Memo","P.Receipt","P.Ret.Shpt.","P.Test","B.Stmt","B.Recon.Test","B.Check",Reminder,"Fin.Charge","Rem.Test","F.C.Test","Prod. Order","S.Blanket","P.Blanket",M1,M2,M3,M4,Inv1,Inv2,Inv3,"SM.Quote","SM.Order","SM.Invoice","SM.Credit Memo","SM.Contract Quote","SM.Contract","SM.Test","S.Return","P.Return","S.Shipment","S.Ret.Rcpt.","S.Work Order","Invt. Period Test","SM.Shipment","S.Test Prepmt.","P.Test Prepmt.","S.Arch. Quote","S.Arch. Order","P.Arch. Quote","P.Arch. Order","S. Arch. Return Order","P. Arch. Return Order","Asm. Order","P.Assembly Order","S.Order Pick Instruction",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"C.Statement","V.Remittance";
        }
        field(4; Sequence; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Report ID"; Integer)
        {
        }
        field(7; "Custom Report Layout ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Source Type", "Source No.", Usage, Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

