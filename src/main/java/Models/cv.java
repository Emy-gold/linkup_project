package Models;

import java.util.Date;

public class cv {

    private int id;
    private String titre;
    private String cheminFichier;
    private Date dateMiseAJour;
    private String competences;

    public cv(){

    }

    public cv(int id, String titre, String cheminFichier, Date dateMiseAJour, String competences) {
        this.id = id;
        this.titre = titre;
        this.cheminFichier = cheminFichier;
        this.dateMiseAJour = dateMiseAJour;
        this.competences = competences;
    }

    public int getId() {
        return id;
    }

    public String getCheminFichier() {
        return cheminFichier;
    }

    public String getTitre() {
        return titre;
    }

    public Date getDateMiseAJour() {
        return dateMiseAJour;
    }

    public String getCompetences() {
        return competences;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setCheminFichier(String cheminFichier) {
        this.cheminFichier = cheminFichier;
    }

    public void setCompetences(String competences) {
        this.competences = competences;
    }

    public void setDateMiseAJour(Date dateMiseAJour) {
        this.dateMiseAJour = dateMiseAJour;
    }
}
