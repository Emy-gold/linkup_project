package Models;

public class Diplome {
    private int id;
    private int candidatId;
    private String libelle;
    private String documentJustificatif; // Chemin vers le fichier PDF/image
    private String statutValidation; // "En attente", "Validé", "Rejeté"

    public Diplome() {}

    public Diplome(int id, int candidatId, String libelle, String documentJustificatif, String statutValidation) {
        this.id = id;
        this.candidatId = candidatId;
        this.libelle = libelle;
        this.documentJustificatif = documentJustificatif;
        this.statutValidation = statutValidation;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCandidatId() {
        return candidatId;
    }

    public void setCandidatId(int candidatId) {
        this.candidatId = candidatId;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getDocumentJustificatif() {
        return documentJustificatif;
    }

    public void setDocumentJustificatif(String documentJustificatif) {
        this.documentJustificatif = documentJustificatif;
    }

    public String getStatutValidation() {
        return statutValidation;
    }

    public void setStatutValidation(String statutValidation) {
        this.statutValidation = statutValidation;
    }
}