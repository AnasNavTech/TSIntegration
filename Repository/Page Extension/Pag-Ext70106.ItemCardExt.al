pageextension 70106 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
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