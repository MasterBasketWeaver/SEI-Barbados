tableextension 80009 "BA Vendor" extends Vendor
{
    fields
    {
        field(80020; "BA Created At"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }
        field(80021; "BA Created By"; Code[50])
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
        Rec.Modify(false);
    end;
}