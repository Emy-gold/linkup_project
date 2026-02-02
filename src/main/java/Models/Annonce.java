package Models;

import java.util.Date;

public class Annonce {

    private int id;
    private String titre;
    private String descriptionPoste;
    private String typeContrat;
    private String statutAnnonce;
    private Date datePublication;

    //the foreign keys
    private int recruteurId;


    public Annonce(){

    }


    public Annonce(int id, String titre, String descriptionPoste, String typeContrat, String statutAnnonce, Date datePublication, int recruteurId) {
        this.id = id;
        this.titre = titre;
        this.descriptionPoste = descriptionPoste;
        this.typeContrat = typeContrat;
        this.statutAnnonce = statutAnnonce;
        this.datePublication = datePublication;
        this.recruteurId = recruteurId;
    }

    public int getId() {
        return id;
    }

    public String getTitre() {
        return titre;
    }

    public String getDescriptionPoste() {
        return descriptionPoste;
    }

    public String getTypeContrat() {
        return typeContrat;
    }

    public Date getDatePublication() {
        return datePublication;
    }

    public String getStatutAnnonce() {
        return statutAnnonce;
    }

    public int getRecruteurId() {return recruteurId;}

    public void setId(int id) {
        this.id = id;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setDatePublication(Date datePublication) {
        this.datePublication = datePublication;
    }

    public void setDescriptionPoste(String descriptionPoste) {
        this.descriptionPoste = descriptionPoste;
    }

    public void setStatutAnnonce(String statutAnnonce) {
        this.statutAnnonce = statutAnnonce;
    }

    public void setTypeContrat(String typeContrat) {
        this.typeContrat = typeContrat;
    }

    public void setRecruteurId(int recruteurId) {
        this.recruteurId = recruteurId;
    }
}
