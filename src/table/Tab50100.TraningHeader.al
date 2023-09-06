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
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(PK2; "Posting Date") { }
    }
}
