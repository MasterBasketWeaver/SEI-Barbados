pageextension 80004 "BA Purch. Cr. Memo Subpage" extends "Purch. Cr. Memo Subform"
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
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                UpdateCommessionRequirement();
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                UpdateCommessionRequirement();
            end;
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