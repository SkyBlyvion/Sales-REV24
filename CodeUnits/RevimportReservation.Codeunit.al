codeunit 51007 "Revimport Reservation"
{
    /* 
    * 
    *  Documentation()
    *  //RESERVATION PC 04/07/06 NSC4.00 :
    *  Création codeunit
    *  Ajout fonction TrierLigneVenteParArticle
    *
    *  07/11/24 Création du Codeunit en AL
    *  This codeunit is designed to handle the reservation and sorting logic for sales lines related to purchase entries.
    */
    var

        LigneVenteATrier: Record "Sales Line";
        LigneVenteTrans: Record "Sales Line";
        RechEcritureReservation: Record "Reservation Entry";
        NLigne: Integer;
        PrecArticle: Code[20];
        TypeDocReserv: Enum "Sales Document Type"; // switch from integer to the enum
        //Ok: Boolean;
        Fenetre: Dialog;
    //Fic: File;
    //mess: Text[250];

    procedure TrierLigneVenteParArticle(VAR EnteteVente: Record "Sales Header")
    begin

        //RESERVATION PC 04/07/06 NSC4.00 Ajout fonction TrierLigneVenteParArticle

        //with EnteteVente DO BEGIN

        /*//* Mise en place d'un fichier trace
        {
        Ok := ERASE('C:\Trace.txt');
            IF NOT Fic.CREATE('C:\Trace.txt') THEN BEGIN
                MESSAGE('Impossible de créer le ficher: C:\Trace.txt' +
                        'L''historique ne sera donc pas disponible');
            END;
            Fic.OPEN('C:\Trace.txt');
            Fic.TEXTMODE(TRUE);
        }
        //* Définition de la fenêtre de statut */

        Fenetre.OPEN('Traitement de la ligne de vente   : #1######## #2######## #3########\'
                    + 'Modification de la ligne de vente : #4######## #5######## #6########\'
                    + 'Modification de la réservation    : #7########'
                    , LigneVenteATrier."Document Type"
                    , LigneVenteATrier."Document No."
                    , LigneVenteATrier."Line No."
                    , LigneVenteTrans."Document Type"
                    , LigneVenteTrans."Document No."
                    , LigneVenteTrans."Line No."
                    , RechEcritureReservation."Entry No.");

        //* Sélection des lignes à trier

        LigneVenteATrier.RESET();
        LigneVenteATrier.SETRANGE("Document Type", EnteteVente."Document Type");
        LigneVenteATrier.SETRANGE("Document No.", EnteteVente."No.");

        //* Traitement des lignes de commentaires

        IF LigneVenteATrier.FIND('-') THEN
            REPEAT
                IF (LigneVenteATrier."No." <> PrecArticle) AND (LigneVenteATrier."No." <> '') THEN
                    PrecArticle := LigneVenteATrier."No.";
                IF (LigneVenteATrier."No." = '') AND (PrecArticle <> '') THEN BEGIN
                    LigneVenteATrier."No." := PrecArticle;
#pragma warning disable AA0139
                    LigneVenteATrier."Description 2" := LigneVenteATrier."Description 2" + '/*-+-*/';
#pragma warning restore 
                    LigneVenteATrier.MODIFY();
                    // {
                    // mess := STRSUBSTNO('La ligne N° ;%1; a été détecter comme étant un commentaire', LigneVenteATrier."Line No.");
                    //         Fic.WRITE(mess);
                    // }
                END;
            UNTIL LigneVenteATrier.NEXT() = 0;

        //* Affectation des nouveau N° de ligne aux lignes de vente et de réservations

        LigneVenteATrier.SETCURRENTKEY("No.");
        LigneVenteATrier.ASCENDING(TRUE);
        NLigne := 0;
        IF LigneVenteATrier.FIND('-') THEN
            REPEAT
                Fenetre.UPDATE();
                NLigne := NLigne + 10000;

                //* Traitement des écritures de réservations liées

                RechEcritureReservation.RESET();
                RechEcritureReservation.SETCURRENTKEY("Reservation Status", "Source Type", "Source Subtype", "Source ID", "Source Ref. No.");
                RechEcritureReservation.SETRANGE("Reservation Status", RechEcritureReservation."Reservation Status"::Reservation);
                RechEcritureReservation.SETRANGE("Source Type", 37);
                TypeDocReserv := EnteteVente."Document Type"; // there was an implicit convertion Enum -> Integer
                RechEcritureReservation.SETRANGE("Source Subtype", TypeDocReserv);
                RechEcritureReservation.SETRANGE("Source ID", EnteteVente."No.");
                RechEcritureReservation.SETRANGE("Source Ref. No.", LigneVenteATrier."Line No.");
                IF RechEcritureReservation.FIND('-') THEN
                    REPEAT
                        RechEcritureReservation.NouveauNLigne := NLigne;
                        RechEcritureReservation.MODIFY();
                    // {
                    // mess := STRSUBSTNO('La réservation ;%1; de ligne N° ;%2; a été affecter à ;%3; quantité ;%4'
                    //                     , RechEcritureReservation."Entry No."
                    //                     , LigneVenteATrier."Line No."
                    //                     , NLigne
                    //                     , RechEcritureReservation.Quantity);
                    //         Fic.WRITE(mess);
                    // }
                    UNTIL RechEcritureReservation.NEXT() = 0;

                //* Fin Traitement des écritures de réservations liées

                LigneVenteATrier.NouveauNLigne := NLigne;
                LigneVenteATrier.MODIFY();
                //     {
                //     mess := STRSUBSTNO('La ligne N° ;%1; a été renommer ;%2; quantité ;%3'
                //                         , LigneVenteATrier."Line No."
                //                         , LigneVenteATrier.NouveauNLigne
                //                         , LigneVenteATrier."Quantity (Base)");
                // Fic.WRITE(mess);
                //     }
                IF (LigneVenteATrier."Quantity Shipped" + LigneVenteATrier."Quantity Invoiced") <> 0 THEN
                    ERROR('Impossible de trier les lignes. Des quantités ont été livrées ou facturées');
            UNTIL LigneVenteATrier.NEXT() = 0;

        //* Affectation des nouveau N° de ligne aux lignes de vente et de réservations

        //* MAJ des lignes de vente

        IF LigneVenteATrier.FIND('-') THEN
            REPEAT
                LigneVenteTrans := LigneVenteATrier;
                LigneVenteTrans."Line No." := LigneVenteATrier.NouveauNLigne;
                LigneVenteTrans.NouveauNLigne := 0;
                LigneVenteTrans.INSERT();
            UNTIL LigneVenteATrier.NEXT() = 0;
        IF LigneVenteTrans.FIND('-') THEN BEGIN
            LigneVenteATrier.DELETEALL();
            REPEAT
                Fenetre.UPDATE();
                LigneVenteATrier := LigneVenteTrans;
                LigneVenteATrier.INSERT();
                IF STRPOS(LigneVenteATrier."Description 2", '/*-+-*/') <> 0 THEN BEGIN
                    LigneVenteATrier."No." := '';
                    LigneVenteATrier."Description 2" := DELCHR(LigneVenteATrier."Description 2", '=', '/*-+-*/');
                    LigneVenteATrier.MODIFY();
                END;
            UNTIL LigneVenteTrans.NEXT() = 0;
        END;

        //* MAJ des écritures de réservations

        RechEcritureReservation.RESET();
        RechEcritureReservation.SETCURRENTKEY(NouveauNLigne);
        RechEcritureReservation.SETFILTER(NouveauNLigne, '<>%1', 0);
        IF RechEcritureReservation.FIND('-') THEN
            REPEAT
                Fenetre.UPDATE();
                // {
                // mess := STRSUBSTNO('Ecriture réservation N° ;%1; a été modifier ;%2; := ;%3; quantité ;%4'
                //                     ,RechEcritureReservation."Entry No."
                //                     ,RechEcritureReservation."Source Ref. No."
                //                     ,RechEcritureReservation.NouveauNLigne
                //                     ,RechEcritureReservation.Quantity);
                // Fic.WRITE(mess);
                // }
                RechEcritureReservation."Source Ref. No." := RechEcritureReservation.NouveauNLigne;
                RechEcritureReservation.NouveauNLigne := 0;
                RechEcritureReservation.MODIFY();
            UNTIL RechEcritureReservation.NEXT() = 0;

        Fenetre.CLOSE();
        //* Fic.CLOSE;

        //* MAJ entête vente
        EnteteVente."Cde triée" := TRUE;
        EnteteVente.MODIFY();

    END;


}