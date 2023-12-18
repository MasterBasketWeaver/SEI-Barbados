tableextension 80030 "BA Item" extends Item
{
    fields
    {
        field(80000; "BA Created By"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field(SystemCreatedBy)));
            Editable = false;
        }
    }
}