package Models;

public class Diplome {
    private int id_diplome;
    private int id_candidat;
    private int id_universite;      // IMPORTANT
    private String libelle;
    private String document_justificatif;
    private String statut_validation;
    private String date_traitement; // IMPORTANT

    // Getters et setters pour TOUS ces champs
    public int getId_diplome() { return id_diplome; }
    public void setId_diplome(int id_diplome) { this.id_diplome = id_diplome; }

    public int getId_candidat() { return id_candidat; }
    public void setId_candidat(int id_candidat) { this.id_candidat = id_candidat; }

    public int getId_universite() { return id_universite; }  // IMPORTANT
    public void setId_universite(int id_universite) { this.id_universite = id_universite; }

    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }

    public String getDocument_justificatif() { return document_justificatif; }
    public void setDocument_justificatif(String document_justificatif) {
        this.document_justificatif = document_justificatif;
    }

    public String getStatut_validation() { return statut_validation; }
    public void setStatut_validation(String statut_validation) {
        this.statut_validation = statut_validation;
    }

    public String getDate_traitement() { return date_traitement; }  // IMPORTANT
    public void setDate_traitement(String date_traitement) {
        this.date_traitement = date_traitement;
    }
}