pageextension 50106 "IDG Blanket Sales Order" extends "Blanket Sales Order"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Business group Code"; Rec."Business group Code")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action(GetToken)
            {
                Caption = 'Get Token';
                Image = GetEntries;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    idgFunc: Codeunit "IDG Func";
                begin
                    idgFunc.GetToken();
                end;
            }
        }
    }
}
