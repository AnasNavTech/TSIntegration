enum 70105 "Push Data Sync Status TS"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "InComplete Data") { Caption = 'InComplete Data'; }
    value(1; "Waiting for Sync") { Caption = 'Waiting for Sync'; }
    value(2; "Sync Complete") { Caption = 'Sync Complete'; }
    value(3; "Error") { Caption = 'Error'; }
}