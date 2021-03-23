page 70119 "Test API Staging TS"
{
    Permissions = tabledata "Sales Invoice Header" = rimd;
    Caption = 'Test API Staging - TS';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action("Insert Data to Staging")
            {
                Caption = 'Insert Data to Staging';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertDatatoStaging();
                end;
            }

            action("Generate Refresh Token")
            {
                Caption = 'Generate Refersh Token';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GenerateRefreshToken();
                end;
            }
            action("Push PO")
            {
                Caption = 'POST PO to TS';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PushPurchaseOrdertoTS();
                end;
            }
            action("GET PO")
            {
                Caption = 'GET PO FROM TS';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin
                    GetPurchaseOrderFromTS();
                end;
            }
            action("Push Vendor")
            {
                Caption = 'POST Vendor to TS';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PushVendortoTS();
                end;
            }
            action("GET Vendor")
            {
                Caption = 'GET Vendor FROM TS';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin
                    GetVendorFromTS();
                end;
            }
            action("Insert Customer From TS")
            {
                Caption = 'Insert Customer From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertCustomerStaging();
                end;
            }
            action("Insert Item From TS")
            {
                Caption = 'Insert Item From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertItemStaging();
                end;
            }
            action("Insert Location From TS")
            {
                Caption = 'Insert Location From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertLocationStaging();
                end;
            }
            action("Update Purchase From TS")
            {
                Caption = 'Update Purchase Order From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.UpdatePurchaseReceiptsStaging();
                end;
            }
            action("Insert Transfer Order From TS")
            {
                Caption = 'Insert Transfer Order From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.CreateTransferOrders();
                end;
            }
            action("Inventory Adjustments From TS")
            {
                Caption = 'Inventory Adjustments From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.AdjustInventory();
                end;
            }
            action("Production Issue&Receipts From TS")
            {
                Caption = 'Prod. Issue&Receipts From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertProductionIssueandReceipt();
                end;
            }
            action("Create Sales Order From TS")
            {
                Caption = 'Sales Order From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertSalesOrder();
                end;
            }
            action("Update Shipments From TS")
            {
                Caption = 'Update Shipments From TS';
                ApplicationArea = All;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.UpdateSalesShipment();
                end;
            }
        }
    }

    local procedure GetPurchaseOrderFromTS()
    var
        TSSetup: Record "TS Setup";
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseText: Text;
        ServiceURL: Text;
        TokenErr: Label 'Purchase Order Token Should not be Blank in TS Setup.';
    begin
        TSSetup.Get();
        TSSetup.TestField("Purchase Order URL");
        ServiceURL := TSSetup."Purchase Order URL";
        Authorization := TSSetup.GetAuthorizationTubeStreamToken();
        if Authorization = '' then
            Error(TokenErr);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        Request.GetHeaders(ContentHeaders);
        ContentHeaders.Add('Authorization', StrSubstNo('Bearer %1', Authorization));
        ContentHeaders.Add('Accept', 'application/json');
        ServiceURL += '/' + POResponseID;

        Request.SetRequestUri(ServiceURL);
        Request.Method := 'GET';

        Client.Send(Request, Response);
        Response.Content().ReadAs(ResponseText);
        Message(ResponseText);
    end;

    local procedure PushPurchaseOrdertoTS2()
    var
        TSSetup: Record "TS Setup";
        PurchaseOrderStaging: Record "Purchase Order TS";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchHdr: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        ServiceURL: Text;
        StringPos: Integer;
        StringLength: Integer;
        IDValue: Text;
        FailureFlag: Boolean;
        IsError: Boolean;
        ResponseErr: Text;
        PurchaseTokenErr: Label 'Purchase Token Should not be Blank in TS Setup.';
        TokenErr: Label 'Token Should not be Blank';
        WebServiceErr: Label 'Failed to Sent.';
    begin
        PurchaseOrderStaging.Reset();
        PurchaseOrderStaging.SetRange("TS Sync Status", PurchaseOrderStaging."TS Sync Status"::"Waiting for Sync");
        //VendorContractor.SetFilter("TS Error Message", '%1', '');
        if PurchaseOrderStaging.FindSet() then begin
            repeat
                Data := '';
                StringPos := 0;
                StringLength := 0;
                TSSetup.Get();
                ServiceURL := TSSetup."Purchase Order URL";
                Authorization := TSSetup.GetAuthorizationTubeStreamToken();
                PurchaseLine.Get(PurchaseLine."Document Type"::Order, PurchaseOrderStaging."Purchase Order No.", PurchaseOrderStaging."Purchase Line No.");
                PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderStaging."Purchase Order No.");
                IsError := false;
                // if AccessTokenErr <> '' then begin
                //     IsError := true;
                //     VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                //     VendorContractor."TS Error Message" := AccessTokenErr;
                //     VendorContractor.Modify();
                //     Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                //     Vendor."TS Error Message" := AccessTokenErr;
                //     Vendor.Modify();
                // end;
                if TSSetup."Vendor URL" = '' then begin
                    IsError := true;
                    PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                    PurchaseOrderStaging."TS Error Message" := PurchaseTokenErr;
                    PurchaseOrderStaging.Modify();
                end;
                if Authorization = '' then begin
                    IsError := true;
                    PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                    PurchaseOrderStaging."TS Error Message" := TokenErr;
                    PurchaseOrderStaging.Modify();
                end;
                if not IsError then begin
                    Clear(RequestHeaders);
                    Clear(RequestContent);
                    clear(ResponseMessage);
                    clear(ResponseText);
                    Clear(ContentHeaders);
                    GetPOData(PurchaseLine);//Fetching Purchase Data
                    RequestHeaders := Client.DefaultRequestHeaders();
                    RequestHeaders.add('Authorization', StrSubstNo('Bearer %1', Authorization));
                    RequestContent.WriteFrom(Data);
                    RequestContent.GetHeaders(ContentHeaders);
                    ContentHeaders.Clear();
                    //ContentHeaders.Add('Accept', 'application/json');
                    ContentHeaders.Add('Content-Type', 'application/json');
                    Client.Post(ServiceURL, RequestContent, ResponseMessage);
                    ResponseMessage.Content().ReadAs(ResponseText);
                    if StrPos(ResponseText, 'success') <> 0 then begin
                        if StrPos(ResponseText, '"_id":"') <> 0 then begin
                            StringPos := StrPos(ResponseText, '"_id":"');
                            StringLength := StrLen(ResponseText);
                            IDValue := CopyStr(ResponseText, (StringPos + 7), ((StringLength - 3) - (StringPos + 7)));
                            if IDValue <> '' then begin
                                VendorResponseID := IDValue;
                                PurchaseOrderStaging.ID := IDValue;
                                PurchaseOrderStaging."TS Synced By" := UserId();
                                PurchaseOrderStaging."TS Synced On" := CurrentDateTime;
                                PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::"Sync Complete";
                                PurchaseOrderStaging."TS Error Message" := '';
                                PurchaseLine."TS ID." := IDValue;
                                PurchaseLine."TS Error Message" := '';
                                PurchaseHeader."TS Error Message" := '';
                                PurchaseHeader.Modify(false);
                                PurchaseLine.Modify(false);
                                PurchaseOrderStaging.Modify(false);
                            end else begin
                                PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                                PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseHeader.Modify(false);
                                PurchaseLine.Modify(false);
                                PurchaseOrderStaging.Modify(false);
                            end;
                        end else begin
                            PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                            PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseHeader.Modify(false);
                            PurchaseLine.Modify(false);
                            PurchaseOrderStaging.Modify(false);
                        end;
                    end else begin
                        PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                        PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseHeader.Modify(false);
                        PurchaseLine.Modify(false);
                        PurchaseOrderStaging.Modify(false);
                    end;
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
                    PurchLine.SetRange("Document No.", PurchaseHeader."No.");
                    PurchLine.SetFilter("TS ID.", '%1', '');
                    if not PurchLine.FindFirst() then begin
                        PurchaseHeader."Send to TS" := true;
                        PurchaseHeader.Modify();
                    end;
                end;
            Until PurchaseOrderStaging.Next() = 0;
            CurrPage.Update();
        end;
    end;

    procedure PushPurchaseOrdertoTS()
    var
        TSSetup: Record "TS Setup";
        PurchaseOrderStaging: Record "Purchase Order TS";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchHdr: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Client: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        Content: HttpContent;
        ResponseText: Text;
        ResponseJsonObject: JsonObject;
        ParentJsonObject: JsonObject;
        SimpleText: Text;
        RequestHeader: HttpHeaders;
        RequestText: Text;
        ServiceURL: Text;
        StringPos: Integer;
        StringLength: Integer;
        IDValue: Text;
        FailureFlag: Boolean;
        IsError: Boolean;
        ResponseErr: Text;
        PurchaseTokenErr: Label 'Purchase Token Should not be Blank in TS Setup.';
        TokenErr: Label 'Token Should not be Blank';
        WebServiceErr: Label 'Failed to Sent.';
    begin
        PurchaseOrderStaging.Reset();
        PurchaseOrderStaging.SetRange("TS Sync Status", PurchaseOrderStaging."TS Sync Status"::"Waiting for Sync");
        //VendorContractor.SetFilter("TS Error Message", '%1', '');
        if PurchaseOrderStaging.FindSet() then begin
            repeat
                Data := '';
                StringPos := 0;
                StringLength := 0;
                TSSetup.Get();
                ServiceURL := TSSetup."Purchase Order URL";
                Authorization := TSSetup.GetAuthorizationTubeStreamToken();
                PurchaseLine.Get(PurchaseLine."Document Type"::Order, PurchaseOrderStaging."Purchase Order No.", PurchaseOrderStaging."Purchase Line No.");
                PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderStaging."Purchase Order No.");
                IsError := false;
                // if AccessTokenErr <> '' then begin
                //     IsError := true;
                //     VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                //     VendorContractor."TS Error Message" := AccessTokenErr;
                //     VendorContractor.Modify();
                //     Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                //     Vendor."TS Error Message" := AccessTokenErr;
                //     Vendor.Modify();
                // end;
                if TSSetup."Vendor URL" = '' then begin
                    IsError := true;
                    PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                    PurchaseOrderStaging."TS Error Message" := PurchaseTokenErr;
                    PurchaseOrderStaging.Modify();
                end;
                if Authorization = '' then begin
                    IsError := true;
                    PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                    PurchaseOrderStaging."TS Error Message" := TokenErr;
                    PurchaseOrderStaging.Modify();
                end;
                if not IsError then begin
                    GetPOData(PurchaseLine);
                    //Message(Data); //Remove
                    CLEAR(Content);
                    CLEAR(HttpRequest);
                    Clear(HttpResponse);
                    Clear(Client);
                    Client.SetBaseAddress(ServiceURL);
                    Content.WriteFrom(Data);
                    Content.GetHeaders(HttpHeadrs);
                    HttpHeadrs.Remove('Content-Type');
                    HttpHeadrs.Add('Content-Type', 'application/json;odata=verbose');
                    client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'text/json');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Authorization', 'Bearer ' + Authorization);
                    client.Post(ServiceURL, content, HttpResponse);
                    HttpResponse.Content().ReadAs(ResponseText);
                    if StrPos(ResponseText, 'success') <> 0 then begin
                        if StrPos(ResponseText, '"_id":"') <> 0 then begin
                            StringPos := StrPos(ResponseText, '"_id":"');
                            StringLength := StrLen(ResponseText);
                            IDValue := CopyStr(ResponseText, (StringPos + 7), ((StringLength - 3) - (StringPos + 7)));
                            if (IDValue <> '') and (StrLen(IDValue) <= 50) then begin
                                VendorResponseID := IDValue;
                                PurchaseOrderStaging.ID := IDValue;
                                PurchaseOrderStaging."TS Synced By" := UserId();
                                PurchaseOrderStaging."TS Synced On" := CurrentDateTime;
                                PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::"Sync Complete";
                                PurchaseOrderStaging."TS Error Message" := '';
                                PurchaseLine."TS ID." := IDValue;
                                PurchaseLine."TS Error Message" := '';
                                PurchaseHeader."TS Error Message" := '';
                                PurchaseHeader.Modify(false);
                                PurchaseLine.Modify(false);
                                PurchaseOrderStaging.Modify(false);
                            end else begin
                                PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                                PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                PurchaseHeader.Modify(false);
                                PurchaseLine.Modify(false);
                                PurchaseOrderStaging.Modify(false);
                            end;
                        end else begin
                            PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                            PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            PurchaseHeader.Modify(false);
                            PurchaseLine.Modify(false);
                            PurchaseOrderStaging.Modify(false);
                        end;
                    end else begin
                        PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::Error;
                        PurchaseOrderStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseLine."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        PurchaseHeader.Modify(false);
                        PurchaseLine.Modify(false);
                        PurchaseOrderStaging.Modify(false);
                    end;
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
                    PurchLine.SetRange("Document No.", PurchaseHeader."No.");
                    PurchLine.SetFilter("TS ID.", '%1', '');
                    if not PurchLine.FindFirst() then begin
                        PurchaseHeader."Send to TS" := true;
                        PurchaseHeader.Modify();
                    end;
                end;
            Until PurchaseOrderStaging.Next() = 0;
            CurrPage.Update();
        end;
    end;

    procedure UpdateSalesInvoicetoTS()
    var
        TSSetup: Record "TS Setup";
        SalesInvoiceStaging: Record "Sales Invoice TS";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Client: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        Content: HttpContent;
        ResponseText: Text;
        ResponseJsonObject: JsonObject;
        ParentJsonObject: JsonObject;
        SimpleText: Text;
        RequestHeader: HttpHeaders;
        RequestText: Text;
        ServiceURL: Text;
        StringPos: Integer;
        StringLength: Integer;
        IDValue: Text;
        FailureFlag: Boolean;
        IsError: Boolean;
        ResponseErr: Text;
        SalesInvoiceTokenErr: Label 'Sales Invoice Token Should not be Blank in TS Setup.';
        TokenErr: Label 'Token Should not be Blank';
        WebServiceErr: Label 'Failed to Sent.';
    begin
        SalesInvoiceStaging.Reset();
        SalesInvoiceStaging.SetRange("TS Sync Status", SalesInvoiceStaging."TS Sync Status"::"Waiting for Sync");
        if SalesInvoiceStaging.FindSet() then begin
            repeat
                SalesInvoiceHeader.Get(SalesInvoiceStaging."Sales Invoice No.");
                Data := '';
                StringPos := 0;
                StringLength := 0;
                TSSetup.Get();
                ServiceURL := TSSetup."Sales Invoice URL";
                Authorization := TSSetup.GetAuthorizationTubeStreamToken();
                IsError := false;
                if TSSetup."Vendor URL" = '' then begin
                    IsError := true;
                    SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::Error;
                    SalesInvoiceStaging."TS Error Message" := SalesInvoiceTokenErr;
                    SalesInvoiceStaging.Modify();
                end;
                if Authorization = '' then begin
                    IsError := true;
                    SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::Error;
                    SalesInvoiceStaging."TS Error Message" := TokenErr;
                    SalesInvoiceStaging.Modify();
                end;
                if not IsError then begin
                    GetSIData(SalesInvoiceStaging);
                    //Message(Data); //Remove
                    CLEAR(Content);
                    CLEAR(HttpRequest);
                    Clear(HttpResponse);
                    Clear(Client);
                    Client.SetBaseAddress(ServiceURL);
                    Content.WriteFrom(Data);
                    Content.GetHeaders(HttpHeadrs);
                    HttpHeadrs.Remove('Content-Type');
                    HttpHeadrs.Add('Content-Type', 'application/json;odata=verbose');
                    client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'text/json');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Authorization', 'Bearer ' + Authorization);
                    client.Post(ServiceURL, content, HttpResponse);
                    HttpResponse.Content().ReadAs(ResponseText);
                    if StrPos(ResponseText, 'success') <> 0 then begin
                        if StrPos(ResponseText, '"_id":"') <> 0 then begin
                            StringPos := StrPos(ResponseText, '"_id":"');
                            StringLength := StrLen(ResponseText);
                            IDValue := CopyStr(ResponseText, (StringPos + 7), ((StringLength - 3) - (StringPos + 7)));
                            if (IDValue <> '') and (StrLen(IDValue) <= 50) then begin
                                VendorResponseID := IDValue;
                                SalesInvoiceStaging.ID := IDValue;
                                SalesInvoiceStaging."TS Synced By" := UserId();
                                SalesInvoiceStaging."TS Synced On" := CurrentDateTime;
                                SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::"Sync Complete";
                                SalesInvoiceStaging."TS Error Message" := '';
                                SalesInvoiceHeader."TS ID." := IDValue;
                                SalesInvoiceHeader."Send to TS" := true;
                                SalesInvoiceHeader."TS Error Message" := '';
                                SalesInvoiceHeader.Modify(true);
                                SalesInvoiceStaging.Modify(false);
                            end else begin
                                SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::Error;
                                SalesInvoiceStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                SalesInvoiceHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                SalesInvoiceHeader.Modify(true);
                                SalesInvoiceStaging.Modify(false);
                            end;
                        end else begin
                            SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::Error;
                            SalesInvoiceStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            SalesInvoiceHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            SalesInvoiceHeader.Modify(true);
                            SalesInvoiceStaging.Modify(false);
                        end;
                    end else begin
                        SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::Error;
                        SalesInvoiceStaging."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        SalesInvoiceHeader."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        SalesInvoiceHeader.Modify(true);
                        SalesInvoiceStaging.Modify(false);
                    end;
                end;
            Until SalesInvoiceStaging.Next() = 0;
            CurrPage.Update();
        end;
    end;

    procedure GetPOData(var PurchaseLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseLine."Document No.");
        Data := '{';
        Data += '"eta":' + '"' + FORMAT(PurchaseLine."Expected Receipt Date", 0, 9) + '",';
        Data += '"ami_code":' + '"' + Format(PurchaseHeader."Buy-from Vendor No.") + '",';
        Data += '"custpo":' + '"' + Format(PurchaseHeader."Vendor Invoice No.") + '",';
        Data += '"mill":' + '"' + PurchaseHeader."Mill Name" + '",';
        Data += '"book_value":' + '"' + delchr(Format(PurchaseLine.Quantity), '=', ',') + '",';
        Data += '"book_value_mt":' + '"' + delchr(Format(PurchaseLine.Amount), '=', ',') + '",';
        Data += '"cust_acc":' + '"' + Format(PurchaseHeader."Sell-to Customer No.") + '",';
        Data += '"destination":' + '"' + Format(PurchaseLine."Location Code") + '",';
        Data += '"id_item":' + '"' + Format(PurchaseLine."TS Item No.") + '",';
        Data += '"no":' + '"' + Format((PurchaseLine."Document No.")) + '",';
        Data += '"price":' + '"' + Format((PurchaseLine."Unit Price (LCY)")) + '",';
        Data += '"total_ft":' + '"' + delchr(Format(PurchaseLine.Quantity), '=', ',') + '",';
        Data += '"total_joint":' + '"' + delchr(Format(PurchaseLine."Unit Price (LCY)"), '=', ',') + '",';
        Data += '"total_mt":' + '"' + delchr(Format(PurchaseLine.Amount), '=', ',') + '",';
        Data += '"unit":' + '"' + Format(PurchaseLine."Unit of Measure Code") + '",';
        Data += '"vessel_name":' + '"' + Format(PurchaseLine."Vessel Name") + '"';
        Data += '}';
    end;

    procedure GetSIData(var SalesInvoiceStaging: Record "Sales Invoice TS")
    begin
        Data := '{';
        Data += '"cust_acc":' + '"' + Format(SalesInvoiceStaging."Customer No.") + '",';
        Data += '"inv_amount":' + '"' + delchr(Format(SalesInvoiceStaging."Amount Including VAT"), '=', ',') + '",';
        Data += '"custpo":' + '"' + Format(SalesInvoiceStaging."Customer PO No.") + '",';
        Data += '"inv_curr":' + '"' + Format(SalesInvoiceStaging."Currency Code") + '",';
        Data += '"inv_date":' + '"' + FORMAT(SalesInvoiceStaging."Invoice Date", 0, 9) + '",';
        Data += '"inv_close":' + '"' + FORMAT(SalesInvoiceStaging."Invoice Closure Date", 0, 9) + '",';
        Data += '"inv_due":' + '"' + FORMAT(SalesInvoiceStaging."Due Date", 0, 9) + '",';
        Data += '"sales_order":' + '"' + Format(SalesInvoiceStaging."Sales Order No.") + '",';
        Data += '"inv_no":' + '"' + Format(SalesInvoiceStaging."Sales Invoice No.") + '",';
        Data += '"calloff_no":' + '"' + Format(SalesInvoiceStaging."MR No.") + '"';
        Data += '}';
    end;

    local procedure GetVendorFromTS()
    var
        TSSetup: Record "TS Setup";
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseText: Text;
        ServiceURL: Text;
        TokenErr: Label 'Vendor Token Should not be Blank in TS Setup.';
    begin
        TSSetup.Get();
        TSSetup.TestField("Vendor URL");
        ServiceURL := TSSetup."Vendor URL";
        Authorization := TSSetup.GetAuthorizationTubeStreamToken();
        if Authorization = '' then
            Error(TokenErr);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        Request.GetHeaders(ContentHeaders);
        ContentHeaders.Add('Authorization', StrSubstNo('Bearer %1', Authorization));
        ContentHeaders.Add('Accept', 'application/json');
        ServiceURL += '/' + VendorResponseID;

        Request.SetRequestUri(ServiceURL);
        Request.Method := 'GET';

        Client.Send(Request, Response);
        Response.Content().ReadAs(ResponseText);
        Message(ResponseText);
    end;

    procedure PushVendortoTS()
    var
        TSSetup: Record "TS Setup";
        VendorContractor: Record "Vendor Contractor TS";
        Vendor: Record Vendor;
        Client: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        Content: HttpContent;
        ResponseText: Text;
        ResponseJsonObject: JsonObject;
        ParentJsonObject: JsonObject;
        SimpleText: Text;
        RequestHeader: HttpHeaders;
        RequestText: Text;
        ServiceURL: Text;
        StringPos: Integer;
        StringLength: Integer;
        IDValue: Text;
        FailureFlag: Boolean;
        IsError: Boolean;
        ResponseErr: Text;
        VendorTokenErr: Label 'Vendor Token Should not be Blank in TS Setup.';
        TokenErr: Label 'Token Should not be Blank';
        WebServiceErr: Label 'Failed to Sent.';
    begin
        TSSetup.Get();
        ServiceURL := TSSetup."Vendor URL";
        Authorization := TSSetup.GetAuthorizationTubeStreamToken();

        VendorContractor.Reset();
        VendorContractor.SetRange("TS Sync Status", VendorContractor."TS Sync Status"::"Waiting for Sync");
        //VendorContractor.SetFilter("TS Error Message", '%1', '');
        if VendorContractor.FindSet() then begin
            repeat
                Vendor.Get(VendorContractor.Code);
                IsError := false;
                // if AccessTokenErr <> '' then begin
                //     IsError := true;
                //     VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                //     VendorContractor."TS Error Message" := AccessTokenErr;
                //     VendorContractor.Modify();
                //     Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                //     Vendor."TS Error Message" := AccessTokenErr;
                //     Vendor.Modify();
                // end;
                if TSSetup."Vendor URL" = '' then begin
                    IsError := true;
                    VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                    VendorContractor."TS Error Message" := VendorTokenErr;
                    VendorContractor.Modify();
                    Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                    Vendor."TS Error Message" := VendorTokenErr;
                    Vendor.Modify();
                end;
                if Authorization = '' then begin
                    IsError := true;
                    VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                    VendorContractor."TS Error Message" := TokenErr;
                    VendorContractor.Modify();
                    Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                    Vendor."TS Error Message" := TokenErr;
                    Vendor.Modify();
                end;
                if not IsError then begin
                    Data := '';
                    StringPos := 0;
                    StringLength := 0;
                    GetVendorData(Vendor); //Fetching Vendor Data
                    CLEAR(Content);
                    CLEAR(HttpRequest);
                    Clear(HttpResponse);
                    Clear(Client);
                    Client.SetBaseAddress(ServiceURL);
                    Content.WriteFrom(Data);
                    Content.GetHeaders(HttpHeadrs);
                    HttpHeadrs.Remove('Content-Type');
                    HttpHeadrs.Add('Content-Type', 'application/json;odata=verbose');
                    client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'text/json');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Authorization', 'Bearer ' + Authorization);
                    client.Post(ServiceURL, content, HttpResponse);
                    HttpResponse.Content().ReadAs(ResponseText);
                    if StrPos(ResponseText, 'success') <> 0 then begin
                        if StrPos(ResponseText, '"_id":"') <> 0 then begin
                            StringPos := StrPos(ResponseText, '"_id":"');
                            StringLength := StrLen(ResponseText);
                            IDValue := CopyStr(ResponseText, (StringPos + 7), ((StringLength - 3) - (StringPos + 7)));
                            if IDValue <> '' then begin
                                VendorResponseID := IDValue;
                                VendorContractor.ID := IDValue;
                                VendorContractor."TS Synced By" := UserId();
                                VendorContractor."TS Synced On" := CurrentDateTime;
                                VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::"Sync Complete";
                                VendorContractor."TS Error Message" := '';
                                Vendor."TS Sync Status" := Vendor."TS Sync Status"::"Sync Complete";
                                Vendor."TS Error Message" := '';
                                Vendor."TS ID." := IDValue;
                                Vendor."Send to TS" := true;
                                Vendor.Modify(false);
                                VendorContractor.Modify(false);
                            end else begin
                                Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                                Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                Vendor.Modify(false);
                                VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                                VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                VendorContractor.Modify(false);
                            end;
                        end else begin
                            Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                            Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            Vendor.Modify(false);
                            VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                            VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            VendorContractor.Modify(false);
                        end;
                    end else begin
                        Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                        Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        Vendor.Modify(false);
                        VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                        VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        VendorContractor.Modify(false);
                    end;
                end;
            Until VendorContractor.Next() = 0;
            CurrPage.Update();
        end;
    end;

    local procedure PushVendortoTS2()
    var
        TSSetup: Record "TS Setup";
        VendorContractor: Record "Vendor Contractor TS";
        Vendor: Record Vendor;
        Client: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        Content: HttpContent;
        ResponseText: Text;
        ResponseJsonObject: JsonObject;
        ParentJsonObject: JsonObject;
        SimpleText: Text;
        RequestHeader: HttpHeaders;
        RequestText: Text;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        RequestBody: Label 'Accept=%1&Content-Type=%2&OData-Version=%3&OData-MaxVersion=%4&Prefer=%5&Authorization=%6';
        ResponseJsonToken: JsonToken;
        ServiceURL: Text;
        StringPos: Integer;
        StringLength: Integer;
        IDValue: Text;
        FailureFlag: Boolean;
        IsError: Boolean;
        ResponseErr: Text;
        TokenErr: Label 'Vendor Token Should not be Blank in TS Setup.';
        WebServiceErr: Label 'Failed to Sent.';
    begin
        GenerateRefreshToken();
        TSSetup.Get();
        ServiceURL := TSSetup."Vendor URL";
        Authorization := TSSetup.GetAuthorizationTubeStreamToken();

        VendorContractor.Reset();
        VendorContractor.SetRange("TS Sync Status", VendorContractor."TS Sync Status"::"Waiting for Sync");
        //VendorContractor.SetFilter("TS Error Message", '%1', '');
        if VendorContractor.FindSet() then begin
            repeat
                Vendor.Get(VendorContractor.Code);
                IsError := false;
                if AccessTokenErr <> '' then begin
                    IsError := true;
                    VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                    VendorContractor."TS Error Message" := AccessTokenErr;
                    VendorContractor.Modify();
                    Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                    Vendor."TS Error Message" := AccessTokenErr;
                    Vendor.Modify();
                end;
                if TSSetup."Vendor URL" = '' then begin
                    IsError := true;
                    VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                    VendorContractor."TS Error Message" := TokenErr;
                    VendorContractor.Modify();
                    Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                    Vendor."TS Error Message" := TokenErr;
                    Vendor.Modify();
                end;

                if not IsError then begin
                    GetVendorData(Vendor); //Fetching Vendor Data
                    CLEAR(Content);
                    CLEAR(HttpRequest);
                    Clear(HttpResponse);
                    Clear(Client);
                    HttpRequest.Method('POST');
                    Content.GetHeaders(HttpHeadrs);
                    HttpHeadrs.Remove('Accept');
                    HttpHeadrs.Remove('charset');
                    HttpHeadrs.Remove('OData-Version');
                    HttpHeadrs.Remove('Content-Type');
                    HttpHeadrs.Remove('OData-MaxVersion');
                    HttpHeadrs.Remove('Prefer');
                    HttpHeadrs.Add('Accept', 'application/json');
                    HttpHeadrs.Add('charset', 'utf-8');
                    HttpHeadrs.Add('OData-Version', '4.0');
                    HttpHeadrs.Add('Content-Type', 'application/json');
                    HttpHeadrs.Add('OData-MaxVersion', '4.0');
                    HttpHeadrs.Add('Prefer', 'return=representation');
                    HttpHeadrs.Add('Authorization', 'Bearer ' + AccessToken);
                    HttpRequest.Content(Content);
                    Content.WriteFrom(Data);
                    //Content.GetHeaders(HttpHeadrs);
                    //HttpHeadrs.Remove('Content-Type');
                    //HttpHeadrs.Add('Content-Type', 'application/json;charset=UTF-8');
                    client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'text/json');
                    client.DefaultRequestHeaders.TryAddWithoutValidation('Authorization', 'Bearer ' + AccessToken);
                    client.Post(TSSetup."Vendor URL", content, HttpResponse);
                    HttpResponse.Content().ReadAs(ResponseText);
                    if StrPos(ResponseText, 'success') <> 0 then begin
                        if StrPos(ResponseText, '"_id":"') <> 0 then begin
                            StringPos := StrPos(ResponseText, '"_id":"');
                            StringLength := StrLen(ResponseText);
                            IDValue := CopyStr(ResponseText, (StringPos + 7), ((StringLength - 3) - (StringPos + 7)));
                            if IDValue <> '' then begin
                                VendorResponseID := IDValue;
                                VendorContractor.ID := IDValue;
                                VendorContractor."TS Synced By" := UserId();
                                VendorContractor."TS Synced On" := CurrentDateTime;
                                VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::"Sync Complete";
                                Vendor."TS Sync Status" := Vendor."TS Sync Status"::"Sync Complete";
                                Vendor."TS ID." := IDValue;
                                Vendor."Send to TS" := true;
                                Vendor.Modify(false);
                                VendorContractor.Modify(false);
                            end else begin
                                Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                                Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                Vendor.Modify(false);
                                VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                                VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                                VendorContractor.Modify(false);
                            end;
                        end else begin
                            Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                            Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            Vendor.Modify(false);
                            VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                            VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                            VendorContractor.Modify(false);
                        end;
                    end else begin
                        Vendor."TS Sync Status" := Vendor."TS Sync Status"::Error;
                        Vendor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        Vendor.Modify(false);
                        VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::Error;
                        VendorContractor."TS Error Message" := CopyStr(ResponseText, 1, 250);
                        VendorContractor.Modify(false);
                    end;
                end;
            Until VendorContractor.Next() = 0;
            CurrPage.Update();
        end;
    end;

    procedure GetVendorData(var Vendor: Record Vendor)
    begin
        Data := '{';
        Data += '"code":' + '"' + FORMAT(Vendor."No.") + '",';
        Data += '"name":' + '"' + Vendor.Name + '",';
        Data += '"type":' + '"' + Format(Vendor.Type) + '",';
        Data += '"address":' + '"' + Vendor.Address + '"';
        Data += '}';
    end;

    procedure GenerateRefreshToken()
    var
        TokenURL: Text[1024];
        ClientId: Text[1024];
        ClientSecret: Text[1024];
        Resource: Text[1024];
        RequestBody: Label 'grant_type=client_credentials&client_id=%1&client_secret=%2&resource=%3';
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeader: HttpHeaders;
        Content: HttpContent;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        APIResult: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        TSSetup: Record "TS Setup";
    begin
        AccessTokenErr := '';
        AccessToken := '';
        TSSetup.GET;
        TSSetup.TestField("Get Access Token URL");
        TSSetup.TestField("Client ID");
        TSSetup.TestField("Client Secret");
        TSSetup.TestField("Resource URL");
        ClientId := TSSetup."Client ID";
        ClientSecret := TSSetup."Client Secret";
        Resource := TSSetup."Resource URL";
        TokenURL := TSSetup.GetAuthorizationTubeStreamToken();
        Content.GetHeaders(RequestHeader);
        RequestHeader.Clear();

        HttpClient.SetBaseAddress(TokenURL);
        RequestMessage.Method('POST');
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/x-www-form-urlencoded');

        Clear(TempBlob);
        TempBlob.CreateOutStream(Outstr);
        Outstr.WriteText(StrSubstNo(RequestBody, ClientId, ClientSecret, Resource));
        TempBlob.CreateInStream(Instr);

        Content.WriteFrom(Instr);
        RequestMessage.Content(Content);
        HttpClient.Send(RequestMessage, ResponseMessage);

        IF ResponseMessage.IsSuccessStatusCode() THEN BEGIN
            ResponseMessage.Content().ReadAs(APIResult);
            //AccessToken := ExtractToken(APIResult);
            ResponseJsonObject.ReadFrom(APIResult);
            ResponseJsonObject.GET('access_token', ResponseJsonToken);
            AccessToken := ResponseJsonToken.AsValue().AsText();
            Message(AccessToken);
        END ELSE
            AccessTokenErr := CopyStr(GetLastErrorText(), 1, 100);
    end;

    var
        Data: Text;
        Authorization: Text;
        POResponseID: Text;
        PONo: Code[20];
        VendorResponseID: Text;
        VendorNo: Code[20];
        AccessToken: Text;
        AccessTokenErr: Text[250];
}