
tableextension 51006 "SalesLineTableExt" extends "Sales Line"
{
    fields
    {
        field(50000; Bloqué; Boolean)
        {
            Caption = 'Bloqué';
            ToolTip = 'Indique si la ligne est bloquée';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;

            trigger OnValidate()
            begin
                //BLOCAGE PC 01/10/99 NSC1.11 Gestion du blocage et du déblocage
                IF Bloqué = FALSE THEN BEGIN
                    EnTeteVente4.GET("Document Type", "Document No.");
                    EnTeteVente4.DeblocageEntete("Line No.");
                END;
                //BLOCAGE PC 01/10/99 NSC1.11 Gestion du blocage et du déblocage
            end;
        }
        field(50001; Promotion; Boolean)
        {
            Caption = 'Promotion';
            ToolTip = 'Indique si la ligne est une promotion';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50002; Déprécié; Boolean)
        {
            Caption = 'Déprécié';
            ToolTip = 'Indique si la ligne est dépréciée';
            Description = 'LIGNE_VENTE 06/11/24 LN REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50003; "Prix Net (Pièce)"; Decimal)
        {
            Caption = 'Prix Net (Pièce)';
            ToolTip = 'Prix net par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50004; Origine; Code[20])
        {
            Caption = 'Origine';
            ToolTip = 'Code d''origine';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50005; "Prix Unitaire Remisé (Pièce)"; Decimal)
        {
            Caption = 'Prix Unitaire Remisé (Pièce)';
            ToolTip = 'Prix unitaire remisé par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50006; "% Commission"; Decimal)
        {
            Caption = '% Commission';
            ToolTip = 'Commission en pourcentage';
            Description = 'COMMISSION LN 06/11/24 REV24';
            Editable = false;
            MinValue = 0;
            MaxValue = 100;
            BlankNumbers = DontBlank;
        }
        field(50007; "Date de livraison Client"; Date)
        {
            Caption = 'Date de livraison Client';
            ToolTip = 'Date de livraison client';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50008; "No. commande PalmWare"; Code[14])
        {
            Caption = 'No. commande PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50009; "Quantité/Conditionnement"; Integer)
        {
            Caption = 'Quantité/Conditionnement';
            ToolTip = 'Quantité par conditionnement';
            Description = 'QUANTITE_CONDITIONNEMENT LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;

            trigger OnValidate()
            var
                Item: Record "Item";
                AncRemise: Decimal;
            begin

                //LIGNE_VENTE DM 13/06/00 NSC2.24 : Test de la quantité livrée pour éviter de modifier la Qté/Cond
                IF "Quantité/Conditionnement" <> xRec."Quantité/Conditionnement" THEN BEGIN
                    TESTFIELD("Quantity Shipped", 0);
                    TESTFIELD("Quantity Invoiced", 0);
                    TESTFIELD("Qty. Shipped Not Invoiced", 0);
                END;
                //Fin LIGNE_VENTE DM 13/06/00 NSC2.24 : Test de la quantité livrée pour éviter de modifier la Qté/Cond

                //LIGNE_VENTE PC 14/12/99 NSC1.14
                //On ne va plus cherche la quantite du conditionnement dans la table Unité Article
                //mais sur la ligne de vente
                IF Type = Type::Item THEN BEGIN
                    GetItem();
                    "Qty. per Unit of Measure" := "Quantité/Conditionnement";
                    "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
                    "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
                    "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
                    VALIDATE("Unit Cost (LCY)", Item."Unit Cost" * "Qty. per Unit of Measure");

                    //LIGNE_VENTE PC 14/02/00 NSC2.14 : MAJPrixUnit;
                    // NSC2.14 : "Prix Unitaire (Pièce)" := "Prix unitaire" / "Quantité par unité";
                    AncRemise := "Line Discount %";
                    VALIDATE("Unit Price", "Qty. per Unit of Measure" * "Prix Unitaire (Pièce)");
                    VALIDATE("Line Discount %", AncRemise);
                    //Fin LIGNE_VENTE PC 14/02/00 NSC2.14 : MAJPrixUnit;
                    VALIDATE(Quantity);

                    //MIGRATION_400 SC 06/03/07 NSC4.21 Correctif : "Reserved Qty. (Base)" est un FlowField, il faut rajouter un CALCFIELDS
                    CALCFIELDS("Reserved Qty. (Base)");
                    //FIN MIGRATION_400 SC 06/03/07 NSC4.21 Correctif : "Reserved Qty. (Base)" est un FlowField, il faut rajouter un CALCFIELDS

                    VALIDATE("Reserved Qty. (Base)");
                END;
                //Fin LIGNE_VENTE PC 14/12/99 NSC1.14
            end;
        }
        field(50013; "Prix Unitaire (Pièce)"; Decimal)
        {
            Caption = 'Prix Unitaire (Pièce)';
            ToolTip = 'Prix unitaire par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;

            trigger OnValidate()
            var
            begin
                //LIGNE_VENTE CC 18/03/03 REV1.29

                //USERID CC 01/01/07 REV4.03 : utiliser UPPERCASE(USERID)
                //IF (("Document Type"="Document Type"::Order) AND (USERID IN
                IF (("Document Type" = "Document Type"::Order) AND (UPPERCASE(USERID) IN
                //Fin USERID CC 01/01/07 REV4.03 : utiliser UPPERCASE(USERID)

                [TextLIGNE_VENTE05, TextLIGNE_VENTE06, TextLIGNE_VENTE15, TextLIGNE_VENTE07, TextLIGNE_VENTE16, TextLIGNE_VENTE17])) OR
                ("Document Type" <> "Document Type"::Order) THEN
                    VALIDATE("Unit Price", ("Prix Unitaire (Pièce)" * "Qty. per Unit of Measure"))
                ELSE
                    Rec."Prix Unitaire (Pièce)" := xRec."Prix Unitaire (Pièce)";
                //Fin LIGNE_VENTE CC 18/03/03 REV1.29
            end;
        }
        field(50014; "Volume (unitaire)"; Decimal)
        {
            Caption = 'Volume (unitaire)';
            ToolTip = 'Volume unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            DecimalPlaces = 3 : 3;
        }
        field(50015; Volume; Decimal)
        {
            Caption = 'Volume';
            ToolTip = 'Volume total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            DecimalPlaces = 3 : 3;
        }
        field(50016; "Poids (unitaire)"; Decimal)
        {
            Caption = 'Poids (unitaire)';
            ToolTip = 'Poids unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            DecimalPlaces = 3 : 3;
        }
        field(50017; Poids; Decimal)
        {
            Caption = 'Poids';
            ToolTip = 'Poids total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            DecimalPlaces = 3 : 3;
        }
        field(50018; "% remise REVIMPORT"; Decimal)
        {
            Caption = '% remise REVIMPORT';
            ToolTip = 'Pourcentage de remise REVIMPORT';
            Description = 'REMISE_REVIMPORT LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50019; "Stock physique (qté)"; Decimal)
        {
            Caption = 'Stock physique (qté)';
            ToolTip = 'Stock physique en quantité';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Location Code" = FIELD("Location Code"), "Variant Code" = FIELD("Variant Code")));
        }
        field(50020; Renouvelable; Boolean)
        {
            Caption = 'Renouvelable';
            ToolTip = 'Indique si renouvelable';
            Description = 'RENOUVELABLE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50021; "Nbre de colis"; Decimal)
        {
            Caption = 'Nbre de colis';
            ToolTip = 'Nombre de colis';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            DecimalPlaces = 0 : 5;
        }
        field(50022; "Ancienne Date d'expédition"; Date)
        {
            Caption = 'Ancienne Date d''expédition';
            ToolTip = 'Ancienne date d''expédition';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50023; "Date d'expédition retardée"; Boolean)
        {
            Caption = 'Date d''expédition retardée';
            ToolTip = 'Indique si la date d''expédition est retardée';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50024; SélectionReRéservationT; Boolean)
        {
            Caption = 'SélectionReRéservationT';
            ToolTip = 'Sélection pour la ré-réservation T';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50025; SélectionReRéservationU; Boolean)
        {
            Caption = 'SélectionReRéservationU';
            ToolTip = 'Sélection pour la ré-réservation U';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50026; NouveauNLigne; Integer)
        {
            Caption = 'NouveauNLigne';
            ToolTip = 'Nouveau numéro de ligne';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50027; "Prix négocié"; Boolean)
        {
            Caption = 'Prix négocié';
            ToolTip = 'Indique si le prix est négocié';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50038; "No. Cde PalmWare"; Text[14])
        {
            Caption = 'No. Cde PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50043; "No. client Revimex"; Code[20])
        {
            Caption = 'No. client Revimex';
            ToolTip = 'Numéro de client Revimex';
            Description = 'REVIMEX LN 06/11/24 REV24';
            Editable = true;
        }
    }

    keys
    {
        key(Key23; "SélectionReRéservationT", "SélectionReRéservationU")
        {
            Enabled = true;
        }
        // key(Key24; "Document Type", "Type","No.","Date de livraison Client")
        // {
        //     Enabled = true;
        // }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        //#pragma warning disable AA0137
#pragma warning disable AA0074
#pragma warning disable AA0470
#pragma warning disable AA0021
        PrixUnitaire: Decimal;
        ComRepresentant: Record "CommissionRepresentant";
        Client: Record Customer;
        ParamStock: Record "Inventory Setup";
        LigVente3: Record "Sales Line";
        CondProduit: Record "Item Variant";
        EcrituresReservations: Record "Reservation Entry";
        entier: Integer;
        EnTeteVente4: Record "Sales Header";
        DateTemp: Date;
        EnTeteVente2: Record "Sales Header";
        EcrReserv2: Record "Reservation Entry";
        EcrReserv3: Record "Reservation Entry";
        //ArticleRemplacement: Record "RecepisseTransport";
        entier2: Enum "Sales Document Type"; // turn back into Integer if fail
        MajPUOk: Boolean;
        UpPriceForCopyDoc: Boolean;
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        TextLIGNE_VENTE01: Label 'Une réservation est en train d''être effectuée pour cet article\', Comment = 'FRF';
        TextLIGNE_VENTE02: Label 'Veuillez ressaisir la quantité ultérieurement pour mettre à ', Comment = 'FRF';
        TextLIGNE_VENTE03: Label ' jour', Comment = 'FRF';
        TextLIGNE_VENTE04: Label 'ESP', Comment = 'ESP';
        TextLIGNE_VENTE05: Label 'AM', Comment = 'AM';
        TextLIGNE_VENTE06: Label 'MCR', Comment = 'MCR';
        TextLIGNE_VENTE07: Label 'CC', Comment = 'CC';
        TextLIGNE_VENTE08: Label 'Le prix unitaire de l''article %1 est inférieur au prix net remisé ou au TG qui est de %2.', Comment = 'FRF';
        TextLIGNE_VENTE09: Label 'Le prix unitaire de l''article %1 est supérieur au prix TG qui est de %2 ', Comment = 'FRF';
        TextLIGNE_VENTE10: Label 'Le prix unitaire de l''article %1 est inférieur au prix net qui est de %2.', Comment = 'FRF';
        TextLIGNE_VENTE11: Label 'Le document n° %1 n''existe pas. La réservation dans les ventes ne pas pas être effectuée', Comment = 'FRF';
        TextLIGNE_VENTE12: Label 'Une réservation a été générée pour la commande de vente %1, article n° %2', Comment = 'FRF';
        TextLIGNE_VENTE13: Label 'Il n''y a pas assez de quantité en stock\', Comment = 'FRF';
        TextLIGNE_VENTE14: Label 'pour pouvoir livrer voulez vous modifier les réservations', Comment = 'FRF';
        TextLIGNE_VENTE15: Label 'PR', Comment = 'PR';
        TextLIGNE_VENTE16: Label 'ARCASOFT', Comment = 'ARCASOFT';
        TextLIGNE_VENTE17: Label 'HD', Comment = 'HD';
#pragma warning restore

    procedure VerificationPrixNet()
    var
        ParamVente: Record "Sales & Receivables Setup";
        Art: Record "Item";
        SalesHeader: Record "Sales Header";
        //PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        PriceCalcMgtCstm: Codeunit "SalesPriceCalcMgtCustom";
        PrixUnit: Decimal;
        PrixTG: Decimal;
        PrixNet: Decimal;
        ArtPrixNet: Decimal;
        RemisePrixNet: Boolean;
        BlocageCde: Boolean;
        ArticlePromo: Boolean;
    begin
        //VENTE_PRIX PC NSC1.03 Ajout fonction VerificationPrixNet
        //* Vérification du prix unitaire réel après remise

        IF (Type = Type::Item) AND (Quantity <> 0) THEN BEGIN

            BlocageCde := FALSE;

            //* Calcul TG fiche article/grille tarif et recherche du flag Remise Prix Net

            //VENTE_PRIX PC NSC4.00 22/03/06 Modification fonction VerificationPrixNet
            PrixTG := 0;
            PrixNet := 0;
            RemisePrixNet := FALSE;
            PriceCalcMgtCstm.FindSalesLinePrice2(SalesHeader, Rec, PrixTG, PrixNet, RemisePrixNet); //TODO: modifier le reste des procedures du codeunit "Sales Price Calc. Mgt."

            //LIGNE_VENTE PC 15/01/07 NSC4.16 Calcul PrixTG
            IF "Qty. per Unit of Measure" <> 1 THEN
                PrixTG := PrixTG / "Qty. per Unit of Measure";
            //Fin LIGNE_VENTE PC 15/01/07 NSC4.16 Calcul PrixTG

            IF Art.GET("No.") THEN
                ArticlePromo := Art."Article Promo";
            //Fin VENTE_PRIX PC NSC4.00 22/03/06 Modification fonction VerificationPrixNet

            IF "Prix Net (Pièce)" > 0 THEN BEGIN
                IF RemisePrixNet THEN BEGIN
                    ParamVente.GET();
                    IF ArticlePromo = TRUE THEN
                        ArtPrixNet := ROUND(PrixNet * (1 - (ParamVente."Remise article déprécié" / 100)), 0.00001)
                    ELSE
                        ArtPrixNet := ROUND(PrixNet * (1 - (ParamVente."Remise article non déprécié" / 100)), 0.00001);
                END ELSE
                    ArtPrixNet := PrixNet
            END ELSE
                ArtPrixNet := RechPrixRemInitial(TRUE);

            //* Calcul Prix Unitaire ligne vente
            IF "Line Discount %" <> 0 THEN
                PrixUnit := ROUND("Prix Unitaire (Pièce)" - (("Prix Unitaire (Pièce)" * "Line Discount %") / 100), 0.01, '>')
            ELSE
                PrixUnit := PrixTG;

            //* Comparaison Prix Unitaire avec Prix Net Remisé et TG
            IF (("Document Type" <> "Document Type"::"Credit Memo") AND ("Document Type" <> "Document Type"::Invoice)) THEN
                IF PrixTG <> 0 THEN BEGIN
                    IF ("Prix Unitaire (Pièce)" > PrixTG) THEN
                        BlocageCde := TRUE
                    ELSE
                        IF (PrixUnit < ArtPrixNet) THEN BEGIN
                            IF "Prix Unitaire (Pièce)" < PrixUnit THEN
                                BlocageCde := TRUE
                        END ELSE
                            IF "Prix Unitaire (Pièce)" < ArtPrixNet THEN
                                BlocageCde := TRUE;

                END ELSE
                    //* Il faut unique prendre le prix net
                    IF ("Prix Unitaire (Pièce)" < ArtPrixNet) THEN
                        BlocageCde := TRUE;


            IF "Prix négocié" AND ("Prix Unitaire (Pièce)" <> xRec."Prix Unitaire (Pièce)") THEN
                IF "Prix Unitaire (Pièce)" <> RechPrixRemInitial(FALSE) THEN
                    BlocageCde := TRUE
                ELSE
                    BlocageCde := FALSE;

            //* Si Prix Unitaire non valide on bloque la ligne et la commande
            IF (("Prix Unitaire (Pièce)" <> xRec."Prix Unitaire (Pièce)")) OR
                ((xRec.Quantity = 0) AND (xRec.Quantity <> Quantity)) THEN
                IF BlocageCde THEN BEGIN
                    Bloqué := TRUE;
                    EnTeteVente2.GET("Document Type", "Document No.");
                    EnTeteVente2.Bloqué := TRUE;
                    EnTeteVente2.MODIFY();
                END ELSE
                    Bloqué := FALSE;


            IF PrixTG <> 0 THEN BEGIN
                "% remise REVIMPORT" := ((PrixTG - "Prix Unitaire Remisé (Pièce)") / PrixTG) * 100;
                IF "% remise REVIMPORT" = 0 THEN
                    "% remise REVIMPORT" := "Line Discount %";
            END;

            IF Client.GET(EnTeteVente2."Sell-to Customer No.") THEN
                "% Commission" :=
                ComRepresentant.CalculerCommission(SalesHeader."Salesperson Code", "% remise REVIMPORT", Client."Soumis à R.F.A");


            IF ("Document Type" <> "Document Type"::"Credit Memo") AND
                (Type = Type::Item) THEN
                VALIDATE(Bloqué);


        END;
    end;


    procedure CalculerVolumePoids()
    var
        Item: Record "Item";
    begin
        //VOLUME_POIDS PC 16/08/99 NSC1.07 Ajout fonction CalculerVolumePoids
        IF Type = Type::Item THEN BEGIN
            GetItem();
            VALIDATE("Volume (unitaire)", Item."Volume moyen" * "Quantité/Conditionnement");
            VALIDATE("Poids (unitaire)", Item."Gross Weight" * "Quantité/Conditionnement");
            VALIDATE(Volume, "Volume (unitaire)" * Quantity);
            VALIDATE(Poids, "Poids (unitaire)" * Quantity);
            VALIDATE("Net Weight", "Poids (unitaire)");
            VALIDATE("Unit Volume", "Volume (unitaire)");
        END;
    end;


    procedure ReserverDansVenteDepuisAchat(NoDoc: Code[20]; VAR JamaisTrouve: Boolean)
    var

        EnteteAchat: Record "Purchase Header";
        LigAchat: Record "Purchase Line";
        //LigVente3: Record "Sales Line";
        EnteteVente3: Record "Sales Header";
    begin

        //RESERVATION PC 01/10/99 NSC1.11 Ajout Fonction ReserverdansventeDepuisAchat
        IF NOT EnteteAchat.GET(EnteteAchat."Document Type"::Order, NoDoc) THEN
            ERROR(STRSUBSTNO(TextLIGNE_VENTE11, NoDoc));

        LigAchat.RESET();
        LigAchat.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code",
                            "Expected Receipt Date");
        LigAchat.SETRANGE("Document Type", EnteteAchat."Document Type"::Order);
        LigAchat.SETRANGE("Document No.", NoDoc);
        LigAchat.SETRANGE(Type, LigAchat.Type::Item);
        IF NOT LigAchat.FIND('-') THEN
            EXIT;

        JamaisTrouve := TRUE;
        REPEAT
            //* Sélection des lignes de commandes de vente ayant une date de disponibilité (Shipment Date) égal à 31/12/19
            LigVente3.RESET();
            LigVente3.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Shipment Date");
            LigVente3.SETRANGE(Type, LigVente3.Type::Item);
            LigVente3.SETRANGE("No.", LigAchat."No.");
            LigVente3.SETRANGE("Variant Code", LigAchat."Variant Code");
            LigVente3.SETRANGE("Drop Shipment", FALSE);
            LigVente3.SETRANGE("Location Code", LigAchat."Location Code");
            LigVente3.SETRANGE("Bin Code", LigAchat."Bin Code");
            //RESERVATION CC 27/01/20 REV4.18 : remplacer 311219D par 31122069D
            //LigVente3.SETFILTER("Shipment Date",'311219');
            LigVente3.SETFILTER("Shipment Date", '31122069D');
            IF LigVente3.FIND('-') THEN
                REPEAT
                    //* Génération de la ligne de réservation sur la commande de vente
                    IF LigVente3.Reserve = LigVente3.Reserve::Always THEN BEGIN
                        LigVente3.AutoReserve();
                        LigVente3.MODIFY();
                        LigVente3.CALCFIELDS("Reserved Quantity");
                        IF LigVente3."Reserved Quantity" > 0 THEN BEGIN
                            EnteteVente3.GET(LigVente3."Document Type", LigVente3."Document No.");
                            EnteteVente3."Rés. à postérori dans Achat" := TRUE;
                            EnteteVente3.MODIFY();
                            JamaisTrouve := FALSE;
                        END;
                    END;
                UNTIL LigVente3.NEXT() = 0;

        UNTIL LigAchat.NEXT() = 0;
    end;

    procedure MAJDateDispoReserv()
    begin
        //RESERVATION PC 21/10/99 NSC1.12 Ajout fonction MAJDateDispoReserv

        //RESERVATION PC 24/03/06 NSC4.00 Modification fonction MAJDateDispoReserv
        EcrReserv3.RESET();
        EcrReserv3.SETCURRENTKEY("Reservation Status", "Source Type", "Source Subtype", "Source ID", "Source Ref. No.");
        EcrReserv3.SETRANGE("Reservation Status", EcrReserv3."Reservation Status"::Reservation);
        EcrReserv3.SETRANGE("Source Type", 37);
        entier2 := "Document Type";
        EcrReserv3.SETRANGE("Source Subtype", entier2);
        EcrReserv3.SETRANGE("Source ID", "Document No.");
        EcrReserv3.SETRANGE("Source Ref. No.", "Line No.");
        IF EcrReserv3.FIND('-') THEN
            REPEAT
                IF ((EcrReserv3."Expected Receipt Date" <> 0D) AND ("Shipment Date" < EcrReserv3."Expected Receipt Date")) THEN
                    "Shipment Date" := EcrReserv3."Expected Receipt Date";
            UNTIL (EcrReserv3.NEXT() = 0);

        //Fin RESERVATION PC 24/03/06 NSC4.00 Modification fonction MAJDateDispoReserv
    end;


    procedure RechPrixRemInitial(BoolTypePrixRem: Boolean) PrixRemInitial: Decimal
    var
        TempLigVente: Record "Sales Line";
    begin
        //LIGNE_VENTE DM 30/08/00 NSC2.27 Ajout fonction RechPrixRemInitial
        PrixRemInitial := 0;
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            TempLigVente.VALIDATE("Document Type", "Document Type");
            TempLigVente.VALIDATE("Document No.", "Document No.");
            TempLigVente.VALIDATE("Line No.", 0);
            TempLigVente.VALIDATE("Sell-to Customer No.", "Sell-to Customer No.");

            //LIGNE_VENTE SC 03/01/07 NSC4.06 Correctif Migration
            TempLigVente.SuspendStatusCheck(TRUE);
            //Fin LIGNE_VENTE SC 03/01/07 NSC4.06 Correctif Migration

            TempLigVente.VALIDATE(Type, Type);
            TempLigVente.VALIDATE("No.", "No.");
            IF BoolTypePrixRem THEN
                PrixRemInitial := TempLigVente."Prix Unitaire Remisé (Pièce)"
            ELSE
                PrixRemInitial := TempLigVente."Prix Unitaire (Pièce)";
        END;
    end;

    procedure DeleteReservEntry()
    begin
        //RESERVATION PC 24/03/06 NSC4.00 Ajout fonction DeleteReservEntry
        IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
            ReserveSalesLine.DeleteLine(Rec);
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)", 0);
        END;
    end;

    procedure UpdatePriceForCopyDoc()
    begin
        //COPIE_DOCUMENT PC 09/05/07 NSC4.28 Ajout fonction UpdatePriceForCopyDoc
        UpPriceForCopyDoc := TRUE;
    end;

}
