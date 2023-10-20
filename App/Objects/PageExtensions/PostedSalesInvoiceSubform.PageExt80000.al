pageextension 80000 "BA Posted Sales Inv. Subform" extends "Posted Sales Invoice Subform"
{
    actions
    {
        addafter(Dimensions)
        {
            action("BA Edit Dimensions")
            {
                ApplicationArea = all;
                Image = DimensionSets;
                Caption = 'Edit Dimensions';

                trigger OnAction()
                var
                    DimMgt: Codeunit "BA Dimension Mgt.";
                begin
                    DimMgt.EditSalesInvoiceLineDimensions(Rec);
                end;
            }
        }
    }
}