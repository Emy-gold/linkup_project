package DAO;

import Models.Annonce;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnnonceDaoIMP implements AnnonceDAO {

    @Override
    public void create(Annonce a) {
        String sql = "INSERT INTO annonce (titre, description, type_contrat, statut_annonce, date_publication, id_recruteur) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getTitre());
            stmt.setString(2, a.getDescription());
            stmt.setString(3, a.getTypeContrat());
            stmt.setString(4, a.getStatutAnnonce());
            stmt.setDate(5, new java.sql.Date(a.getDatePublication().getTime()));
            stmt.setInt(6, a.getId_recruteur());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Annonce a) {
        String sql = "UPDATE annonce SET statut_annonce = ? WHERE id_annonce = ?";
        try {
            Connection cn = ConnexionDB.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, a.getStatutAnnonce());
            ps.setInt(2, a.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int countByRecruteurId(int recruteurId) {
        String sql = "SELECT COUNT(*) FROM annonce WHERE id_recruteur = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, recruteurId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void delete(int id) {
        // TODO: Implement
    }

    @Override
    public List<Annonce> getAll() {
        List<Annonce> annonces = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE statut_annonce = 'PUBLIEE'";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Annonce a = new Annonce();
                a.setId(rs.getInt("id_annonce"));
                a.setTitre(rs.getString("titre"));
                a.setDescription(rs.getString("description"));
                a.setTypeContrat(rs.getString("type_contrat"));
                a.setStatutAnnonce(rs.getString("statut_annonce"));
                a.setDatePublication(rs.getDate("date_publication"));
                a.setId_recruteur(rs.getInt("id_recruteur"));
                annonces.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annonces;
    }

    @Override
    public Annonce getById(int id) {
        Annonce a = null;
        String sql = "SELECT * FROM annonce WHERE id_annonce = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    a = new Annonce();
                    a.setId(rs.getInt("id_annonce"));
                    a.setTitre(rs.getString("titre"));
                    a.setDescription(rs.getString("description"));
                    a.setTypeContrat(rs.getString("type_contrat"));
                    a.setStatutAnnonce(rs.getString("statut_annonce"));
                    a.setDatePublication(rs.getDate("date_publication"));
                    a.setId_recruteur(rs.getInt("id_recruteur"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    @Override
    public List<Annonce> getByRecruteurId(int recruteurId) {
        List<Annonce> annonces = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE id_recruteur = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, recruteurId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Annonce a = new Annonce();
                    a.setId(rs.getInt("id_annonce"));
                    a.setTitre(rs.getString("titre"));
                    a.setDescription(rs.getString("description"));
                    a.setTypeContrat(rs.getString("type_contrat"));
                    a.setStatutAnnonce(rs.getString("statut_annonce"));
                    a.setDatePublication(rs.getDate("date_publication"));
                    a.setId_recruteur(rs.getInt("id_recruteur"));
                    annonces.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annonces;
    }

    @Override
    public List<Annonce> getByTypeContrat(String typeContrat) {
        List<Annonce> annonces = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE type_contrat = ? AND statut_annonce = 'PUBLIEE'";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, typeContrat);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Annonce a = new Annonce();
                    a.setId(rs.getInt("id_annonce"));
                    a.setTitre(rs.getString("titre"));
                    a.setDescription(rs.getString("description"));
                    a.setTypeContrat(rs.getString("type_contrat"));
                    a.setStatutAnnonce(rs.getString("statut_annonce"));
                    a.setDatePublication(rs.getDate("date_publication"));
                    a.setId_recruteur(rs.getInt("id_recruteur"));
                    annonces.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annonces;
    }

    @Override
    public List<Annonce> search(String keyword) {
        List<Annonce> annonces = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE (titre LIKE ? OR description LIKE ?) AND statut_annonce = 'PUBLIEE'";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Annonce a = new Annonce();
                    a.setId(rs.getInt("id_annonce"));
                    a.setTitre(rs.getString("titre"));
                    a.setDescription(rs.getString("description"));
                    a.setTypeContrat(rs.getString("type_contrat"));
                    a.setStatutAnnonce(rs.getString("statut_annonce"));
                    a.setDatePublication(rs.getDate("date_publication"));
                    a.setId_recruteur(rs.getInt("id_recruteur"));
                    annonces.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annonces;
    }

    @Override
    public List<Annonce> getRecent(int limit) {
        List<Annonce> annonces = new ArrayList<>();
        String sql = "SELECT * FROM annonce WHERE statut_annonce = 'PUBLIEE' ORDER BY date_publication DESC LIMIT ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Annonce a = new Annonce();
                    a.setId(rs.getInt("id_annonce"));
                    a.setTitre(rs.getString("titre"));
                    a.setDescription(rs.getString("description"));
                    a.setTypeContrat(rs.getString("type_contrat"));
                    a.setStatutAnnonce(rs.getString("statut_annonce"));
                    a.setDatePublication(rs.getDate("date_publication"));
                    a.setId_recruteur(rs.getInt("id_recruteur"));
                    annonces.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annonces;
    }

    @Override
    public int countPending() throws Exception {
        String sql = "SELECT COUNT(*) FROM annonce WHERE statut_annonce = 'EN_ATTENTE'";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    @Override
    public java.util.List<java.util.Map<String, Object>> findAllWithCompany() throws Exception {
        java.util.List<java.util.Map<String, Object>> ads = new java.util.ArrayList<>();
        String sql = "SELECT a.*, u.nom as entreprise FROM annonce a LEFT JOIN utilisateur u ON a.id_recruteur = u.id_utilisateur";
        Connection cn = ConnexionDB.getConnection();
        PreparedStatement ps = cn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            java.util.Map<String, Object> adData = new java.util.HashMap<>();
            adData.put("id", rs.getInt("id_annonce"));
            adData.put("titre", rs.getString("titre"));
            adData.put("description", rs.getString("description"));
            adData.put("type_contrat", rs.getString("type_contrat"));
            adData.put("statut_annonce", rs.getString("statut_annonce"));
            adData.put("date_publication", rs.getDate("date_publication"));

            String ent = rs.getString("entreprise");
            adData.put("entreprise", (ent != null ? ent : "Entreprise Inconnue"));

            ads.add(adData);
        }
        return ads;
    }

    @Override
    public void toggleBlockStatus(int idAnnonce, boolean block) throws Exception {
        String status = block ? "BLOQUÉE" : "PUBLIÉE";
        String sql = "UPDATE annonce SET statut_annonce = ? WHERE id_annonce = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, idAnnonce);
            stmt.executeUpdate();
        }
    }

    @Override
    public void blockAllAdsByRecruteur(int recruteurId) throws Exception {
        String sql = "UPDATE annonce SET statut_annonce = 'BLOQUÉE' WHERE id_recruteur = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, recruteurId);
            stmt.executeUpdate();
        }
    }

    @Override
    public int countTotal() throws Exception {
        String sql = "SELECT COUNT(*) FROM annonce";
        try (Connection cn = ConnexionDB.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
