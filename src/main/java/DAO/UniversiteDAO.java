package DAO;

import Models.Universite;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UniversiteDAO {
    private Connection connection;

    public UniversiteDAO() {
        this.connection = ConnexionDB.getConnection();
    }

    public List<Universite> getAllUniversites() {
        List<Universite> universites = new ArrayList<>();
        String sql = "SELECT u.*, univ.nom_universite, univ.adresse, univ.telephone, univ.email_contact, univ.password as univ_password " +
                "FROM utilisateur u " +
                "JOIN universite univ ON u.id_utilisateur = univ.id_universite " +
                "WHERE u.role = 'AGENT_UNIV' " +
                "ORDER BY univ.nom_universite";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Universite universite = new Universite();
                universite.setIdUtilisateur(rs.getInt("id_utilisateur"));
                universite.setEmail(rs.getString("email"));
                universite.setNom(rs.getString("nom"));
                universite.setPrenom(rs.getString("prenom"));
                universite.setPassword(rs.getString("password")); // Mot de passe utilisateur
                universite.setDate(rs.getDate("date_inscription"));
                universite.setStatutCompte(rs.getString("statut_compte"));
                universite.setRole(rs.getString("role"));
                universite.setNomUniversite(rs.getString("nom_universite"));
                universite.setAdresse(rs.getString("adresse"));
                universite.setTelephone(rs.getString("telephone"));
                universite.setEmailContact(rs.getString("email_contact"));
                universite.setUniversityPassword(rs.getString("univ_password")); // Mot de passe université

                universites.add(universite);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return universites;
    }

    public Universite getUniversiteById(int idUniversite) {
        String sql = "SELECT u.*, univ.nom_universite, univ.adresse, univ.telephone, univ.email_contact, univ.password as univ_password " +
                "FROM utilisateur u " +
                "JOIN universite univ ON u.id_utilisateur = univ.id_universite " +
                "WHERE u.id_utilisateur = ? AND u.role = 'AGENT_UNIV'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Universite universite = new Universite();
                universite.setIdUtilisateur(rs.getInt("id_utilisateur"));
                universite.setEmail(rs.getString("email"));
                universite.setNom(rs.getString("nom"));
                universite.setPrenom(rs.getString("prenom"));
                universite.setPassword(rs.getString("password"));
                universite.setDate(rs.getDate("date_inscription"));
                universite.setStatutCompte(rs.getString("statut_compte"));
                universite.setRole(rs.getString("role"));
                universite.setNomUniversite(rs.getString("nom_universite"));
                universite.setAdresse(rs.getString("adresse"));
                universite.setTelephone(rs.getString("telephone"));
                universite.setEmailContact(rs.getString("email_contact"));
                universite.setUniversityPassword(rs.getString("univ_password")); // Mot de passe université

                return universite;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}