package DAO;

import Models.Cv;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CVDAOImpl implements CVDAO {
    @Override
    public void create(Cv c) {
        String sql = "INSERT INTO cv (id_candidat, titre_cv, chemin_fichier, date_mise_a_jour, competences) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, c.getCandidatId());
            stmt.setString(2, c.getTitre());
            stmt.setString(3, c.getCheminFichier());
            stmt.setDate(4, new java.sql.Date(c.getDateMiseAJour().getTime()));
            stmt.setString(5, c.getCompetences());

            int rows = stmt.executeUpdate();
            if(rows == 0) {
                System.out.println("CV not saved - 0 rows affected");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Cv getById(int id) {
        String sql = "SELECT * FROM cv WHERE id_cv = ?";
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
    public List<Cv> getAll() {
        List<Cv> list = new ArrayList<>();
        String sql = "SELECT * FROM cv";
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
    public void update(Cv c) {
        String sql = "UPDATE cv SET titre_cv = ?, chemin_fichier = ?, date_mise_a_jour = ?, competences = ? WHERE id_cv = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getTitre());
            stmt.setString(2, c.getCheminFichier());
            stmt.setDate(3, new java.sql.Date(c.getDateMiseAJour().getTime()));
            stmt.setString(4, c.getCompetences());
            stmt.setInt(5, c.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM cv WHERE id_cv = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Cv> getByCandidatId(int candidatId) {
        List<Cv> list = new ArrayList<>();
        String sql = "SELECT * FROM cv WHERE id_candidat = ? ORDER BY date_mise_a_jour DESC";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCandidatId(int candidatId) {
        String sql = "SELECT COUNT(*) FROM cv WHERE id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Cv extractFromResultSet(ResultSet rs) throws SQLException {
        Cv c = new Cv();
        c.setId(rs.getInt("id_cv"));
        c.setCandidatId(rs.getInt("id_candidat"));
        c.setTitre(rs.getString("titre_cv"));
        c.setCheminFichier(rs.getString("chemin_fichier"));
        c.setDateMiseAJour(rs.getDate("date_mise_a_jour"));
        c.setCompetences(rs.getString("competences"));
        return c;
    }
}