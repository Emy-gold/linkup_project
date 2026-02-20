package Models;

import java.util.Date;

public class Universite extends utilisateur {
    private String nomUniversite;
    private String adresse;
    private String telephone;
    private String emailContact;


    public Universite() {
    }

    public Universite(int idUtilisateur, String email, String nom, String prenom, String password, Date date, String statutCompte, String nomUniversite, String adresse, String telephone, String emailContact, String role) {
        super(idUtilisateur, email, nom, prenom, password, date, statutCompte, role);
        this.nomUniversite = nomUniversite;
        this.adresse = adresse;
        this.telephone = telephone;
        this.emailContact = emailContact;
    }

    // AJOUTER CE GETTER
    public int getId_universite() {
        return super.getIdUtilisateur();
    }

    public String getNomUniversite() {
        return nomUniversite;
    }

    public void setNomUniversite(String nomUniversite) {
        this.nomUniversite = nomUniversite;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getTelephone() {
        return telephone;
    }

    public String getEmailContact() {
        return emailContact;
    }

    public void setEmailContact(String emailContact) {
        this.emailContact = emailContact;
    }

}