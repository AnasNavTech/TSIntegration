tableextension 70117 "Sales Inv Hdr Ext" extends "Sales Invoice Header"
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
        field(70120; "TS ID."; text[50])
        {
            Caption = 'TS ID.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70121; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70122; "Send to TS"; Boolean)
        {
            Caption = 'Send to TS';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}