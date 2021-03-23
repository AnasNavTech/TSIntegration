enum 70106 "TS Sync Status TS"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ") { Caption = ' '; }
    value(1; "Waiting for Sync") { Caption = 'Waiting for Sync'; }
    value(2; "Sync Complete") { Caption = 'Sync Complete'; }
    value(3; "Error") { Caption = 'Error'; }
}