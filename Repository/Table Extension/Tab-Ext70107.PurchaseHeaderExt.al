tableextension 70107 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(70100; "Send to TS"; Boolean)
        {
            Caption = 'Send to TS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70101; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70102; "Internal Request No."; Code[20])
        {
            Caption = 'Internal Request No.';
            DataClassification = CustomerContent;
        }
        field(70103; "Mill Code"; Code[15])
        {
            Caption = 'Mill Code';
            DataClassification = CustomerContent;
            TableRelation = "Mill Master".Code;

            trigger OnValidate()
            var
                MillMaster: Record "Mill Master";
            begin
                MillMaster.Get("Mill Code");
                Rec."Mill Name" := MillMaster.Description;
            end;
        }
        field(70104; "Mill Name"; Text[250])
        {
            Caption = 'Mill Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}