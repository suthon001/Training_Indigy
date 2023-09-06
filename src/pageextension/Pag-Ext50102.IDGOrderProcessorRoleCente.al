pageextension 50102 "IDG Order Processor Role Cente" extends "Order Processor Role Center"
{
    actions
    {
        addfirst(sections)
        {
            group(Traning)
            {
                Caption = 'Traning';
                action(Tranining)
                {
                    ApplicationArea = all;
                    Caption = 'Traning';
                    RunObject = page "IDG Traning Lists";
                }
            }
        }
    }
}
