pageextension 70102 "Vendor Ext" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field(Type; Rec.Type)
            {
                Caption = 'Type';
                ApplicationArea = All;
            }
            field(TSID; Rec."TS ID.")
            {
                Caption = 'Last Synced TS ID';
                ApplicationArea = All;
            }
            field(SendtoTS; Rec."Send to TS")
            {
                Caption = 'Send to TS';
                ApplicationArea = All;
            }
            field(TSErrorMessage; Rec."TS Error Message")
            {
                Caption = 'TS Error Message';
                ApplicationArea = All;
            }
            field(TSSyncStatus; Rec."TS Sync Status")
            {
                Caption = 'TS Sync Status';
                ApplicationArea = All;
            }
        }
    }


    var
        myInt: Integer;
}