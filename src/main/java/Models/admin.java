package Models;

import java.util.Date;

public class admin extends utilisateur{


    public admin(int idUtilisateur, String email, String nom, String prenom, Date date, String statutCompte) {
        super(idUtilisateur, email, nom, prenom, date, statutCompte);
    }
}
