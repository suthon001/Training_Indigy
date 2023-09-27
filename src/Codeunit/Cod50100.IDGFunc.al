codeunit 50100 "IDG Func"
{


    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 101 then
            NewReportId := report::"IDG Customer Lists";
        if ReportId = REPORT::"Customer - Top 10 List" then
            NewReportId := REPORT::"IDG Customer - Top 10 List";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Business group Code" <> '' then
            SalesHeader.Validate("Business group Code", SalesHeader."Business group Code");
    end;



    [EventSubscriber(ObjectType::Table, Database::"Traning Header", 'OnAfterLookupVendorNo', '', false, false)]
    local procedure OnAfterLookupVendorNo(pVendor: Record Vendor; var TrainingHEader: Record "Traning Header")
    begin
        TrainingHEader."Customer Name" := pVendor.Name;
    end;

    procedure GetToken()
    var
        ltJsonToken, ltJsonToken2 : JsonToken;
        ltJsonobject: JsonObject;
        ltHttpContent: HttpContent;
        ltHttpHeadersContent: HttpHeaders;
        ltHttpRequestMessage: HttpRequestMessage;
        ltHttpResponseMessage: HttpResponseMessage;
        ltHttpClient: HttpClient;
        ltUrlAddress, ResponText, BCToken : Text;
    begin

        ltUrlAddress := 'https://login.microsoftonline.com/a0746c2e-942d-455a-83e4-26a96f7271bb/oauth2/v2.0/token';
        ltHttpContent.WriteFrom('grant_type=client_credentials&client_id=8ae06a2d-e6f8-4cee-83be-0d3ff69d0214&client_secret=OOh8Q~1Q9~9LWczfrJl14Lnr.Bi~_d3MPul-vc-h&scope=https%3A%2F%2Fapi.businesscentral.dynamics.com%2F.default');
        ltHttpContent.GetHeaders(ltHttpHeadersContent);
        ltHttpHeadersContent.Remove('Content-Type');
        ltHttpHeadersContent.Add('Content-Type', 'application/x-www-form-urlencoded');
        ltHttpClient.Clear();
        ltHttpClient.SetBaseAddress(ltUrlAddress);
        ltHttpClient.Post(ltUrlAddress, ltHttpContent, ltHttpResponseMessage);
        ltHttpResponseMessage.Content().ReadAs(ResponText);
        ltJsonToken.ReadFrom(ResponText);
        ltJsonobject := ltJsonToken.AsObject();
        ltJsonobject.SelectToken('$.access_token', ltJsonToken2);
        BCToken := ltJsonToken2.AsValue().AsText();
        CreateSalesBlanket(BCToken);


    end;

    procedure CreateSalesBlanket(pToken: text)
    var
        ltJsonobject, JsonObjectBuild : JsonObject;
        ltJsonToken: JsonToken;
        ltJsonArray: JsonArray;
        ltHttpContent: HttpContent;
        ltHttpHeadersContent, contentHeaders : HttpHeaders;
        ltHttpRequestMessage: HttpRequestMessage;
        ltHttpResponseMessage: HttpResponseMessage;
        ltHttpClient: HttpClient;
        Body, ltUrlAddress, ResponText : Text;
    begin
        ltJsonobject.Add('Type', 'Item');
        ltJsonobject.Add('No', '1896-S');
        ltJsonobject.Add('Location_Code', 'WEST');
        ltJsonobject.Add('Quantity', 1);
        ltJsonArray.Add(ltJsonobject);
        JsonObjectBuild.Add('sellToCustomerNo', '30000');
        JsonObjectBuild.Add('postingDate', 20230927D);
        JsonObjectBuild.Add('blanketlines', ltJsonArray);
        JsonObjectBuild.WriteTo(Body);


        ltHttpHeadersContent := ltHttpClient.DefaultRequestHeaders();
        ltHttpHeadersContent.Add('Authorization', 'Bearer ' + pToken);
        ltHttpContent.WriteFrom(Body);
        ltHttpContent.GetHeaders(contentHeaders);

        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        ltUrlAddress := 'https://api.businesscentral.dynamics.com/v2.0/a0746c2e-942d-455a-83e4-26a96f7271bb/In_Sandbox001/api/idg/bc/v1.0/salesbanketorders?$expand=blanketlines&company=Cronus';
        ltHttpClient.Post(ltUrlAddress, ltHttpContent, ltHttpResponseMessage);
        ltHttpResponseMessage.Content().ReadAs(ResponText);
        ltJsonToken.ReadFrom(ResponText);
        ltJsonobject := ltJsonToken.AsObject();

    end;

    procedure CallUserPassword()
    var
        Base64: Codeunit "Base64 Convert";
        ltJsonobject, JsonObjectBuild : JsonObject;
        ltJsonToken: JsonToken;
        ltJsonArray: JsonArray;
        ltHttpContent: HttpContent;
        ltHttpHeadersContent, contentHeaders : HttpHeaders;
        ltHttpRequestMessage: HttpRequestMessage;
        ltHttpResponseMessage: HttpResponseMessage;
        ltHttpClient: HttpClient;
        Body, ltUrlAddress, ResponText, AuthString : Text;
    begin

        AuthString := StrSubstNo('%1:%2', 'User', 'Password');
        AuthString := StrSubstNo('Basic ', Base64.ToBase64(AuthString));

        ltJsonobject.Add('Type', 'Item');
        ltJsonobject.Add('No', '1896-S');
        ltJsonobject.Add('Location_Code', 'WEST');
        ltJsonobject.Add('Quantity', 1);
        ltJsonArray.Add(ltJsonobject);
        JsonObjectBuild.Add('sellToCustomerNo', '30000');
        JsonObjectBuild.Add('postingDate', 20230927D);
        JsonObjectBuild.Add('blanketlines', ltJsonArray);
        JsonObjectBuild.WriteTo(Body);

        ltHttpHeadersContent := ltHttpClient.DefaultRequestHeaders();
        ltHttpHeadersContent.Add('Authorization', AuthString);

        ltHttpContent.WriteFrom(Body);
        ltHttpContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        ltUrlAddress := 'https://api.businesscentral.dynamics.com/v2.0/a0746c2e-942d-455a-83e4-26a96f7271bb/In_Sandbox001/api/idg/bc/v1.0/salesbanketorders?$expand=blanketlines&company=Cronus';
        ltHttpClient.Post(ltUrlAddress, ltHttpContent, ltHttpResponseMessage);
        ltHttpResponseMessage.Content().ReadAs(ResponText);
        ltJsonToken.ReadFrom(ResponText);
        ltJsonobject := ltJsonToken.AsObject();




    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnBeforeDeleteSalesHeader', '', false, false)]
    local procedure OnDeleteAfterPostingOnBeforeDeleteSalesHeader(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            GetToken();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader', '', false, false)]
    local procedure OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."Posted By" := UserId();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesInvHeader."Posted By" := UserId();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertCrMemoHeader', '', false, false)]
    local procedure SalesCrMemoHeader(SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertInvoiceHeader', '', false, false)]
    local procedure OnAfterInsertInvoiceHeader(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', false, false)]
    local procedure OnAfterPurchRcptHeaderInsert(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertCrMemoHeader', '', false, false)]
    local procedure OnAfterInsertCrMemoHeader(var PurchaseHeader: Record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Traning Dev" := SalesHeader."Traning Dev";
        ItemJnlLine."Posted By" := UserId();
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchHeader(PurchHeader: Record "Purchase Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Traning Dev" := PurchHeader."Traning Dev";
        ItemJnlLine."Posted By" := UserId();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgEntry: Record "Item Ledger Entry")
    begin
        NewItemLedgEntry."Posted By" := ItemJournalLine."Posted By";
        NewItemLedgEntry."Traning Dev" := ItemJournalLine."Traning Dev";
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    // local procedure OnAfterInitValueEntry(var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry")
    // begin
    //     ValueEntry."Posted By" := ItemJournalLine."Posted By";
    //     ValueEntry."Traning Dev" := ItemJournalLine."Traning Dev";
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnBeforeTransferLineToSalesDoc', '', false, false)]
    local procedure OnBeforeTransferLineToSalesDoc(SalesShipmentHeader: Record "Sales Shipment Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Traning Dev" := SalesShipmentHeader."Traning Dev";
        SalesHeader."Quote No." := SalesShipmentHeader."Quote No.";
        SalesHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnBeforeTransferLineToPurchaseDoc', '', false, false)]
    local procedure OnBeforeTransferLineToPurchaseDoc(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."Traning Dev" := PurchRcptHeader."Traning Dev";
        PurchaseHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Table, database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")
    begin
        VATEntry."Traning Dev" := GenJournalLine."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Traning Dev" := SalesHeader."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Traning Dev" := PurchaseHeader."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Table, database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Traning Dev" := GenJournalLine."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Traning Dev" := GenJournalLine."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInsertVATOnAfterAssignVATEntryFields', '', false, false)]
    local procedure OnInsertVATOnAfterAssignVATEntryFields(var VATEntry: Record "VAT Entry"; GenJnlLine: Record "Gen. Journal Line")
    begin
        VATEntry."Traning Dev" := GenJnlLine."Traning Dev";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure OnAfterFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        ltVendor: Record Vendor;
        gvHttpHeadersContent, contentHeaders : HttpHeaders;
        gvHttpRequestMessage: HttpRequestMessage;
        gvHttpResponseMessage: HttpResponseMessage;
        gvHttpClient: HttpClient;
        gvHttpContent, gvHttpContentaddboydy : HttpContent;
        ltJsonToken: JsonToken;
        ltJsonObject: JsonObject;
        gvResponseText, ltCode, ltMessage, ltJsonBody, AuthString : Text;
        Base64: Codeunit "Base64 Convert";
        AuthStringTxt: Label '%1:%2', Locked = true;
        AuthHeaderTxt: Label 'Basic %1', Locked = true;
        AuthHeaderLbl: Label 'Authorization', Locked = true;
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            // CLEAR(gvHttpRequestMessage);
            // CLEAR(gvHttpClient);
            // CLEAR(gvHttpResponseMessage);
            // CLEAR(gvResponseText);
            // CLEAR(gvHttpContent);
            // CLEAR(gvHttpContentaddboydy);
            // AuthString := STRSUBSTNO(AuthStringTxt, pUser, pPassword);
            // AuthString := STRSUBSTNO(AuthHeaderTxt, Base64.ToBase64(AuthString));

            // gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
            // gvHttpHeadersContent.Add(AuthHeaderLbl, AuthString);
            // pJsonObject.WriteTo(ltJsonBody);

            // gvHttpContentaddboydy.WriteFrom(ltJsonBody);
            // gvHttpContentaddboydy.GetHeaders(contentHeaders);
            // contentHeaders.Clear();
            // contentHeaders.Add('Content-Type', 'application/json');
            // gvHttpClient.Post(pBaseUrl, gvHttpContentaddboydy, gvHttpResponseMessage);
            // gvHttpResponseMessage.Content.ReadAs(gvResponseText);
            // ltJsonToken.ReadFrom(gvResponseText);

        end;
    end;
}
