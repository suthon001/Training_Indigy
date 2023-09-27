page 50106 "API Sales Bankget Order"
{
    APIGroup = 'bc';
    APIPublisher = 'idg';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiSalesBankgetOrder';
    DelayedInsert = true;
    EntityName = 'salesbanketorder';
    EntitySetName = 'salesbanketorders';
    PageType = API;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = filter("Blanket Order"));
    layout
    {
        area(content)
        {
            group(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                field(department; Rec."Shortcut Dimension 1 Code") { Caption = 'DEPARTMENT Code'; }
                field(Customergroup; Rec."Shortcut Dimension 2 Code") { Caption = 'Customergroup Code'; }
                field(business; Rec."Business group Code") { Caption = 'business Code'; }
            }
            part(BlanketSalesOrderSubform; "Blanket Sales Order Subform")
            {
                EntityName = 'blanketline';
                EntitySetName = 'blanketlines';
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
            }

        }
    }

}
