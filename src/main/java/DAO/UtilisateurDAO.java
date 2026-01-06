package DAO;

import Models.utilisateur;

public interface UtilisateurDAO {

    public static void create(utilisateur u) throws Exception {

    }

    public utilisateur login(String email, String password) throws Exception;

}
