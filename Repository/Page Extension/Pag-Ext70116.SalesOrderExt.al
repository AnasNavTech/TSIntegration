pageextension 70116 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(MRNo; Rec."MR No.")
            {
                Caption = 'MR No.';
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