package Models;

public class Diplome {

    private int id;
    private String libelle;
    private String documentJustificatif;
    private String statutValidation;


    public Diplome(){

    }

    public Diplome(int id, String libelle, String documentJustificatif, String statutValidation) {
        this.id = id;
        this.libelle = libelle;
        this.documentJustificatif = documentJustificatif;
        this.statutValidation = statutValidation;
    }

    public int getId() {
        return id;
    }

    public String getLibelle() {
        return libelle;
    }

    public String getDocumentJustificatif() {
        return documentJustificatif;
    }

    public String getStatutValidation() {
        return statutValidation;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDocumentJustificatif(String documentJustificatif) {
        this.documentJustificatif = documentJustificatif;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public void setStatutValidation(String statutValidation) {
        this.statutValidation = statutValidation;
    }
}
