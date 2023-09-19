page 50105 "Training Activity"
{
    ApplicationArea = All;
    Caption = 'Training Activity';
    PageType = CardPart;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                Caption = 'General';
                field("Sales Quotes - Open"; Rec."Sales Quotes - Open")
                {
                    ToolTip = 'Specifies the number of sales quotes that are not yet converted to invoices or orders.';
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders - Open"; Rec."Sales Orders - Open")
                {
                    ToolTip = 'Specifies the number of sales orders that are not fully posted.';
                    DrillDownPageId = "Sales Order List";
                }
                field("Sales Order - Release"; Rec."Sales Order - Release")
                {
                    DrillDownPageId = "Sales Order List";
                }
            }
        }
    }
}
