package Models;

import java.util.Date;

public class universite extends utilisateur{

    private String nomUniversite;
    private  String adresse;
    private  String telephone;
    private String emailContact;

    public universite() {
    }

    public universite(int idUtilisateur, String email, String nom, String prenom, Date date, String statutCompte, String nomUniversite, String adresse,String telephone, String emailContact) {
        super(idUtilisateur, email, nom, prenom, date, statutCompte);
        this.nomUniversite = nomUniversite;
        this.adresse = adresse;
        this.telephone = telephone;
        this.emailContact = emailContact;
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
