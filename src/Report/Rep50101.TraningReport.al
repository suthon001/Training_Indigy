report 50101 "Traning Report"
{
    Caption = 'Traning Report';
    RDLCLayout = './LayoutReport/TraningReport.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(TraningHeader; "Traning Header")
        {
            RequestFilterFields = "Document No.", "Posting Date";
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(TotalQuantity; "Total Quantity")
            {
            }
            dataitem("IDG Traning Line"; "IDG Traning Line")
            {
                DataItemLink = "Document No." = field("Document No.");
                column(Item_No_; "Item No.") { }
                column(Quantity; Quantity) { }
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

    }
}
