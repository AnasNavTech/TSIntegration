table 70114 "Mill Master"
{
    Caption = 'Mill Master';
    DataClassification = CustomerContent;
    LookupPageId = "Mill Master List";
    DrillDownPageId = "Mill Master List";

    fields
    {
        field(1; Code; Code[15])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Address; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; City; Text[50])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(5; State; Text[50])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(6; Country; Text[50])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}