tableextension 80000 "BA Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(80000; "BA Commission Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Invoice No.';
            TableRelation = "Sales Invoice Header"."No.";
        }
    }
}