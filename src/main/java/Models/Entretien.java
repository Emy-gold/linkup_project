package Models;

import java.util.Date;

public class Entretien {

    private int id;
    private Date dateHeure;
    private String lieu;
    private String statutEntretien;
    private String notesRecruteur;

    //foreign keys
    private int candidatureId;



    // NOUVEAUX CHAMPS POUR L'AFFICHAGE
    private String nom;
    private String prenom;
    private String titreAnnonce;


    public Entretien(){

    }

    public Entretien(int id, Date dateHeure, String lieu, String statutEntretien, String notesRecruteur, int candidatureId) {
        this.id = id;
        this.dateHeure = dateHeure;
        this.lieu = lieu;
        this.statutEntretien = statutEntretien;
        this.notesRecruteur = notesRecruteur;
        this.candidatureId = candidatureId;
    }

    public int getId() {
        return id;
    }

    public Date getDateHeure() {
        return dateHeure;
    }

    public String getLieu() {
        return lieu;
    }

    public String getNotesRecruteur() {
        return notesRecruteur;
    }

    public String getStatutEntretien() {
        return statutEntretien;
    }

    public int getCandidatureId() {
        return candidatureId;
    }

    public String getNom() { return nom; }
    public String getPrenom() { return prenom; }
    public String getTitreAnnonce() { return titreAnnonce; }

    public void setId(int id) {
        this.id = id;
    }

    public void setDateHeure(Date dateHeure) {
        this.dateHeure = dateHeure;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public void setNotesRecruteur(String notesRecruteur) {
        this.notesRecruteur = notesRecruteur;
    }

    public void setStatutEntretien(String statutEntretien) {
        this.statutEntretien = statutEntretien;
    }

    public void setCandidatureId(int candidatureId) {
        this.candidatureId = candidatureId;
    }

    public void setNom(String nom) { this.nom = nom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public void setTitreAnnonce(String titreAnnonce) { this.titreAnnonce = titreAnnonce; }
}
