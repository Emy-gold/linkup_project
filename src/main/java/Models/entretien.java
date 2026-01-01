package Models;

public class entretien {

    private int id;
    private String dateHeure;
    private String lieu;
    private String statutEntretien;
    private String notesRecruteur;

    public entretien(){

    }

    public entretien(int id, String dateHeure, String lieu, String statutEntretien, String notesRecruteur) {
        this.id = id;
        this.dateHeure = dateHeure;
        this.lieu = lieu;
        this.statutEntretien = statutEntretien;
        this.notesRecruteur = notesRecruteur;
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
}
