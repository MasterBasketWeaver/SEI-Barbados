tableextension 80030 "BA Item" extends Item
{
    fields
    {
        field(80000; "BA Created At"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created At';
            Editable = false;
        }
        field(80001; "BA Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
    }

    trigger OnAfterInsert()
    begin
        Rec."BA Created By" := UserId();
        Rec."BA Created At" := Today();
    end;
}