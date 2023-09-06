page 50103 apitraning
{
    APIGroup = 'bc';
    APIPublisher = 'idg';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apitraning';
    DelayedInsert = true;
    EntityName = 'traningHeader';
    EntitySetName = 'traningHeaders';
    PageType = API;
    SourceTable = "Traning Header";
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(totalQuantity; Rec."Total Quantity")
                {
                    Caption = 'Total Quantity';
                }
                part(traningline; "Traning Subform")
                {
                    EntityName = 'traningline';
                    EntitySetName = 'traninglines';
                    SubPageLink = "Document No." = field("Document No.");
                }
            }
        }
    }
}
