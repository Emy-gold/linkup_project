package Models;

public class Entretien {

    private int id;
    private String dateHeure;
    private String lieu;
    private String statutEntretien;
    private String notesRecruteur;

    //foreign keys
    private int candidatureId;


    public Entretien(){

    }

    public Entretien(int id, String dateHeure, String lieu, String statutEntretien, String notesRecruteur,int candidatureId) {
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

    public String getDateHeure() {
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

    public void setId(int id) {
        this.id = id;
    }

    public void setDateHeure(String dateHeure) {
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
}
