tableextension 51001 SalesHeaderTableExt extends "Sales Header"
{
    /*TODO: Créer codeunit pour modifier les champs natifs et ajouter des triggers + custom logic */
    fields
    {
        field(50000; "Bloqué"; Boolean)
        {
            Caption = 'bloqué';
            ToolTip = 'est bloqué';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = false;
        }
        field(50001; "Origine"; Code[20])
        {
            Caption = 'Origine';
            ToolTip = 'Origine de la vente';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            TableRelation = "TypeOrigine".Code where(Nature = field("Document Type")); // on utilise le Code de TypeOrigine

            trigger OnValidate()
            begin
                //ENTETE_VENTE PC NSC1.25
                IF Rec.Origine <> xRec.Origine THEN BEGIN
                    SalesLine.RESET();
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "No.");
                    IF SalesLine.FIND('-') THEN BEGIN
                        REPEAT
                            SalesLine.Origine := Rec.Origine;
                            SalesLine.MODIFY();
                        UNTIL SalesLine.NEXT() = 0;
                        MODIFY();
                    END;
                END;
                //ENTETE_VENTE PC NSC1.25
            end;
        }
        field(50004; "Code famille client"; Code[10])
        {
            Caption = 'Code famille client';
            ToolTip = 'Code famille du client';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50005; "Remise Spéciale"; Decimal)
        {
            Caption = 'Remise Spéciale';
            ToolTip = 'Montant de la remise spéciale';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            MinValue = 0;
            MaxValue = 100;
        }
        field(50006; "Commentaires rem. spéciale"; Text[35])
        {
            Caption = 'Commentaires rem. spéciale';
            ToolTip = 'Commentaires pour la remise spéciale';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50007; "Remise pour enlèvement"; Decimal)
        {
            Caption = 'Remise pour enlèvement';
            ToolTip = 'Remise pour l''enlèvement';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            MinValue = 0;
            MaxValue = 100;
        }
        field(50008; "No. commande PalmWare"; Code[14])
        {
            Caption = 'No. commande PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 REV24 Commande Palmware';
            Editable = true;

            trigger OnValidate()
            begin
                //PALMWARE PC 16/08/99 NSC1.07  Commande Palmware
                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FIND('-') THEN BEGIN
                    SalesLine.MODIFYALL("No. commande PalmWare", "No. commande PalmWare");
                    MODIFY();
                END;
                //Fin PALMWARE PC 16/08/99 NSC1.07 Commande Palmware
            end;
        }
        field(50009; "Avoir financier"; Boolean)
        {
            Caption = 'Avoir financier';
            ToolTip = 'Indique si un avoir financier est appliqué';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50010; "Volume"; Decimal)
        {
            Caption = 'Volume';
            ToolTip = 'Volume total de la commande';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Volume WHERE("Document Type" = FIELD("Document Type"), "Sell-to Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.")));
            DecimalPlaces = 3 : 3;
        }
        field(50011; "Poids"; Decimal)
        {
            Caption = 'Poids';
            ToolTip = 'Poids total de la commande';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Poids WHERE("Document Type" = FIELD("Document Type"), "Sell-to Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.")));
            DecimalPlaces = 3 : 3;
        }
        field(50012; "Rés. à postérori dans Achat"; Boolean)
        {
            Caption = 'Rés. à postérori dans Achat';
            ToolTip = 'Résolution à postérori dans Achat';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50013; "Rés. annulées dans Achat"; Boolean)
        {
            Caption = 'Rés. annulées dans Achat';
            ToolTip = 'Résolutions annulées dans Achat';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50014; "Utilisateur"; Text[5])
        {
            Caption = 'Utilisateur';
            ToolTip = 'Utilisateur de l''enregistrement';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50030; "Reliquat"; Boolean)
        {
            Caption = 'Reliquat';
            ToolTip = 'Reliquat de la commande';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;
        }
        field(50031; "SélectionReRéservationT"; Boolean)
        {
            Caption = 'SélectionReRéservationT';
            ToolTip = 'Sélection pour réservation';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50032; "BP édité"; Boolean)
        {
            Caption = 'BP édité';
            ToolTip = 'Bon de préparation édité';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50033; "AR édité"; Boolean)
        {
            Caption = 'AR édité';
            ToolTip = 'Accusé de réception édité';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50034; "% escompte REVIMPORT"; Decimal)
        {
            Caption = '% escompte REVIMPORT';
            ToolTip = 'Pourcentage d''escompte REVIMPORT';
            Description = 'ESCOMPTE_REVIMPORT LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50035; "Cde triée"; Boolean)
        {
            Caption = 'Cde triée';
            ToolTip = 'Commande triée';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50036; "Date édition BP"; Date)
        {
            Caption = 'Date édition BP';
            ToolTip = 'Date d''édition du bon de préparation';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50037; "Heure édition BP"; Time)
        {
            Caption = 'Heure édition BP';
            ToolTip = 'Heure d''édition du bon de préparation';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50038; "No. Cde PalmWare"; Text[14])
        {
            Caption = 'No. Cde PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50039; "Proforma"; Boolean)
        {
            Caption = 'Proforma';
            ToolTip = 'Indicateur de commande Proforma';
            Description = 'PROFORMA LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50040; "Date envoi Proforma"; Date)
        {
            Caption = 'Date envoi Proforma';
            ToolTip = 'Date d''envoi du Proforma';
            Description = 'PROFORMA LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50041; "Paiement reçu"; Date)
        {
            Caption = 'Paiement reçu';
            ToolTip = 'Date de réception du paiement';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50042; "No. Commande"; Code[20])
        {
            Caption = 'No. Commande';
            ToolTip = 'Numéro de la commande';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50043; "No. client Revimex"; Code[20])
        {
            Caption = 'No. client Revimex';
            ToolTip = 'Numéro du client Revimex';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;

            trigger OnValidate()
            begin
                //REVIMEX CC 22/09/04 REV1.32
                IF ("No. client Revimex" <> xRec."No. client Revimex") THEN BEGIN
                    IF Clt2.GET("No. client Revimex") THEN
                        "Nom client Revimex" := Clt2.Name;
                    //RELIQUAT_REVIMEX CC 25/06/13 REV4.16 : modifier sur les lignes de vente
                    LigneVente.RESET();
                    LigneVente.SETRANGE("Document Type", "Document Type");
                    LigneVente.SETRANGE("Document No.", "No.");
                    IF LigneVente.FIND('-') THEN
                        REPEAT
                            LigneVente."No. client Revimex" := "No. client Revimex";
                            LigneVente.MODIFY();
                        UNTIL LigneVente.NEXT() = 0;
                    //Fin RELIQUAT_REVIMEX CC 25/06/13 REV4.16 : modifier sur les lignes de vente
                END;
                //Fin REVIMEX CC 22/09/04 REV1.32
            end;

            trigger OnLookup()
            begin
                //REVIMEX CC 22/09/04 REV1.32
                IF Page.RUNMODAL(50078, Clt2) = ACTION::LookupOK THEN BEGIN
                    "No. client Revimex" := Clt2."No.";
                    "Nom client Revimex" := Clt2.Name;
                END;
                //Fin REVIMEX CC 22/09/04 REV1.32
            end;
        }
        field(50044; "Code destinataire Revimex"; Code[10])
        {
            Caption = 'Code destinataire Revimex';
            ToolTip = 'Code destinataire Revimex';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;

            trigger OnLookup()
            begin
                //REVIMEX CC 22/09/04 REV1.32
                AdrDest2.SETRANGE("Customer No.", "No. client Revimex");
                IF Page.RUNMODAL(301, AdrDest2) = ACTION::LookupOK THEN
                    "Code destinataire Revimex" := AdrDest2.Code;
                //Fin REVIMEX CC 22/09/04 REV1.32
            end;
        }
        field(50045; "Nom client Revimex"; Text[30])
        {
            Caption = 'Nom client Revimex';
            ToolTip = 'Nom du client Revimex';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50046; "Montant facture Revimex"; Decimal)
        {
            Caption = 'Montant facture Revimex';
            ToolTip = 'Montant de la facture Revimex';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50047; "No. facture Revimex"; Code[20])
        {
            Caption = 'No. facture Revimex';
            ToolTip = 'Numéro de la facture Revimex';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50048; "Export Web"; Boolean)
        {
            Caption = 'Export Web';
            ToolTip = 'Indique si exporté sur le Web';
            Description = 'WEB LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50049; "Validée"; Boolean)
        {
            Caption = 'Validée';
            ToolTip = 'Indique si la commande est validée';
            Description = 'PREPARATION LN 06/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(50050; "Obs validée"; Text[80])
        {
            Caption = 'Obs validée';
            ToolTip = 'Observation validée';
            Description = 'PREPARATION LN 06/11/24 REV24';
            Editable = true;
        }
        field(50051; "Préparation"; Text[80])
        {
            Caption = 'Préparation';
            ToolTip = 'Préparation de la commande';
            Description = 'PREPARATION LN 06/11/24 REV24';
            Editable = true;
        }
        field(50060; "Total Outstanding Quantity"; Decimal)
        {
            Caption = 'Total Outstanding Quantity';
            ToolTip = 'Quantité totale en attente';
            Description = 'ENTETE_VENTE LN 06/11/24 REV24';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            BlankNumbers = DontBlank;
        }
    }
    var

        LigneVente: Record "Sales Line";
        Clt2: Record "Customer";
        AdrDest2: Record "Ship-to Address";
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        CltVerifLimiteCredit2: Page "Check Credit Limit";
        LignesBloques: Boolean;
        ReReserv: Boolean;
        PreservePrixDisc: Boolean;

        TextRESERVATION01: Label 'Voulez-vous lancer la fonction de reréservation ?';
        TextRESERVATION02: Label 'Voulez-vous annuler toutes les réservations \associées à la commande courante : %1?';
        TextRESERVATION03: Label 'La réservation ;%1; de ligne N° ;%2; a été affecter à ;%3; quantité ;%4';
        TextRESERVATION04: Label 'Ecriture réservation N° ;%1; a été modifier ;%2; := ;%3; quantité ;%4';
        TextRESERVATION05: Label 'Séléction des lignes de la commandes';
        TextRESERVATION06: Label '#1###################################\';
        TextRESERVATION07: Label '#2####################### #3#########';
        TextRESERVATION08: Label 'Traitement de la ligne :';

    procedure TrierLigneVenteParArticle()
    var
        RevimportReservation: Codeunit "Revimport Reservation";
    begin
        //RESERVATION PC 04/07/06 NSC4.00 Transfert code fonction TrierLigneVenteParArticle vers CodeUnit 50031
        RevimportReservation.TrierLigneVenteParArticle(Rec);
        //Fin RESERVATION PC 04/07/06 NSC4.00 Transfert code fonction TrierLigneVenteParArticle vers CodeUnit 50031
    end;

    procedure InitBloque()
    begin
        //BLOCAGE PC 01/10/99 NSC1.11 Ajout fonction InitBloque
        //* Initialisation de 'Bloqué' si au moins une ligne est 'bloqué'
        IF SalesLine."Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            IF SalesLine.FIND('-') THEN
                REPEAT
                    IF SalesLine.Bloqué THEN
                        SalesHeader.Bloqué := TRUE;
                    SalesHeader.MODIFY();
                    EXIT;
                UNTIL SalesLine.NEXT() = 0;
        END;
    end;

    procedure Debloquer()
    var
        LigVenteBloque: Record "Sales Line";
    begin
        //BLOCAGE PC NSC2.18 Ajout fonction Debloquer
        LigVenteBloque.RESET();
        LigVenteBloque.SETRANGE("Document Type", "Document Type");
        LigVenteBloque.SETRANGE("Document No.", "No.");
        IF LigVenteBloque.FIND('-') THEN
            LigVenteBloque.MODIFYALL(Bloqué, FALSE);
        Bloqué := FALSE;
        MODIFY();

    end;

    procedure ReservationTotale()
    var

        RechLigneVente: Record "Sales Line";
        RechArticle: Record "Item";
        Fenetre: Dialog;
        Selection: Text;
        Traitement: Text;
        AncRemise: Decimal;
    begin
        //RESERVATION PC 01/10/99 NSC1.11 Création fonction ReservationTotal
        Selection := TextRESERVATION05;
        Fenetre.OPEN(TextRESERVATION06 + TextRESERVATION07, Selection, Traitement, RechLigneVente."Line No.");

        RechLigneVente.RESET();
        RechLigneVente.SETRANGE("Document Type", "Document Type");
        RechLigneVente.SETRANGE("Document No.", "No.");
        Selection := '';
        Traitement := TextRESERVATION08;
        Fenetre.UPDATE();

        IF RechLigneVente.FIND('-') THEN
            REPEAT
                Fenetre.UPDATE();
                IF ((RechLigneVente.Type = RechLigneVente.Type::Item) AND RechArticle.GET(RechLigneVente."No.") AND
                (RechLigneVente."Qty. to Ship" <> 0))
                THEN BEGIN
                    IF NOT RechArticle.Blocked THEN

                        //RESERVATION SC 03/01/07 NSC4.06 Correctif migration
                        RechLigneVente.SuspendStatusCheck(TRUE);
                    //Fin RESERVATION SC 03/01/07 NSC4.06 Correctif migration

                    RechLigneVente.VALIDATE(Quantity);
                    RechLigneVente.AutoReserve();
                    RechLigneVente.MODIFY();

                END;
                COMMIT();
            UNTIL RechLigneVente.NEXT() = 0;
    end;


    procedure DeblocageEntete(NumeroLigne: Integer)
    begin
        //BLOCAGE PC 01/10/99 NSC1.11 Ajout fonction DeblocageEntete
        //* Permet de tester si l'En-Tête doit être bloqué ou pas
        IF SalesLine."Document Type" <> "Document Type"::"Credit Memo" THEN
            IF Bloqué THEN
                //* Si bloqué par l'encours, ne pas débloqué
                IF NOT CltVerifLimiteCredit2.SalesHeaderShowWarning(Rec) THEN BEGIN
                    LignesBloques := FALSE;
                    LigneVente.RESET();
                    LigneVente.SETRANGE("Document Type", "Document Type");
                    LigneVente.SETRANGE("Document No.", "No.");
                    LigneVente.SETFILTER("Line No.", '<>%1', NumeroLigne);
                    LigneVente.SETRANGE(Bloqué, TRUE);
                    IF NOT LigneVente.FIND('-') THEN BEGIN
                        Bloqué := FALSE;
                        MODIFY();
                    END;
                END;
    END;


    procedure CancelReservEntry()
    begin
        //RESERVATION PC 24/03/06 NSC4.00 Ajout fonction AnnulerEcrReservation
        LigneVente.RESET();
        LigneVente.SETRANGE("Document Type", "Document Type");
        LigneVente.SETRANGE("Document No.", "No.");
        IF LigneVente.FIND('-') THEN
            REPEAT
                LigneVente.DeleteReservEntry;
            UNTIL (LigneVente.NEXT() = 0);

    end;




}
