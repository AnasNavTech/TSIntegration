pageextension 70108 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field(TSItemNo; Rec."TS Item No.")
            {
                Caption = 'TS Item No.';
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