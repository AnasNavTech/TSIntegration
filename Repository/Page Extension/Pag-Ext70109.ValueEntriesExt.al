pageextension 70109 "Value Entries Ext" extends "Value Entries"
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