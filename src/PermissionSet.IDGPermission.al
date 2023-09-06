permissionset 50100 "IDG Permission"
{
    Assignable = true;
    Caption = 'IDG Permission', MaxLength = 30;
    Permissions =
        table "IDG Traning Line" = X,
        tabledata "IDG Traning Line" = RMID,
        table "Traning Header" = X,
        tabledata "Traning Header" = RMID,
        codeunit "IDG Func" = X,
        page apitraning = X,
        page "Traning Subform" = X,
        page "Traning Header Card" = X,
        page "IDG Traning Lists" = X,
        report "IDG Customer Lists" = X,
        report "Traning Report" = X;
}
