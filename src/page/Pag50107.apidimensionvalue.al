page 50107 "api dimension value"
{
    APIGroup = 'bc';
    APIPublisher = 'idg';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiDimensionValue';
    DelayedInsert = true;
    EntityName = 'dimvalue';
    EntitySetName = 'dimvalues';
    PageType = API;
    SourceTable = "Dimension Value";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
            }
        }
    }
}
