page 50104 "Training Role"
{
    ApplicationArea = All;
    Caption = 'Training Role';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Training; "Training Activity")
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
        area(Sections)
        {
            group(TrainingRole)
            {
                Caption = 'Training';
                action(TraningLists)
                {
                    Caption = 'Training Lists';
                    ApplicationArea = all;
                    RunObject = page "IDG Traning Lists";
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                action(SalesOrder)
                {
                    Caption = 'Sales Oreder';
                    ApplicationArea = all;
                    RunObject = page "Sales Order List";
                }
                action(CustomerLists)
                {
                    Caption = 'Customer Lists';
                    ApplicationArea = all;
                    RunObject = report "Customer - List";
                }
            }
        }
    }
}
profile TrainingRole
{
    Caption = 'Training';
    RoleCenter = "Training Role";

}
