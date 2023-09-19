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
                field("Vendor No."; Rec."Vendor No.")
                {
                    trigger OnAssistEdit()
                    var
                        VendorRec: Record Vendor;
                        VendorPage: Page "Vendor List";
                    begin
                        VendorRec.reset();
                        VendorRec.FilterGroup(-1);

                        VendorRec.SetFilter("No.", '%1..%2', '10000', '30000');

                        VendorRec.SetFilter("Payment Terms Code", 'CM');

                        VendorRec.LoadFields("No.");

                        VendorPage.SetTableView(VendorRec);
                        VendorPage.Editable := false;
                        VendorPage.LookupMode := true;
                        //VendorPage.Run();
                        if VendorPage.RunModal() = Action::LookupOK then begin
                            VendorPage.GetRecord(VendorRec);
                            rec."Vendor No." := VendorRec."No.";
                            rec."Vendor Name" := VendorRec.Name;
                            rec."Last Date Modify" := VendorRec."Last Date Modified";
                            Message('Vendor No. %1', rec."Vendor No.");
                        end else begin
                            Error('Please Select Vendor');
                        end;
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name") { }
                field("Last Date Modify"; Rec."Last Date Modify") { }
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
