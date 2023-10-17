tableextension 80004 "BA Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
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