package Models;

import java.util.Date;

public class recruteur extends utilisateur{

    private String nomEntreprise;
    private String secteurActivite;
    private String descriptionEntreprise;
    private String logo;
    private String posteOccupe;

    public recruteur() {
    }

    public recruteur(int idUtilisateur, String email, String nom, String prenom, Date date, String statutCompte, String nomEntreprise, String secteurActivite, String descriptionEntreprise,String logo, String posteOccupe) {
        super(idUtilisateur, email, nom, prenom, date, statutCompte);
        this.nomEntreprise = nomEntreprise;
        this.secteurActivite = secteurActivite;
        this.descriptionEntreprise = descriptionEntreprise;
        this.logo = logo;
        this.posteOccupe = posteOccupe;
    }

    public String getNomEntreprise() {
        return nomEntreprise;
    }

    public void setNomEntreprise(String nomEntreprise) {
        this.nomEntreprise = nomEntreprise;
    }

    public String getSecteurActivite() {
        return secteurActivite;
    }

    public void setSecteurActivite(String secteurActivite) {
        this.secteurActivite = secteurActivite;
    }

    public String getDescriptionEntreprise() {
        return descriptionEntreprise;
    }

    public void setDescriptionEntreprise(String descriptionEntreprise) {
        this.descriptionEntreprise = descriptionEntreprise;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getPosteOccupe() {
        return posteOccupe;
    }

    public void setPosteOccupe(String posteOccupe) {
        this.posteOccupe = posteOccupe;
    }
}
