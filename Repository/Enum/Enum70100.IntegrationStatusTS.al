enum 70100 "Integration Status TS"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Pending") { Caption = 'Pending'; }
    value(1; "Processed") { Caption = 'Processed'; }
    value(2; "Error") { Caption = 'Error'; }
    value(3; "Wait for Reattempt") { Caption = 'Wait for Reattempt'; }
}