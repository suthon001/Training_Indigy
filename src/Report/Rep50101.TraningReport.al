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
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);
                column(Number; Number) { }
                dataitem("IDG Traning Line"; "IDG Traning Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.");
                    DataItemLink = "Document No." = field("Document No.");
                    DataItemLinkReference = TraningHeader;
                    column(Item_No_; "Item No.") { }
                    column(Quantity; Quantity) { }
                    trigger OnAfterGetRecord()
                    begin

                    end;

                    trigger OnPreDataItem()
                    begin

                    end;

                    trigger OnPostDataItem()
                    begin

                    end;
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, NoofCopies);
                end;
            }
            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPreDataItem()
            begin

            end;

            trigger OnPostDataItem()
            begin

            end;
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
                    Caption = 'Options';
                    field(NoofCopies; NoofCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No of Copies.';
                        MinValue = 0;
                        MaxValue = 5;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            NoofCopies := 2;
        end;

    }
    var
        NoofCopies: Integer;
}
