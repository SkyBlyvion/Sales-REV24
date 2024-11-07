# Sales Extension for Business Central

### Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Features](#features)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)
  
---

## Overview

**Sales Extension** is a Business Central extension developed by **Lopez Nicolas - REVIMPORT**. The initial version of this extension allows for the handling of Sales Header and Sales Line data, with plans to extend support for additional entities in the future.

## Installation

To install the extension in your Business Central environment, follow these steps:

1. Download the `.app` file from the repository or obtain it from the publisher.
2. In Business Central, navigate to **Extensions** > **Manage** > **Upload Extension**.
3. Choose the downloaded `.app` file and click **Deploy**.

> **Requirements**: 
> - Business Central version 24.5.0.0 or higher.
> - Platform version 1.0.0.0 or higher.

## Features

- **Sales Header Integration**: Access and manage data related to sales headers.
- **Sales Line Integration**: Access and manage data associated with individual sales lines.

Future updates will include additional functionality as the extension expands.

## Usage

Once installed, the Sales extension can be accessed directly from the Sales module in Business Central. You can manage and interact with Sales Headers and Sales Lines seamlessly.

## Configuration

IdRanges :
    - 51000
    - tableextension 51001 SalesHeaderTableExt extends "Sales Header"
    - table 51002 TypeOrigine
    - permissionset 51003 "SalesPerms"
    - page 51004 "TypeOrigine"
    - enum 51005 NatureEnum
    - tableextension 51006 "SalesLineTableExt" extends "Sales Line"
    - codeunit 51007 "Revimport Reservation"
    - codeunit 51008 "SalesPriceCalcMgtCustom"
    - table 51009 CommissionReprésentant
    - Page 51010 "CommisionRepresentant"
    - table 51011 "TypeRemise"
    - 51012
    - 51013
    - 51014
    - codeunit 51015 "ReservationEntryCustomField"



### Example Code Snippets

```al
// Example AL code 
old code 
codeunit 51008 "SalesPriceCalcMgtCustom"
{
    var
        Res: Record Resource;
        HideResUnitPriceMessage: Boolean;
        Text000: Label '%1 is less than %2 in the %3.';
        Text010: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
        Text001: Label 'The %1 in the %2 must be same as in the %3.';
        TempTableErr: Label 'The table passed as a parameter must be temporary.';
        GLSetup: Record "General Ledger Setup";
        Item: Record "Item";
        ResPrice: Record "Resource Price";
        Currency: Record "Currency";
        TempSalesPrice: Record "Sales Price";
        TempSalesLineDisc: Record "Sales Line Discount";
        ResFindUnitPrice: Codeunit "Resource-Find Price";
        LineDiscPerCent: Decimal;
        Qty: Decimal;
        AllowLineDisc: Boolean;
        AllowInvDisc: Boolean;
        VATPerCent: Decimal;
        PricesInclVAT: Boolean;
        VATCalcType: Option;
        VATBusPostingGr: Code[10];
        QtyPerUOM: Decimal;
        PricesInCurrency: Boolean;
        CurrencyFactor: Decimal;
        ExchRateDate: Date;
        FoundSalesPrice: Boolean;
        DateCaption: Text[30];

    procedure FindSalesLinePrice2(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var PrixTG: Decimal; var PrixNet: Decimal)
    var
        Item: Record Item;
        TempSalesPrice: Record "Sales Price";
        FoundSalesPrice: Boolean;
        RemisePrixNet: Boolean;
    begin
        // VENTE_PRIX PC 03/03/06 NSC4.00 Ajout fonction FindSalesLinePrice2
        // * Copie fonction standard FindSalesLinePrice

        // Set up the currency, VAT, unit of measure, and discount for the Sales Line
        SetCurrency(
            SalesHeader."Currency Code",
            SalesHeader."Currency Factor",
            SalesHeaderExchDate(SalesHeader));

        SetVAT(
            SalesHeader."Prices Including VAT",
            SalesLine."VAT %",
            SalesLine."VAT Calculation Type",
            SalesLine."VAT Bus. Posting Group");

        SetUoM(ABS(SalesLine.Quantity), SalesLine."Qty. per Unit of Measure");
        SetLineDisc(SalesLine."Line Discount %", SalesLine."Allow Line Disc.", SalesLine."Allow Invoice Disc.");

        SalesLine.TESTFIELD("Qty. per Unit of Measure");

        if PricesInCurrency then
            SalesHeader.TESTFIELD("Currency Factor");

        case SalesLine.Type of
            SalesLine.Type::Item:
                begin
                    Item.GET(SalesLine."No.");
                    FoundSalesPrice := SalesLinePriceExists(SalesHeader, SalesLine, false);
                    CalcBestUnitPrice(TempSalesPrice);

                    if FoundSalesPrice then begin
                        SalesLine."Allow Line Disc." := TempSalesPrice."Allow Line Disc.";
                        SalesLine."Allow Invoice Disc." := TempSalesPrice."Allow Invoice Disc.";
                        SalesLine."Unit Price" := TempSalesPrice."Unit Price";
                    end;

                    if not SalesLine."Allow Line Disc." then
                        SalesLine."Line Discount %" := 0;

                    // * Récupération des infos Revimport
                    PrixTG := TempSalesPrice."Unit Price";
                    PrixNet := TempSalesPrice."Prix net";
                    RemisePrixNet := TempSalesPrice."Remise prix net";
                end;
        end;
    end;

    local procedure SetCurrency(CurrencyCode2: Code[10]; CurrencyFactor2: Decimal; ExchRateDate2: Date)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        PricesInCurrency := CurrencyCode2 <> '';
        IF PricesInCurrency THEN BEGIN
            Currency.GET(CurrencyCode2);
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
            CurrencyFactor := CurrencyFactor2;
            ExchRateDate := ExchRateDate2;
        END ELSE
            GLSetup.GET();
    end;

    local procedure SalesHeaderExchDate(SalesHeader: Record "Sales Header"): Date
    begin
        WITH SalesHeader DO BEGIN
            IF ("Document Type" IN ["Document Type"::"Blanket Order", "Document Type"::Quote]) AND
                ("Posting Date" = 0D)
            THEN
                EXIT(WORKDATE());
            EXIT("Posting Date");
        END;
    end;


    local procedure SetVAT(PriceInclVAT2: Boolean; VATPerCent2: Decimal; VATCalcType2: Option; VATBusPostingGr2: Code[10])
    begin
        PricesInclVAT := PriceInclVAT2;
        VATPerCent := VATPerCent2;
        VATCalcType := VATCalcType2;
        VATBusPostingGr := VATBusPostingGr2;
    end;

    procedure SetUoM(Qty2: Decimal; QtyPerUoM2: Decimal)
    begin
        Qty := Qty2;
        QtyPerUOM := QtyPerUoM2;
    end;

    procedure SetLineDisc(LineDiscPerCent2: Decimal; AllowLineDisc2: Boolean; AllowInvDisc2: Boolean)
    begin
        LineDiscPerCent := LineDiscPerCent2;
        AllowLineDisc := AllowLineDisc2;
        AllowInvDisc := AllowInvDisc2;
    end;

    procedure SalesLinePriceExists(SalesHeader: Record "Sales Header"; VAR SalesLine: Record "Sales Line"; ShowAll: Boolean): Boolean
    begin
        WITH SalesLine DO
            IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
                FindSalesPrice(
                TempSalesPrice, "Bill-to Customer No.", SalesHeader."Bill-to Contact No.",
                "Customer Price Group", '', "No.", "Variant Code", "Unit of Measure Code",
                SalesHeader."Currency Code", SalesHeaderStartDate(SalesHeader, DateCaption), ShowAll);
                EXIT(TempSalesPrice.FIND('-'));
            END;
        EXIT(FALSE);
    end;

    procedure FindSalesPrice(var ToSalesPrice: Record "Sales Price"; CustNo: Code[20]; ContNo: Code[20]; CustPriceGrCode: Code[10]; CampaignNo: Code[10])
    var
        FromSalesPrice: Record "Sales Price";
    begin
        FromSalesPrice.SETRANGE("Item No.", ItemNo);
        FromSalesPrice.SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
        FromSalesPrice.SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
        FromSalesPrice.SETRANGE("Starting Date", 0D, StartingDate);

        // Fin PRIX_ACHAT PC 03/03/06 NSC4.00 Recherche du dernier prix et non du meilleur

        ToSalesPrice.RESET();
        ToSalesPrice.DELETEALL();
        FromSalesPrice.SETRANGE("Sales Type", FromSalesPrice."Sales Type"::"Customer Price Group");
        FromSalesPrice.SETRANGE("Sales Code", CustPriceGrCode);

        CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);

        // Fin PRIX_VENTE PC 03/03/06 NSC4.00 Recherche du dernier prix et non du meilleur
    end;



    procedure CalcBestUnitPrice(VAR SalesPrice: Record "Sales Price")
    begin
        WITH SalesPrice DO BEGIN
            FoundSalesPrice := FIND('-');
            IF FoundSalesPrice THEN
                REPEAT
                    IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
                        ConvertPriceToVAT(
                        "Price Includes VAT", Item."VAT Prod. Posting Group",
                        "VAT Bus. Posting Gr. (Price)", "Unit Price");
                        ConvertPriceToUoM("Unit of Measure Code", "Unit Price");
                        ConvertPriceLCYToFCY("Currency Code", "Unit Price");

                        CASE TRUE OF
                            ((BestSalesPrice."Currency Code" = '') AND ("Currency Code" <> '')) OR
                        ((BestSalesPrice."Variant Code" = '') AND ("Variant Code" <> '')):
                                BestSalesPrice := SalesPrice;
                            ((BestSalesPrice."Currency Code" = '') OR ("Currency Code" <> '')) AND
                        ((BestSalesPrice."Variant Code" = '') OR ("Variant Code" <> '')):
                                IF (BestSalesPrice."Unit Price" = 0) OR
                                (CalcLineAmount(BestSalesPrice) > CalcLineAmount(SalesPrice))
                                THEN
                                    BestSalesPrice := SalesPrice;
                        END;
                    END;
                UNTIL NEXT() = 0;
        END;

        // No price found in agreement
        IF BestSalesPrice."Unit Price" = 0 THEN BEGIN
            ConvertPriceToVAT(
                Item."Price Includes VAT", Item."VAT Prod. Posting Group",
                Item."VAT Bus. Posting Gr. (Price)", Item."Unit Price");
            ConvertPriceToUoM('', Item."Unit Price");
            ConvertPriceLCYToFCY('', Item."Unit Price");

            CLEAR(BestSalesPrice);
            BestSalesPrice."Unit Price" := Item."Unit Price";
            BestSalesPrice."Allow Line Disc." := AllowLineDisc;
            BestSalesPrice."Allow Invoice Disc." := AllowInvDisc;
        END;

        SalesPrice := BestSalesPrice;

    end;

    procedure SalesHeaderStartDate(SalesHeader: Record "Sales Header"; VAR DateCaption: Text[30]): Date
    begin
        WITH SalesHeader DO
            IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN BEGIN
                DateCaption := FIELDCAPTION("Posting Date");
                EXIT("Posting Date")
            END ELSE BEGIN
                DateCaption := FIELDCAPTION("Order Date");
                EXIT("Order Date");
            END;

    end;

}

