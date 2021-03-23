table 70109 "TS Setup"
{
    Caption = 'TS Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Purchase Order Token"; Blob)
        {
            Caption = 'Purchase Order Token';
            DataClassification = CustomerContent;
        }
        field(3; "Purchase Order URL"; Text[100])
        {
            Caption = 'Purchase Order URL';
            DataClassification = CustomerContent;
        }
        field(4; "Vendor Token"; Blob)
        {
            Caption = 'Vendor Token';
            DataClassification = CustomerContent;
        }
        field(5; "Vendor URL"; Text[100])
        {
            Caption = 'Vendor URL';
            DataClassification = CustomerContent;
        }
        field(6; "Get Access Token URL"; Blob)
        {
            Caption = 'Access Token';
            DataClassification = CustomerContent;
        }
        field(7; "Resource URL"; Text[100])
        {
            Caption = 'TubStream Resource URL';
            DataClassification = CustomerContent;
        }
        field(8; "Client ID"; Text[100])
        {
            Caption = 'Client ID';
            DataClassification = CustomerContent;
        }
        field(9; "Client Secret"; Text[100])
        {
            Caption = 'Client Secret';
            DataClassification = CustomerContent;
        }
        field(10; "Sales Invoice Token"; Blob)
        {
            Caption = 'Sales Invoice Token';
            DataClassification = CustomerContent;
        }
        field(11; "Sales Invoice URL"; Text[100])
        {
            Caption = 'Sales Invoice URL';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

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

    procedure SetAuthorizationTubeStreamToken(NewAuthorizationToken: Text);
    var
        OutStreamL: OutStream;
    begin
        Clear("Get Access Token URL");

        if NewAuthorizationToken = '' then
            exit;

        "Get Access Token URL".CreateOutStream(OutStreamL, TextEncoding::Windows);
        OutStreamL.WriteText(NewAuthorizationToken);
        Modify();
    end;

    procedure GetAuthorizationTubeStreamToken(): Text;
    var
        TypeHelper: Codeunit "Type Helper";
        CarriageReturn: Char;
        InStreamL: InStream;
    begin
        CalcFields("Get Access Token URL");
        if not "Get Access Token URL".HasValue() then
            exit('');

        CarriageReturn := 10;

        "Get Access Token URL".CreateInStream(InStreamL, TextEncoding::Windows);
        exit(TypeHelper.ReadAsTextWithSeparator(InStreamL, CarriageReturn));
    end;
}