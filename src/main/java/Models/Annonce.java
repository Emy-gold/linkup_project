package Models;

import java.util.Date;

public class Annonce {

    private int id;
    private String titre;
    private String description;
    private String typeContrat;
    private String statutAnnonce;
    private Date datePublication;

    // the foreign keys
    private int id_recruteur;

    public Annonce() {

    }

    public Annonce(int id, String titre, String description, String typeContrat, String statutAnnonce,
            Date datePublication, int id_recruteur) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.typeContrat = typeContrat;
        this.statutAnnonce = statutAnnonce;
        this.datePublication = datePublication;
        this.id_recruteur = id_recruteur;
    }

    public int getId() {
        return id;
    }

    public String getTitre() {
        return titre;
    }

    public String getDescription() {
        return description;
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

    public int getId_recruteur() {
        return id_recruteur;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setDatePublication(Date datePublication) {
        this.datePublication = datePublication;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatutAnnonce(String statutAnnonce) {
        this.statutAnnonce = statutAnnonce;
    }

    public void setTypeContrat(String typeContrat) {
        this.typeContrat = typeContrat;
    }

    public void setId_recruteur(int id_recruteur) {
        this.id_recruteur = id_recruteur;
    }
}
