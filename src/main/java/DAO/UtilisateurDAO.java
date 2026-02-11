package DAO;

import Models.utilisateur;

public interface UtilisateurDAO {

    public void create(utilisateur u);

    public static void update(utilisateur u) throws Exception {}

    public java.util.List<utilisateur> findAllUsers() throws Exception;

    public int countByRole(String role) throws Exception;

    public java.util.List<utilisateur> findPendingEntities() throws Exception;

    public void updateStatus(int id, String newStatus) throws Exception;

    public utilisateur login(String email, String password) throws Exception;

}
