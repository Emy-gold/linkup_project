package DAO;

import Models.Universite;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UniversiteDAOImpl implements UniversiteDAO {
    private Connection connection;

    public UniversiteDAOImpl() {
        this.connection = ConnexionDB.getConnection();
    }

    @Override
    public List<Universite> getAllUniversites() {
        List<Universite> universites = new ArrayList<>();
        String sql = "SELECT u.*, univ.nom_universite, univ.adresse, univ.telephone, univ.email_contact " +
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
                universite.setPassword(rs.getString("password"));
                universite.setDate(rs.getDate("date_inscription"));
                universite.setStatutCompte(rs.getString("statut_compte"));
                universite.setRole(rs.getString("role"));
                universite.setNomUniversite(rs.getString("nom_universite"));
                universite.setAdresse(rs.getString("adresse"));
                universite.setTelephone(rs.getString("telephone"));
                universite.setEmailContact(rs.getString("email_contact"));

                universites.add(universite);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return universites;
    }

    @Override
    public Universite getUniversiteById(int idUniversite) {
        String sql = "SELECT u.*, univ.nom_universite, univ.adresse, univ.telephone, univ.email_contact " +
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

                return universite;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean createUniversite(Universite univ) {
        String sql = "INSERT INTO universite (id_universite, nom_universite, adresse, telephone, email_contact) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "nom_universite = VALUES(nom_universite), " +
                     "adresse = VALUES(adresse), " +
                     "telephone = VALUES(telephone), " +
                     "email_contact = VALUES(email_contact)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, univ.getIdUtilisateur());
            stmt.setString(2, univ.getNomUniversite());
            stmt.setString(3, univ.getAdresse());
            stmt.setString(4, univ.getTelephone());
            stmt.setString(5, univ.getEmailContact());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Universite getUniversiteByAgentId(int agentId) {
        String sql = "SELECT * FROM universite WHERE id_universite = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, agentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Universite universite = new Universite();
                universite.setIdUtilisateur(rs.getInt("id_universite"));
                universite.setNomUniversite(rs.getString("nom_universite"));
                universite.setAdresse(rs.getString("adresse"));
                universite.setTelephone(rs.getString("telephone"));
                universite.setEmailContact(rs.getString("email_contact"));
                return universite;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
