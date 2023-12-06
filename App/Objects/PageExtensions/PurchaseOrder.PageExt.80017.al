pageextension 80017 "BA Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst("Buy-from")
        {
            field("BA Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst(Control95)
        {
            field("BA Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addbefore("Ship-to Name")
        {
            field("BA Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }





        modify("Pay-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Pay-to County")
        {
            field("BA Pay-to County"; PayToState)
            {
                ApplicationArea = all;
                Caption = 'Pay-to County';
                CaptionClass = '5,1,' + Rec."Pay-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Pay-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Pay-to County" := PayToState;
                    // Rec.CalcFields(ba );
                end;
            }
            field("BA Pay-to County Fullname"; Rec."BA Pay-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Ship-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Ship-to County")
        {
            field("BA Ship-to County"; ShipToState)
            {
                ApplicationArea = all;
                Caption = 'Ship-to County';
                CaptionClass = '5,1,' + Rec."Ship-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Ship-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Ship-to County" := ShipToState;
                    Rec.CalcFields("BA Ship-to County Fullname");
                end;
            }
            field("BA Ship-to County Fullname"; Rec."BA Ship-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Bill-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
            Caption = 'herp derp';
        }
        addafter("Bill-to County")
        {
            field("BA Bill-to County"; BillToState)
            {
                ApplicationArea = all;
                Caption = 'Bill-to County';
                CaptionClass = '5,1,' + Rec."Bill-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Bill-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Bill-to County" := BillToState;
                    Rec.CalcFields("BA Bill-to County Fullname");
                end;
            }
            field("BA Bill-to County Fullname"; Rec."BA Bill-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Bill-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Bill-to City")
        {
            field("BA Bill-to City"; BillToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Bill-to City" := BillToCity;
                end;
            }
        }
        modify("Ship-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Ship-to City")
        {
            field("BA Ship-to City"; ShipToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Ship-to City" := ShipToCity;
                end;
            }
        }
        modify("Pay-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Pay-to City")
        {
            field("BA Pay-to City"; SellToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Pay-to City" := SellToCity;
                end;
            }
        }
    }


    var
        BuyFromState: Code[30];
        ShipToState: Code[30];
        PayToState: Code[30];
        BuyFromCity: Text[30];
        ShipToCity: Text[30];
        PayToCity: Text[30];
        [InDataSet]
        IsEditable: boolean;

    trigger OnAfterGetCurrRecord()
    begin
        BuyFromCity := Rec."Buy-from City";
        PayToCity := Rec."Pay-to City";
        ShipToCity := Rec."Ship-to City";
        BuyFromState := Rec."Buy-from County";
        PayToState := Rec."Pay-to County";
        ShipToState := Rec."Ship-to County";
        IsEditable := CurrPage.Editable();
    end;
}