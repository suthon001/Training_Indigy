tableextension 50101 "IDG Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "Traning Dev"; Date)
        {
            Caption = 'Training Dev.';
            DataClassification = CustomerContent;
        }
        field(50101; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50102; "Business group Code"; Code[20])
        {
            Caption = 'Business group Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('BUSINESSGROUP'),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                CreateDimension();
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if rec."Posting Date" <> xRec."Posting Date" then begin
                    Message('%1 %2', xRec."Posting Date", rec."Posting Date");
                end;
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            begin
                if rec."Posting Date" <> xRec."Posting Date" then begin
                    Message('%1 %2', xRec."Posting Date", rec."Posting Date");
                end;
            end;
        }

    }


    procedure CreateDimension()
    var
        DimMgt: Codeunit DimensionManagement;
        DimensionSetEntryTemp: Record "Dimension Set Entry" temporary;
    begin
        DimMgt.GetDimensionSet(DimensionSetEntryTemp, rec."Dimension Set ID");

        DimensionSetEntryTemp.reset();
        DimensionSetEntryTemp.SetRange("Dimension Code", 'BUSINESSGROUP');
        if DimensionSetEntryTemp.FindFirst() then
            DimensionSetEntryTemp.Delete();

        if "Business group Code" <> '' then begin
            DimensionSetEntryTemp.Init();
            DimensionSetEntryTemp."Dimension Set ID" := rec."Dimension Set ID";
            DimensionSetEntryTemp."Dimension Code" := 'BUSINESSGROUP';
            DimensionSetEntryTemp.Insert();
            DimensionSetEntryTemp.Validate("Dimension Value Code", "Business group Code");
            DimensionSetEntryTemp.Modify();
        end;
        DimensionSetEntryTemp.reset();
        rec."Dimension Set ID" := DimMgt.GetDimensionSetID(DimensionSetEntryTemp);
    end;
}
