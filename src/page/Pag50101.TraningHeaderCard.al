page 50101 "Traning Header Card"
{
    ApplicationArea = All;
    Caption = 'Traning Header Card';
    PageType = Card;
    SourceTable = "Traning Header";
    RefreshOnActivate = true;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
            }
            part(Lines; "Traning Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("Document No.");
            }
        }
    }
}
