package DAO;

import Models.Entretien;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EntretienDAOImpl implements EntretienDAO {

    @Override
    public void create(Entretien e) {
        String sql = "INSERT INTO entretien (id_candidature, date_heure, lieu, statut_entretien, notes_recruteur) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, e.getCandidatureId());
            stmt.setTimestamp(2, new Timestamp(e.getDateHeure().getTime()));
            stmt.setString(3, e.getLieu());
            stmt.setString(4, e.getStatutEntretien());
            stmt.setString(5, e.getNotesRecruteur());
            int rows = stmt.executeUpdate();
            System.out.println("Entretien inserted: " + rows + " row(s)");
        } catch (SQLException ex) {
            System.out.println("❌ Error creating entretien: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    @Override
    public Entretien getById(int id) {
        String sql = "SELECT * FROM entretien WHERE id_entretien = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return extractFromResultSet(rs);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Entretien> getAll() {
        List<Entretien> list = new ArrayList<>();
        String sql = "SELECT * FROM entretien ORDER BY date_heure DESC";
        try (Connection conn = ConnexionDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @Override
    public void update(Entretien e) {
        String sql = "UPDATE entretien SET date_heure = ?, lieu = ?, statut_entretien = ?, notes_recruteur = ? WHERE id_entretien = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, new Timestamp(e.getDateHeure().getTime()));
            stmt.setString(2, e.getLieu());
            stmt.setString(3, e.getStatutEntretien());
            stmt.setString(4, e.getNotesRecruteur());
            stmt.setInt(5, e.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM entretien WHERE id_entretien = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<Entretien> getByCandidatId(int candidatId) {
        List<Entretien> list = new ArrayList<>();
        String sql = "SELECT e.* FROM entretien e " +
                "JOIN candidature c ON e.id_candidature = c.id_candidature " +
                "WHERE c.id_candidat = ? ORDER BY e.date_heure DESC";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Entretien> getUpcomingByCandidatId(int candidatId, int limit) {
        List<Entretien> list = new ArrayList<>();
        String sql = "SELECT e.* FROM entretien e " +
                "JOIN candidature c ON e.id_candidature = c.id_candidature " +
                "WHERE c.id_candidat = ? AND e.date_heure >= NOW() " +
                "ORDER BY e.date_heure ASC LIMIT ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCandidatId(int candidatId) {
        String sql = "SELECT COUNT(*) FROM entretien e " +
                "JOIN candidature c ON e.id_candidature = c.id_candidature " +
                "WHERE c.id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    private Entretien extractFromResultSet(ResultSet rs) throws SQLException {
        Entretien e = new Entretien();
        e.setId(rs.getInt("id_entretien"));
        e.setCandidatureId(rs.getInt("id_candidature"));
        e.setDateHeure(rs.getTimestamp("date_heure"));
        e.setLieu(rs.getString("lieu"));
        e.setStatutEntretien(rs.getString("statut_entretien"));
        e.setNotesRecruteur(rs.getString("notes_recruteur"));
        return e;
    }
}