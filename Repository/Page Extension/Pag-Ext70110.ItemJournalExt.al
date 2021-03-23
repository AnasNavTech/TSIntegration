pageextension 70110 "Item Journal Ext" extends "Item Journal"
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