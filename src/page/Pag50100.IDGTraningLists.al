page 50100 "IDG Traning Lists"
{
    ApplicationArea = all;
    Caption = 'IDG Traning Lists';
    PageType = List;
    SourceTable = "Traning Header";
    UsageCategory = Lists;
    CardPageId = "Traning Header Card";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(Report)
            {
                Caption = 'Report';
                Image = Report;
                ApplicationArea = all;
                PromotedCategory = Report;
                Promoted = true;
                //  RunObject = REPORT "Traning Report";
                trigger OnAction()
                var
                    TrainingHeader: Record "Traning Header";
                begin
                    TrainingHeader.reset();
                    TrainingHeader.SetRange("Document No.", rec."Document No.");
                    REPORT.Run(REPORT::"Traning Report", true, true, TrainingHeader);
                end;
            }
            action(XML)
            {
                Caption = 'XML';
                Image = XMLFile;
                ApplicationArea = all;
                PromotedCategory = Report;
                Promoted = true;
                RunObject = xmlport "Export Customer";

            }
        }
    }

}
