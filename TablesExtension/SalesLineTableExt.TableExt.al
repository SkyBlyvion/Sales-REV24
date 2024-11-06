
tableextension 51006 "SalesLineTableExt" extends "Sales Line"
{
    fields
    {
        field(50000; Bloqué; Boolean)
        {
            Caption = 'Bloqué';
            ToolTip = 'Indique si la ligne est bloquée';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50001; Promotion; Boolean)
        {
            Caption = 'Promotion';
            ToolTip = 'Indique si la ligne est une promotion';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50002; Déprécié; Boolean)
        {
            Caption = 'Déprécié';
            ToolTip = 'Indique si la ligne est dépréciée';
            Description = 'LIGNE_VENTE 06/11/24 LN REV24';
            Editable = true;
        }
        field(50003; "Prix Net (Pièce)"; Decimal)
        {
            Caption = 'Prix Net (Pièce)';
            ToolTip = 'Prix net par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
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
            Editable = true;
        }
        field(50006; "% Commission"; Decimal)
        {
            Caption = '% Commission';
            ToolTip = 'Commission en pourcentage';
            Description = 'COMMISSION LN 06/11/24 REV24';
            Editable = true;
        }
        field(50007; "Date de livraison Client"; Date)
        {
            Caption = 'Date de livraison Client';
            ToolTip = 'Date de livraison client';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
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
        }
        field(50013; "Prix Unitaire (Pièce)"; Decimal)
        {
            Caption = 'Prix Unitaire (Pièce)';
            ToolTip = 'Prix unitaire par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50014; "Volume (unitaire)"; Decimal)
        {
            Caption = 'Volume (unitaire)';
            ToolTip = 'Volume unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50015; Volume; Decimal)
        {
            Caption = 'Volume';
            ToolTip = 'Volume total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50016; "Poids (unitaire)"; Decimal)
        {
            Caption = 'Poids (unitaire)';
            ToolTip = 'Poids unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50017; Poids; Decimal)
        {
            Caption = 'Poids';
            ToolTip = 'Poids total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50018; "% remise REVIMPORT"; Decimal)
        {
            Caption = '% remise REVIMPORT';
            ToolTip = 'Pourcentage de remise REVIMPORT';
            Description = 'REMISE_REVIMPORT LN 06/11/24 REV24';
            Editable = true;
        }
        field(50019; "Stock physique (qté)"; Decimal)
        {
            Caption = 'Stock physique (qté)';
            ToolTip = 'Stock physique en quantité';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50020; Renouvelable; Boolean)
        {
            Caption = 'Renouvelable';
            ToolTip = 'Indique si renouvelable';
            Description = 'RENOUVELABLE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50021; "Nbre de colis"; Decimal)
        {
            Caption = 'Nbre de colis';
            ToolTip = 'Nombre de colis';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50022; "Ancienne Date d'expédition"; Date)
        {
            Caption = 'Ancienne Date d''expédition';
            ToolTip = 'Ancienne date d''expédition';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50023; "Date d'expédition retardée"; Boolean)
        {
            Caption = 'Date d''expédition retardée';
            ToolTip = 'Indique si la date d''expédition est retardée';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50024; SélectionReRéservationT; Boolean)
        {
            Caption = 'SélectionReRéservationT';
            ToolTip = 'Sélection pour la ré-réservation T';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50025; SélectionReRéservationU; Boolean)
        {
            Caption = 'SélectionReRéservationU';
            ToolTip = 'Sélection pour la ré-réservation U';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50026; NouveauNLigne; Integer)
        {
            Caption = 'NouveauNLigne';
            ToolTip = 'Nouveau numéro de ligne';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50027; "Prix négocié"; Boolean)
        {
            Caption = 'Prix négocié';
            ToolTip = 'Indique si le prix est négocié';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = true;
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
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}

/******  5b624ad4-e0f0-4bca-b0fc-3b8a06dd481a  *******/
