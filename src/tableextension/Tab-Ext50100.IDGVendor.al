tableextension 50100 "IDG Vendor" extends Vendor
{
    fields
    {
        field(50100; "IDG Customer No."; code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(Blocked = filter(" "));
            trigger OnValidate()
            begin

            end;
        }
        field(50101; "Purchase Amount"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Purchase Amount';
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = const(Order)));
        }
        field(50102; "IDG Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("IDG Customer No.")));
        }
        field(50103; "Full Name"; text[200])
        {
            Caption = 'Full Name';
            trigger OnValidate()
            begin

            end;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                // rec."Full Name" := rec.Name + ' ' + rec."Name 2";
                //  rec.Validate("Full Name", rec.Name + ' ' + rec."Name 2");
                UpdateNameToFullName();
            end;
        }
        modify("Name 2")
        {
            trigger OnAfterValidate()

            begin
                // rec."Full Name" := rec.Name + ' ' + rec."Name 2";
                //  rec.Validate("Full Name", rec.Name + ' ' + rec."Name 2");
                //ltName := UpdateNameToFullName("Name", "Name 2");
                UpdateNameToFullName();
            end;
        }
    }
    // procedure UpdateNameToFullName(pName: Text[100]; pName2: text[50]): text
    // begin
    //     exit(pName);
    // end;

    procedure UpdateNameToFullName()
    begin
        rec."Full Name" := rec.Name + rec."Name 2";
        //xrec.
    end;

    var
        ltName: text[100];
        ltInteger: Integer;
}
