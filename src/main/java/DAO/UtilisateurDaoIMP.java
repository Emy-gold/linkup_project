package DAO;

import Models.utilisateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UtilisateurDaoIMP implements UtilisateurDAO {

    public static void create(utilisateur u) throws Exception {

        String sql = "INSERT INTO utilisateur " +
                "(email,password,nom,prenom,role,date_inscription,statut_compte) "
                + "VALUES(?,?,?,?,?,?,?)";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);

        ps.setString(1, u.getEmail());
        ps.setString(2, u.getPassword());
        ps.setString(3, u.getNom());
        ps.setString(4, u.getPrenom());
        ps.setString(5, u.getRole());
        ps.setDate(6, new java.sql.Date(u.getDate().getTime()));
        ps.setString(7, u.getStatutCompte());

        ps.executeUpdate();
    }

    public utilisateur login(String email, String password) throws Exception {

        String sql = "SELECT * FROM utilisateur WHERE email=? AND password=?";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);

        ps.setString(1, email); // ← ADD THIS
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            utilisateur u = new utilisateur();
            u.setIdUtilisateur(rs.getInt("id_utilisateur"));
            u.setEmail(rs.getString("email"));
            u.setNom(rs.getString("nom"));
            u.setPrenom(rs.getString("prenom"));
            u.setRole(rs.getString("role"));
            u.setStatutCompte(rs.getString("statut_compte"));
            return u;
        }
        return null;
    }

    @Override
    public java.util.List<utilisateur> findAllUsers() throws Exception {
        java.util.List<utilisateur> users = new java.util.ArrayList<>();
        String sql = "SELECT * FROM utilisateur";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            utilisateur u = new utilisateur();
            u.setIdUtilisateur(rs.getInt("id_utilisateur"));
            u.setEmail(rs.getString("email"));
            u.setNom(rs.getString("nom"));
            u.setPrenom(rs.getString("prenom"));
            u.setRole(rs.getString("role"));
            u.setStatutCompte(rs.getString("statut_compte"));
            u.setDate(rs.getDate("date_inscription"));
            users.add(u);
        }
        return users;
    }

    @Override
    public int countByRole(String role) throws Exception {
        String sql = "SELECT COUNT(*) FROM utilisateur WHERE role = ?";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ps.setString(1, role);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    @Override
    public java.util.List<utilisateur> findPendingEntities() throws Exception {
        java.util.List<utilisateur> users = new java.util.ArrayList<>();
        String sql = "SELECT * FROM utilisateur WHERE (role = 'RECRUTEUR' OR role = 'AGENT_UNIV') AND statut_compte = 'EN_ATTENTE'";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            utilisateur u = new utilisateur();
            u.setIdUtilisateur(rs.getInt("id_utilisateur"));
            u.setEmail(rs.getString("email"));
            u.setNom(rs.getString("nom"));
            u.setPrenom(rs.getString("prenom"));
            u.setRole(rs.getString("role"));
            u.setStatutCompte(rs.getString("statut_compte"));
            u.setDate(rs.getDate("date_inscription"));
            users.add(u);
        }
        return users;
    }

    @Override
    public void updateStatus(int id, String newStatus) throws Exception {
        String sql = "UPDATE utilisateur SET statut_compte = ? WHERE id_utilisateur = ?";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ps.setString(1, newStatus);
        ps.setInt(2, id);
        ps.executeUpdate();
    }
}
