page 75020 "BA Regions"
{
    Caption = 'Regions';
    SourceTable = "BA Region";
    ApplicationArea = all;
    UsageCategory = Administration;
    PageType = List;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Line)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
            }
        }
    }
}