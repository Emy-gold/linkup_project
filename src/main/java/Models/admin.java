package Models;

import java.util.Date;

public class admin extends utilisateur{


    public admin(int idUtilisateur, String email, String nom, String prenom,String password, Date date, String statutCompte,String role) {
        super(idUtilisateur, email, nom, prenom,password, date, statutCompte,role);
    }
}
