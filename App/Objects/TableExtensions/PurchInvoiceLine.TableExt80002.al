tableextension 80002 "BA Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        field(80000; "BA Commission Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commission Invoice No.';
            TableRelation = "Sales Invoice Header"."No."; //
            Editable = false;
        }
    }
}