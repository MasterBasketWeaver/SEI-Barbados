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
        field(80010; "BA Qty. on Sales Quote"; Decimal)
        {
            Caption = 'Qty. on Open Sales Quote';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)"
            where("Document Type" = Const(Quote), Type = Const(Item), "No." = Field("No."),
                "Shortcut Dimension 1 Code" = Field("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = Field("Global Dimension 2 Filter"),
                "Location Code" = Field("Location Filter"), "Drop Shipment" = Field("Drop Shipment Filter"), "Variant Code" = Field("Variant Filter"),
                "Shipment Date" = Field("Date Filter"), "BA Stage" = const(Open)));
            DecimalPlaces = 0 : 5;
        }
        field(80011; "BA Qty. on Closed Sales Quote"; Decimal)
        {
            Caption = 'Qty. on Archived Sales Quote';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)"
            where("Document Type" = Const(Quote), Type = Const(Item), "No." = Field("No."),
                "Shortcut Dimension 1 Code" = Field("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = Field("Global Dimension 2 Filter"),
                "Location Code" = Field("Location Filter"), "Drop Shipment" = Field("Drop Shipment Filter"), "Variant Code" = Field("Variant Filter"),
                "Shipment Date" = Field("Date Filter"), "BA Stage" = Filter(Archive | "Closed/Lost" | "Closed/Other")));
            DecimalPlaces = 0 : 5;
        }
    }

    trigger OnAfterInsert()
    begin
        Rec."BA Created By" := UserId();
        Rec."BA Created At" := Today();
        Rec.Modify(false);
    end;
}