codeunit 51008 "SalesPriceCalcMgtCustom"
{
    // Appel de la procedure dans procedure VerificationPrixNet() depuis la table "SalesLineTableExt" qui extends Sales Line
    procedure FindSalesLinePrice2(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var PrixTG: Decimal; var PrixNet: Decimal; var RemisePrixNet: Boolean)
    var
        Item: Record Item;
#pragma warning disable AL0432
#pragma warning disable AA0237
        TempSalesPrice: Record "Sales Price";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        FoundSalesPrice: Boolean;
        PricesInCurrency: Boolean;
#pragma warning restore
    begin
        // VENTE_PRIX PC 03/03/06 NSC4.00 Ajout fonction FindSalesLinePrice2
        // * Copie fonction standard FindSalesLinePrice

        // Set up the currency, VAT, unit of measure, and discount for the Sales Line
        SalesPriceCalcMgt.SetCurrency(
            SalesHeader."Currency Code",
            SalesHeader."Currency Factor",
            SalesPriceCalcMgt.SalesHeaderExchDate(SalesHeader));

        SalesPriceCalcMgt.SetVAT(
            SalesHeader."Prices Including VAT",
            SalesLine."VAT %",
#pragma warning disable AL0603
            SalesLine."VAT Calculation Type",
#pragma warning restore
            SalesLine."VAT Bus. Posting Group");

        SalesPriceCalcMgt.SetUoM(ABS(SalesLine.Quantity), SalesLine."Qty. per Unit of Measure");
        SalesPriceCalcMgt.SetLineDisc(SalesLine."Line Discount %", SalesLine."Allow Line Disc.", SalesLine."Allow Invoice Disc.");

        SalesLine.TESTFIELD("Qty. per Unit of Measure");

        if PricesInCurrency then
            SalesHeader.TESTFIELD("Currency Factor");

        case SalesLine.Type of
            SalesLine.Type::Item:
                begin
                    Item.GET(SalesLine."No.");
                    FoundSalesPrice := SalesPriceCalcMgt.SalesLinePriceExists(SalesHeader, SalesLine, false);
                    SalesPriceCalcMgt.CalcBestUnitPrice(TempSalesPrice);

                    if FoundSalesPrice then begin
                        SalesLine."Allow Line Disc." := TempSalesPrice."Allow Line Disc.";
                        SalesLine."Allow Invoice Disc." := TempSalesPrice."Allow Invoice Disc.";
                        SalesLine."Unit Price" := TempSalesPrice."Unit Price";
                    end;

                    if not SalesLine."Allow Line Disc." then
                        SalesLine."Line Discount %" := 0;

                    // * Récupération des infos Revimport
                    PrixTG := TempSalesPrice."Unit Price";
#pragma warning disable AL0432
                    PrixNet := TempSalesPrice."Prix net";
                    RemisePrixNet := TempSalesPrice."Remise prix net";
#pragma warning restore
                end;
        end;
    end;



}
