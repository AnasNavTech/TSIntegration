pageextension 70117 "Sales Return Order Ext" extends "Sales Return Order"
{
    layout
    {
        addlast(General)
        {
            field(CalloffNumber; Rec."Call Off Number")
            {
                Caption = 'Call Off Number';
                ApplicationArea = All;
            }
            field(RigNumber; Rec."Rig Number")
            {
                Caption = 'Rig Number';
                ApplicationArea = All;
            }
            field(WellNumber; Rec."Well Number")
            {
                Caption = 'Well Number';
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