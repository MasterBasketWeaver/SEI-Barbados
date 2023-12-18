tableextension 80031 "BA Sales Line" extends "Sales Line"
{
    fields
    {
        field(80000; "BA Stage"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."ENC Stage" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            OptionMembers = " ","Open","Closed/Lost","Closed/Other","Archive";
            OptionCaption = ' ,Open,Closed/Lost,Closed/Other,Archive';
        }
    }
}