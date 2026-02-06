package DAO;

import Models.Diplome;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiplomeDAO {
    private Connection connection;

    public DiplomeDAO() {
        this.connection = ConnexionDB.getConnection();
    }

    // Récupérer tous les diplômes d'une université
    public List<Diplome> getDiplomesByUniversite(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplomes WHERE id_universite = ? ORDER BY id_diplome DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Diplome diplome = new Diplome();
                diplome.setId_diplome(rs.getInt("id_diplome"));
                diplome.setId_candidat(rs.getInt("id_candidat"));
                diplome.setLibelle(rs.getString("libelle"));
                diplome.setDocument_justificatif(rs.getString("document_justificatif"));
                diplome.setStatut_validation(rs.getString("statut_validation"));
                diplome.setDate_traitement(rs.getString("date_traitement"));
                diplome.setId_universite(rs.getInt("id_universite"));
                diplomes.add(diplome);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    // Récupérer les diplômes en attente
    public List<Diplome> getDiplomesEnAttente(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplomes WHERE id_universite = ? AND (statut_validation = 'EN_ATTENTE' OR statut_validation IS NULL) ORDER BY id_diplome DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Diplome diplome = new Diplome();
                diplome.setId_diplome(rs.getInt("id_diplome"));
                diplome.setId_candidat(rs.getInt("id_candidat"));
                diplome.setLibelle(rs.getString("libelle"));
                diplome.setDocument_justificatif(rs.getString("document_justificatif"));
                diplome.setStatut_validation(rs.getString("statut_validation"));
                diplome.setDate_traitement(rs.getString("date_traitement"));
                diplome.setId_universite(rs.getInt("id_universite"));
                diplomes.add(diplome);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    // Récupérer l'historique des diplômes traités
    public List<Diplome> getDiplomesHistorique(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplomes WHERE id_universite = ? AND statut_validation IN ('VALIDÉ', 'REJETÉ') ORDER BY id_diplome DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Diplome diplome = new Diplome();
                diplome.setId_diplome(rs.getInt("id_diplome"));
                diplome.setId_candidat(rs.getInt("id_candidat"));
                diplome.setLibelle(rs.getString("libelle"));
                diplome.setDocument_justificatif(rs.getString("document_justificatif"));
                diplome.setStatut_validation(rs.getString("statut_validation"));
                diplome.setDate_traitement(rs.getString("date_traitement"));
                diplome.setId_universite(rs.getInt("id_universite"));
                diplomes.add(diplome);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    // Valider un diplôme
    public boolean validerDiplome(int idDiplome) {
        String sql = "UPDATE diplomes SET statut_validation = 'VALIDÉ', date_traitement = NOW() WHERE id_diplome = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idDiplome);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Rejeter un diplôme
    public boolean rejeterDiplome(int idDiplome) {
        String sql = "UPDATE diplomes SET statut_validation = 'REJETÉ', date_traitement = NOW() WHERE id_diplome = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idDiplome);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Ajouter un nouveau diplôme
    public boolean ajouterDiplome(Diplome diplome) {
        String sql = "INSERT INTO diplomes (id_candidat, libelle, document_justificatif, statut_validation, id_universite) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, diplome.getId_candidat());
            stmt.setString(2, diplome.getLibelle());
            stmt.setString(3, diplome.getDocument_justificatif());
            stmt.setString(4, diplome.getStatut_validation());
            stmt.setInt(5, diplome.getId_universite());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}