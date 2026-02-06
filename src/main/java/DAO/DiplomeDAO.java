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

    public List<Diplome> getDiplomesEnAttente(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE id_universite = ? AND statut_validation = 'EN_ATTENTE' ORDER BY id_diplome DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                diplomes.add(creerDiplome(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    public List<Diplome> getDiplomesHistorique(int idUniversite) {
        List<Diplome> diplomes = new ArrayList<>();
        String sql = "SELECT * FROM diplome WHERE id_universite = ? AND statut_validation IN ('VALIDÉ', 'REJETÉ') ORDER BY date_traitement DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUniversite);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                diplomes.add(creerDiplome(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diplomes;
    }

    private Diplome creerDiplome(ResultSet rs) throws SQLException {
        Diplome diplome = new Diplome();
        diplome.setId_diplome(rs.getInt("id_diplome"));
        diplome.setId_candidat(rs.getInt("id_candidat"));
        diplome.setId_universite(rs.getInt("id_universite"));
        diplome.setLibelle(rs.getString("libelle"));
        diplome.setDocument_justificatif(rs.getString("document_justificatif"));
        diplome.setStatut_validation(rs.getString("statut_validation"));
        diplome.setDate_traitement(rs.getString("date_traitement"));
        return diplome;
    }

    public boolean validerDiplome(int idDiplome) {
        String sql = "UPDATE diplome SET statut_validation = 'VALIDÉ', date_traitement = NOW() WHERE id_diplome = ?";
        return executerUpdate(sql, idDiplome);
    }

    public boolean rejeterDiplome(int idDiplome) {
        String sql = "UPDATE diplome SET statut_validation = 'REJETÉ', date_traitement = NOW() WHERE id_diplome = ?";
        return executerUpdate(sql, idDiplome);
    }

    private boolean executerUpdate(String sql, int idDiplome) {
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idDiplome);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}