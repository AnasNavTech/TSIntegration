page 70118 "TS Setup"
{
    Caption = 'TS Setup';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TS Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(AuthorizationVendor; APIAuthorizationVendorToken)
                {
                    Caption = 'TubeStream Token';
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = AuthTokenEditable;
                    trigger OnValidate()
                    begin
                        Rec.SetAuthorizationTubeStreamToken(APIAuthorizationVendorToken);
                    end;
                }
                field(ClientID; Rec."Client ID")
                {
                    Caption = 'Client ID';
                    ApplicationArea = All;
                }
                field(ClientSecret; Rec."Client Secret")
                {
                    Caption = 'Client Secret';
                    ApplicationArea = All;
                }
                field(ResourceURL; Rec."Resource URL")
                {
                    Caption = 'Resurce URL';
                    ApplicationArea = All;
                }
                field(VendorURL; Rec."Vendor URL")
                {
                    Caption = 'Vendor URL';
                    ApplicationArea = All;
                }
                field(PurchaseOrderURL; Rec."Purchase Order URL")
                {
                    Caption = 'Purchase Order URL';
                    ApplicationArea = All;
                }
                field(SalesInvoiceURL; Rec."Sales Invoice URL")
                {
                    Caption = 'SalesInvoice URL';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        APIAuthorizationVendorToken := Rec.GetAuthorizationTubeStreamToken();
        AuthTokenEditable := CurrPage.Editable();
    end;

    var
        APIAuthorizationPOToken: Text;
        APIAuthorizationVendorToken: Text;
        [InDataSet]
        AuthTokenEditable: Boolean;
}