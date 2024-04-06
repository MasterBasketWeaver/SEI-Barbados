tableextension 80041 "BA Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(75000; "ENC No. 2"; Code[20])
        {
            Caption = 'No. 2';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(true)) "G/L Account"."No. 2" WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(true)) "G/L Account"."No. 2"
            ELSE
            IF (Type = CONST(Item)) Item."No. 2";
            Editable = false;
        }
        field(75010; "ENC User Defined Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'User Defined Price';
            Editable = false;
        }
        field(80000; "BA Stage"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Stage';
            Editable = false;
            OptionMembers = " ","Open","Closed/Lost","Closed/Other","Archive";
            OptionCaption = ' ,Open,Closed/Lost,Closed/Other,Archive';
        }
    }
}