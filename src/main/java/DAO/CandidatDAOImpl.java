package DAO;

import Models.Candidat;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatDAOImpl implements CandidatDAO {

    @Override
    public void create(Candidat c) {
        String sql = "INSERT INTO candidat (id_candidat, titre_profil, disponibilite) VALUES (?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, c.getIdUtilisateur());
            stmt.setString(2, c.getTitreProfil());
            stmt.setString(3, c.getDisponibilite());
            int rows = stmt.executeUpdate();
            System.out.println("Candidat inserted: " + rows + " row(s)");
        } catch (SQLException e) {
            System.out.println("❌ Error creating candidat: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public Candidat getById(int id) {
        String sql = "SELECT u.*, c.titre_profil, c.disponibilite " +
                "FROM utilisateur u " +
                "JOIN candidat c ON u.id_utilisateur = c.id_candidat " +
                "WHERE c.id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return extractFromResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Candidat> getAll() {
        List<Candidat> list = new ArrayList<>();
        String sql = "SELECT u.*, c.titre_profil, c.disponibilite " +
                "FROM utilisateur u " +
                "JOIN candidat c ON u.id_utilisateur = c.id_candidat";
        try (Connection conn = ConnexionDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void update(Candidat c) {
        String sql = "UPDATE candidat SET titre_profil = ?, disponibilite = ? WHERE id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getTitreProfil());
            stmt.setString(2, c.getDisponibilite());
            stmt.setInt(3, c.getIdUtilisateur());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM candidat WHERE id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Candidat extractFromResultSet(ResultSet rs) throws SQLException {
        Candidat c = new Candidat();
        c.setIdUtilisateur(rs.getInt("id_utilisateur"));
        c.setEmail(rs.getString("email"));
        c.setNom(rs.getString("nom"));
        c.setPrenom(rs.getString("prenom"));
        c.setRole(rs.getString("role"));
        c.setDate(rs.getDate("date_inscription"));
        c.setStatutCompte(rs.getString("statut_compte"));
        c.setTitreProfil(rs.getString("titre_profil"));
        c.setDisponibilite(rs.getString("disponibilite"));
        return c;
    }
}