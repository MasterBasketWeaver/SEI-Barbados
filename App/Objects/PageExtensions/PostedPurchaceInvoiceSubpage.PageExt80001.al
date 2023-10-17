pageextension 80001 "BA Posted Purch. Inv. Subpage" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BA Commission Invoice No."; Rec."BA Commission Invoice No.")
            {
                ApplicationArea = all;
                ShowMandatory = RequireCommission;
            }
        }
    }




    trigger OnAfterGetCurrRecord()
    begin
        UpdateCommessionRequirement();
    end;

    local procedure UpdateCommessionRequirement()
    var
        GLAccount: Record "G/L Account";
    begin
        RequireCommission := (Rec.Type = Rec.Type::"G/L Account") and GLAccount.Get(Rec."No.") and GLAccount."BA Require Commission No.";
    end;

    var
        [InDataSet]
        RequireCommission: Boolean;
}