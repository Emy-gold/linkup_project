package Models;

import java.security.SecureRandom;
import java.util.Date;

public class utilisateur {

    protected int idUtilisateur;
    protected String email;
    protected String nom;
    protected String prenom;
    protected String role;
    protected String password;
    protected Date date;
    protected String statutCompte;

    public utilisateur(){}

    public utilisateur(int idUtilisateur, String email, String nom, String prenom,String password,  Date date, String statutCompte, String role) {
        this.idUtilisateur = idUtilisateur;
        this.email = email;
        this.nom = nom;
        this.prenom = prenom;
        this.role = role;
        this.password = password;
        this.date = date;
        this.statutCompte = statutCompte;
    }

    public utilisateur(String email,String password, String nom, String prenom, String role, Date date, String statutCompte) {
        this.email = email;
        this.nom = nom;
        this.prenom = prenom;
        this.role = role;
        this.password = password;
        this.date = date;
        this.statutCompte = statutCompte;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {return password;}

    public void setPassword(String password) {this.password = password;}

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatutCompte() {
        return statutCompte;
    }

    public void setStatutCompte(String statutCompte) {
        this.statutCompte = statutCompte;
    }
}
