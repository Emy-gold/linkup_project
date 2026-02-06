package DAO;

import Models.Annonce;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnonceDAOImpl implements AnnonceDAO {

    @Override
    public void create(Annonce a) {
        String sql = "INSERT INTO annonce (id_recruteur, titre, description, type_contrat, statut_annonce, date_publication) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, a.getRecruteurId());
            stmt.setString(2, a.getTitre());
            stmt.setString(3, a.getDescriptionPoste());
            stmt.setString(4, a.getTypeContrat());
            stmt.setString(5, a.getStatutAnnonce());
            stmt.setDate(6, new java.sql.Date(a.getDatePublication().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Annonce getById(int id) {
        String sql = "SELECT * FROM annonce WHERE id_annonce = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Annonce> getAll() {
        List<Annonce> list = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE statut_annonce = 'ACTIVE' ORDER BY date_publication DESC";
        try (Connection conn = ConnexionDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void update(Annonce a) {
        String sql = "UPDATE annonce SET titre = ?, description = ?, type_contrat = ?, statut_annonce = ? WHERE id_annonce = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getTitre());
            stmt.setString(2, a.getDescriptionPoste());
            stmt.setString(3, a.getTypeContrat());
            stmt.setString(4, a.getStatutAnnonce());
            stmt.setInt(5, a.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM annonce WHERE id_annonce = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Annonce> getByRecruteurId(int recruteurId) {
        List<Annonce> list = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE id_recruteur = ? ORDER BY date_publication DESC";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, recruteurId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Annonce> search(String keyword) {
        List<Annonce> list = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE (titre LIKE ? OR description LIKE ?) AND statut_annonce = 'Publiée'";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Annonce> getByTypeContrat(String typeContrat) {
        List<Annonce> list = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE type_contrat = ? AND statut_annonce = 'Publiée'";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, typeContrat);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Annonce> getRecent(int limit) {
        List<Annonce> list = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE statut_annonce = 'Publiée' ORDER BY date_publication DESC LIMIT ?";
        try(Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Annonce extractFromResultSet(ResultSet rs) throws SQLException {
        Annonce a = new Annonce();
        a.setId(rs.getInt("id_annonce"));
        a.setRecruteurId(rs.getInt("id_recruteur"));
        a.setTitre(rs.getString("titre"));
        a.setDescriptionPoste(rs.getString("description"));
        a.setTypeContrat(rs.getString("type_contrat"));
        a.setStatutAnnonce(rs.getString("statut_annonce"));
        a.setDatePublication(rs.getDate("date_publication"));
        return a;
    }
}