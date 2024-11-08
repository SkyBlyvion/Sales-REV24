pageextension 51013 "SalesRcvbleSetupPageExt" extends "Sales & Receivables Setup"
{
    /**
    * Page extension pour la page de paramétrage des ventes.
    * Ajoute des champs pour saisir les pourcentages de remise sur les articles dépréciés et non dépréciés,
    * ainsi que les compteurs pour les affacturages débiteurs, PNS, effets et FactoFrance.
    */
    layout
    {
        addlast(General)
        {
            // Champ de saisie pour le pourcentage de remise sur les articles dépréciés
            field("Remise article déprécié"; Rec."Remise article déprécié")
            {
                Editable = true;
                ApplicationArea = All;
            }
            // Champ de saisie pour le pourcentage de remise sur les articles non dépréciés
            field("Remise article non déprécié"; Rec."Remise article non déprécié")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addlast("Number Series")
        {
            // Champ de saisie pour le compteur des affacturages débiteurs
            field("Compteur Affacturage Débiteurs"; Rec."Compteur Affacturage Débiteurs")
            {
                Editable = true;
                ApplicationArea = All;
            }
            // Champ de saisie pour le compteur des affacturages PNS
            field("Compteur Affacturage PNS"; Rec."Compteur Affacturage PNS")
            {
                Editable = true;
                ApplicationArea = All;
            }
            // Champ de saisie pour le compteur des affacturages effets
            field("Compteur Affacturage Effets"; Rec."Compteur Affacturage Effets")
            {
                Editable = true;
                ApplicationArea = All;
            }
            // Champ de saisie pour le compteur des factures FactoFrance
            field("Compteur FactoFrance"; Rec."Compteur FactoFrance")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
    }
}


