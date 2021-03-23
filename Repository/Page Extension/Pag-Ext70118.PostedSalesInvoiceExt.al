pageextension 70118 "Posted Sales Inv Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field(SendtoTS; Rec."Send to TS")
            {
                Caption = 'Send to TS';
                ApplicationArea = All;
            }
            field(TSID; Rec."TS ID.")
            {
                Caption = 'TS ID.';
                ApplicationArea = All;
            }
            field(TSErrorMessage; Rec."TS Error Message")
            {
                Caption = 'TS Error Message';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}