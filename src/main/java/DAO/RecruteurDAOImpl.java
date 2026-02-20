package DAO;

import Models.Recruteur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecruteurDAOImpl implements RecruteurDAO {

    private Connection conn;

    public RecruteurDAOImpl() {
        conn = ConnexionDB.getConnection();
    }

    // ================= CREATE =================
    @Override
    public void create(Recruteur r) throws SQLException {
        // Schema: id_recruteur (PK, FK), nom_entreprise, secteur_activite,
        // description_entreprise, logo, poste_occupe
        String sql = "INSERT INTO recruteur (id_recruteur, nom_entreprise, secteur_activite, description_entreprise, logo, poste_occupe) VALUES (?, ?, ?, ?, ?, ?)";
        System.out.println(">>> DEBUG : RecruteurDAOImpl - Tentative d'insertion pour id_recruteur=" + r.getUserId());

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, r.getUserId()); // id_recruteur is the FK to utilisateur.id_utilisateur
            stmt.setString(2, r.getNomEntreprise());
            stmt.setString(3, r.getSecteurActivite());
            stmt.setString(4, r.getDescriptionEntreprise());
            stmt.setString(5, r.getLogo());
            stmt.setString(6, r.getPosteOccupe());

            int rows = stmt.executeUpdate();
            System.out.println(">>> DEBUG : RecruteurDAOImpl - Insertion réussie, lignes impactées : " + rows);

        } catch (SQLException e) {
            System.err.println(">>> ERROR : RecruteurDAOImpl - Erreur SQL lors de la création : " + e.getMessage());
            throw e;
        }
    }

    // ================= UPDATE =================
    @Override
    public void update(Recruteur r) {
        String sql = "UPDATE recruteur SET nom_entreprise=?, secteur_activite=?, description_entreprise=?, poste_occupe=?, logo=? WHERE user_id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, r.getUserId());
            stmt.setString(2, r.getNomEntreprise());
            stmt.setString(3, r.getSecteurActivite());
            stmt.setString(4, r.getDescriptionEntreprise());
            stmt.setString(5, r.getLogo());
            stmt.setString(6, r.getPosteOccupe());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================= DELETE =================
    @Override
    public void delete(int id) {
        String sql = "DELETE FROM recruteur WHERE id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================= GET ALL =================
    @Override
    public List<Recruteur> getAll() {
        List<Recruteur> list = new ArrayList<>();
        String sql = "SELECT * FROM recruteur";

        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Appel de la méthode helper pour remplir l'objet
                list.add(extractFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    private Recruteur extractFromResultSet(ResultSet rs) throws SQLException {
        Recruteur r = new Recruteur();

        r.setRecruteurId(rs.getInt("id_recruteur"));
        r.setUserId(rs.getInt("id_recruteur")); // In this schema, id_recruteur IS the user_id FK
        r.setNomEntreprise(rs.getString("nom_entreprise"));
        r.setSecteurActivite(rs.getString("secteur_activite"));
        r.setDescriptionEntreprise(rs.getString("description_entreprise"));
        r.setLogo(rs.getString("logo"));
        r.setPosteOccupe(rs.getString("poste_occupe"));

        return r;
    }

    // ================= GET BY ID =================
    @Override
    public Recruteur getById(int id) {

        String sql = "SELECT * FROM recruteur WHERE id_recruteur = ?";

        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            // Vérifier si un résultat a été trouvé
            if (rs.next()) {
                // Utiliser la méthode helper pour créer l'objet
                return extractFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= GET BY USER ID =================
    @Override
    public Recruteur getByUserId(int userId) {

        String sql = "SELECT * FROM recruteur WHERE id_recruteur=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= EXISTS BY USER ID =================
    @Override
    public boolean existsByUserId(int userId) {

        String sql = "SELECT COUNT(*) FROM recruteur WHERE id_recruteur=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

}
