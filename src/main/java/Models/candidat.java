package Models;

import java.util.Date;

public class candidat extends utilisateur{

    private String titreProfil;
    private String disponibilite;

    public candidat(){}

    public candidat(int idUtilisateur, String email, String nom, String prenom, Date date, String statutCompte, String titreProfil , String disponibilite) {
        super(idUtilisateur, email, nom, prenom, date, statutCompte);
        this.titreProfil = titreProfil;
        this.disponibilite = disponibilite;
    }

    public String getTitreProfil() {
        return titreProfil;
    }

    public void setTitreProfil(String titreProfil) {
        this.titreProfil = titreProfil;
    }

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
    }
}
