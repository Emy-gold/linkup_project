package DAO;

import Models.Diplome;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiplomeDAOImpl implements diplomeDAO {

    @Override
    public void create(Diplome d) {
        String sql = "INSERT INTO diplome (id_candidat, libelle, document_justificatif, statut_validation) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, d.getId_candidat());
            stmt.setString(2, d.getLibelle());
            stmt.setString(3, d.getDocument_justificatif());
            stmt.setString(4, d.getStatut_validation());
            int rows = stmt.executeUpdate();
            System.out.println("Diplome inserted: " + rows + " row(s)");
        } catch (SQLException e) {
            System.out.println("❌ Error creating diplome: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public Diplome getById(int id) {
        String sql = "SELECT * FROM diplome WHERE id_diplome = ?";
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
    public List<Diplome> getAll() {
        List<Diplome> list = new ArrayList<>();
        String sql = "SELECT * FROM diplome";
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
    public void update(Diplome d) {
        String sql = "UPDATE diplome SET libelle = ?, document_justificatif = ?, statut_validation = ? WHERE id_diplome = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, d.getLibelle());
            stmt.setString(2, d.getDocument_justificatif());
            stmt.setString(3, d.getStatut_validation());
            stmt.setInt(4, d.getId_diplome());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM diplome WHERE id_diplome = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Diplome> getByCandidatId(int candidatId) {
        List<Diplome> list = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE id_candidat = ?";
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
    public List<Diplome> getByStatutValidation(String statut) {
        List<Diplome> list = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE statut_validation = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, statut);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(extractFromResultSet(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCandidatId(int candidatId) {
        String sql = "SELECT COUNT(*) FROM diplome WHERE id_candidat = ?";
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

    // Méthodes additionnelles pour agent universitaire
    public List<Diplome> getDiplomesEnAttente(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE id_universite = ? AND statut_validation = 'En attente' ORDER BY id_diplome DESC";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                diplomes.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    public List<Diplome> getDiplomesHistorique(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE id_universite = ? AND statut_validation IN ('Validé', 'Rejeté') ORDER BY id_diplome DESC";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                diplomes.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    public boolean validerDiplome(int idDiplome) {
        String sql = "UPDATE diplome SET statut_validation = 'Validé' WHERE id_diplome = ?";
        return executerUpdate(sql, idDiplome);
    }

    public boolean rejeterDiplome(int idDiplome) {
        String sql = "UPDATE diplome SET statut_validation = 'Rejeté' WHERE id_diplome = ?";
        return executerUpdate(sql, idDiplome);
    }

    private boolean executerUpdate(String sql, int idDiplome) {
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idDiplome);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Diplome extractFromResultSet(ResultSet rs) throws SQLException {
        Diplome d = new Diplome();
        d.setId_diplome(rs.getInt("id_diplome"));
        d.setId_candidat(rs.getInt("id_candidat"));
        d.setLibelle(rs.getString("libelle"));
        d.setDocument_justificatif(rs.getString("document_justificatif"));
        d.setStatut_validation(rs.getString("statut_validation"));
        return d;
    }
}