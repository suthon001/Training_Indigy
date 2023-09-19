table 50100 "Traning Header"
{
    Caption = 'Traning Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';

        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; "Customer No."; code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'Customer No.';
            trigger OnValidate()
            var
                ltCustomer: Record Customer;
            begin
                // if ltCustomer.get("Customer No.") then
                //     "Customer Name" := ltCustomer.Name
                // else
                //     "Customer Name" := '';

                if not ltCustomer.get("Customer No.") then
                    ltCustomer.init();

                "Customer Name" := ltCustomer.Name;


                // ltCustomer.reset();
                // // ltCustomer.SetRange("No.", "Customer No.");
                // ltCustomer.SetFilter("No.", '%1..%2', '10000', '50000');
                // if ltCustomer.FindSet() then
                //     repeat
                //         "Customer Name" := ltCustomer.Name;
                //     until ltCustomer.Next() = 0;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Total Quantity';
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("IDG Traning Line".Quantity where("Document No." = field("Document No.")));
        }
        field(6; "Vendor No."; code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
            Editable = false;
            trigger OnLookup()
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
                    //  Message('Vendor No. %1', rec."Vendor No.");
                    OnAfterLookupVendorNo(VendorRec, rec);
                end else begin
                    Error('Please Select Vendor');
                end;

            end;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if rec."Vendor No." <> xRec."Vendor No." then begin


                    if not Vendor.GET("Vendor No.") then
                        Vendor.Init();

                    "Vendor No." := Vendor."No.";
                    "Vendor Name" := Vendor.Name;
                    "Last Date Modify" := Vendor."Last Date Modified";
                end;
            end;
        }
        field(7; "Vendor Name"; text[100])
        {
            Caption = 'Vendor Name';
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                TESTFunction(0, VendorRec, "Vendor Name");
            end;
        }
        field(8; "Last Date Modify"; Date)
        {
            Caption = 'Last Date Modify';
        }
        field(9; "Car"; Enum Car)
        {
            Caption = 'Car';
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(PK2; "Posting Date") { }

    }
    local procedure TESTFunction(pInter: Integer; pRec: Record Vendor; var pVendorName: Text[100])
    begin
        pVendorName := '111';
    end;

    procedure GlobalTESTFunction()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin
        Rec."Posting Date" := TODAY();
    end;

    trigger OnModify()
    begin

    end;

    trigger OnRename()
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupVendorNo(pVendor: Record Vendor; var TrainingHEader: Record "Traning Header")
    begin


    end;
}
