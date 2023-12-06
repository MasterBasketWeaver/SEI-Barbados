tableextension 80024 "BA Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(80000; "BA Commission Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Invoice No.';
            TableRelation = "Sales Invoice Header"."No.";
            Editable = false;
        }
    }
}