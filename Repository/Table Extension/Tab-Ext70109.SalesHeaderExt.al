tableextension 70109 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(70100; "MR No."; Code[20])
        {
            Caption = 'MR No.';
            DataClassification = CustomerContent;
        }
        field(70101; "Rig Number"; Text[10])
        {
            Caption = 'Rig Number';
            DataClassification = CustomerContent;
        }
        field(70102; "Well Number"; Text[10])
        {
            Caption = 'Well Number';
            DataClassification = CustomerContent;
        }
        field(70103; "Call Off Number"; Text[20])
        {
            Caption = 'Call Off Number';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}