tableextension 51001 SalesHeaderTableExt extends "Sales Header"
{
    fields
    {
        field(50000; Bloqué; Boolean)
        {
            Caption = 'bloqué';
            ToolTip = 'est bloqué';
            Description = 'BLOCAGE LN 06/11/24 NSC1.11';
            Editable = false;
        }

        field(50001; Origine; Code[20])
        {
            Caption = 'Origine';
            ToolTip = 'Origine de la vente';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50004; Code famille client;
            Code[10])
        {
            Caption = 'Code famille client';
            ToolTip = 'Code famille du client';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50005; Remise Spéciale; Decimal)
        {
            Caption = 'Remise Spéciale';
            ToolTip = 'Montant de la remise spéciale';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50006; Commentaires rem. spéciale; Text[35])
        {
            Caption = 'Commentaires rem. spéciale';
            ToolTip = 'Commentaires pour la remise spéciale';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50007; Remise pour enlèvement; Decimal)
        {
            Caption = 'Remise pour enlèvement';
            ToolTip = 'Remise pour l’enlèvement';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50008; N° commande PalmWare; Code[14])
        {
            Caption = 'N° commande PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 NSC1.07 Commande Palmware';
            Editable = true;
        }

        field(50009; Avoir financier; Boolean)
        {
            Caption = 'Avoir financier';
            ToolTip = 'Indique si un avoir financier est appliqué';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC1.11';
            Editable = true;
        }

        field(50010; Volume; Decimal)
        {
            Caption = 'Volume';
            ToolTip = 'Volume total de la commande';
            Description = 'VOLUME_POIDS LN 06/11/24 NSC1.07';
            Editable = true;
        }

        field(50011; Poids; Decimal)
        {
            Caption = 'Poids';
            ToolTip = 'Poids total de la commande';
            Description = 'VOLUME_POIDS LN 06/11/24 NSC1.07';
            Editable = true;
        }

        field(50012; Rés. à postérori dans Achat; Boolean)
        {
            Caption = 'Rés. à postérori dans Achat';
            ToolTip = 'Résolution à postérori dans Achat';
            Description = 'ENTETE_VENTE SL 06/11/24 NSC1.14';
            Editable = true;
        }

        field(50013; Rés. annulées dans Achat; Boolean)
        {
            Caption = 'Rés. annulées dans Achat';
            ToolTip = 'Résolutions annulées dans Achat';
            Description = 'ENTETE_VENTE SL 06/11/24 NSC1.14';
            Editable = true;
        }

        field(50014; Utilisateur; Text[5])
        {
            Caption = 'Utilisateur';
            ToolTip = 'Utilisateur de l’enregistrement';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC2.12';
            Editable = true;
        }

        field(50030; Reliquat; Boolean)
        {
            Caption = 'Reliquat';
            ToolTip = 'Reliquat de la commande';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC2.12';
            Editable = true;
        }

        field(50031; SélectionReRéservationT; Boolean)
        {
            Caption = 'SélectionReRéservationT';
            ToolTip = 'Sélection pour réservation';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC2.12';
            Editable = true;
        }

        field(50032; BP édité; Boolean)
        {
            Caption = 'BP édité';
            ToolTip = 'Bon de préparation édité';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC2.12';
            Editable = true;
        }

        field(50033; AR édité; Boolean)
        {
            Caption = 'AR édité';
            ToolTip = 'Accusé de réception édité';
            Description = 'ENTETE_VENTE LN 06/11/24 NSC2.12';
            Editable = true;
        }

        field(50034; % escompte REVIMPORT; Decimal)
        {
            Caption = '% escompte REVIMPORT';
            ToolTip = 'Pourcentage d’escompte REVIMPORT';
            Description = 'ESCOMPTE_REVIMPORT LN 06/11/24 NSC2.19';
            Editable = true;
        }

        field(50035; Cde triée; Boolean)
        {
            Caption = 'Cde triée';
            ToolTip = 'Commande triée';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.19';
            Editable = true;
        }

        field(50036; Date édition BP; Date)
        {
            Caption = 'Date édition BP';
            ToolTip = 'Date d’édition du bon de préparation';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.19';
            Editable = true;
        }

        field(50037; Heure édition BP; Time)
        {
            Caption = 'Heure édition BP';
            ToolTip = 'Heure d’édition du bon de préparation';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.19';
            Editable = true;
        }

        field(50038; N° Cde PalmWare; Text[14])
        {
            Caption = 'N° Cde PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.30';
            Editable = true;
        }

        field(50039; Proforma; Boolean)
        {
            Caption = 'Proforma';
            ToolTip = 'Indicateur de commande Proforma';
            Description = 'PROFORMA CC 06/11/24 REV1.31';
            Editable = true;
        }

        field(50040; Date envoi Proforma; Date)
        {
            Caption = 'Date envoi Proforma';
            ToolTip = 'Date d’envoi du Proforma';
            Description = 'PROFORMA CC 06/11/24 REV1.31';
            Editable = true;
        }

        field(50041; Paiement reçu; Date)
        {
            Caption = 'Paiement reçu';
            ToolTip = 'Date de réception du paiement';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.31';
            Editable = true;
        }

        field(50042; N° Commande; Code[20])
        {
            Caption = 'N° Commande';
            ToolTip = 'Numéro de la commande';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.31';
            Editable = true;
        }

        field(50043; N° client Revimex; Code[20])
        {
            Caption = 'N° client Revimex';
            ToolTip = 'Numéro du client Revimex';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.32';
            Editable = true;
        }

        field(50044; Code destinataire Revimex; Code[10])
        {
            Caption = 'Code destinataire Revimex';
            ToolTip = 'Code destinataire Revimex';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.32';
            Editable = true;
        }

        field(50045; Nom client Revimex; Text[30])
        {
            Caption = 'Nom client Revimex';
            ToolTip = 'Nom du client Revimex';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.32';
            Editable = true;
        }

        field(50046; Montant facture Revimex; Decimal)
        {
            Caption = 'Montant facture Revimex';
            ToolTip = 'Montant de la facture Revimex';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.32';
            Editable = true;
        }

        field(50047; N° facture Revimex; Code[20])
        {
            Caption = 'N° facture Revimex';
            ToolTip = 'Numéro de la facture Revimex';
            Description = 'ENTETE_VENTE CC 06/11/24 REV1.32';
            Editable = true;
        }

        field(50048; Export Web; Boolean)
        {
            Caption = 'Export Web';
            ToolTip = 'Indique si exporté sur le Web';
            Description = 'WEB CC 06/11/24 REV4.14';
            Editable = true;
        }

        field(50049; Validée; Boolean)
        {
            Caption = 'Validée';
            ToolTip = 'Indique si la commande est validée';
            Description = 'PREPARATION CC 06/11/24 REV4.16';
            Editable = true;
        }

        field(50050; Obs validée; Text[80])
        {
            Caption = 'Obs validée';
            ToolTip = 'Observation validée';
            Description = 'PREPARATION CC 06/11/24 REV4.16';
            Editable = true;
        }

        field(50051; Préparation; Text[80])
        {
            Caption = 'Préparation';
            ToolTip = 'Préparation de la commande';
            Description = 'PREPARATION CC 06/11/24 REV4.18';
            Editable = true;
        }

        field(50060; Total Outstanding Quantity; Decimal)
        {
            Caption = 'Total Outstanding Quantity';
            ToolTip = 'Quantité totale en attente';
            Description = 'ENTETE_VENTE LN 06/11/24';
            Editable = true;
        }
    }
}
