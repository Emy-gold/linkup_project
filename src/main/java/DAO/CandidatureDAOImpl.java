package DAO;

import Models.Candidature;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatureDAOImpl implements CandidatureDAO {

    // la methode create pour ajouter une candidature
    @Override
    public void create(Candidature c) {
        String sql = "INSERT INTO candidature(id_candidat,id_annonce,date_soumission,statut_candidature,lettre_motivation,id_cv) VALUES(?,?,?,?,?,?)";
        try(Connection con= ConnexionDB.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getCandidatId());
            ps.setInt(2, c.getAnnonceId());
            ps.setDate(3, new java.sql.Date(c.getDateSoumission().getTime()));
            ps.setString(4, c.getStatutCandidature());
            ps.setString(5, c.getLettreMotivation());
            ps.setInt(6, c.getCvId()); // AJOUT
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Candidature extractFromResultSet(ResultSet rs) throws SQLException {
        Candidature c = new Candidature();
        c.setId(rs.getInt("id_candidature"));
        c.setCandidatId(rs.getInt("id_candidat"));
        c.setAnnonceId(rs.getInt("id_annonce"));
        c.setDateSoumission(rs.getDate("date_soumission"));
        c.setStatutCandidature(rs.getString("statut_candidature"));
        c.setLettreMotivation(rs.getString("lettre_motivation"));
        c.setCvId(rs.getInt("id_cv")); // AJOUT
        return c;
    }

    @Override
    public Candidature getById(int id) {
        String sql = "SELECT * FROM candidature WHERE id_candidature=?";
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Candidature> getAll() {
        List<Candidature> list = new ArrayList<>();
        String sql = "SELECT * FROM candidature";
        try (Connection con = ConnexionDB.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);) {
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void update(Candidature c) {
        String sql = "UPDATE candidature SET statut_candidature=?, lettre_motivation=? WHERE id_candidature = ?";
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, c.getStatutCandidature());
            ps.setString(2, c.getLettreMotivation());
            ps.setInt(3, c.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM candidature WHERE id_candidature=?";
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Candidature> getByCandidatId(int candidatId) {
        List<Candidature> list = new ArrayList<>();
        String sql = "SELECT * FROM candidature WHERE id_candidat=? ORDER BY date_soumission DESC";
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, candidatId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public List<Candidature> getByAnnonceId(int annonceId) {
        List<Candidature> list = new ArrayList<>();
        String sql = "SELECT * FROM candidature WHERE id_annonce=?";
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, annonceId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Candidature> getByCandidatureIdAndStatut(int candidatId, String statut) {
        String sql = "SELECT * FROM candidature WHERE id_candidat=? AND statut_candidature=?";
        List<Candidature> list = new ArrayList<>();
        try (Connection con = ConnexionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, candidatId);
            ps.setString(2, statut);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Candidature> getRecentByCandidatId(int candidatId, int limit) {
        List<Candidature> list = new ArrayList<>();
        String sql = "SELECT * FROM candidature WHERE id_candidat = ? ORDER BY date_soumission DESC LIMIT ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            stmt.setInt(2, limit);
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
    public int countByCandidatId(int candidatId) {
        String sql = "SELECT COUNT(*) FROM candidature WHERE id_candidat = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidatId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int countByRecruteurId(int recruteurId) {
        String sql = "SELECT COUNT(*) FROM candidature c JOIN annonce a ON c.id_annonce = a.id_annonce WHERE a.id_recruteur = ?";
        try (Connection conn = ConnexionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, recruteurId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    //Get Candidatures By Recruteur Id
    @Override
    public List<Candidature> getByRecruteurId(int userId) {

        List<Candidature> list = new ArrayList<>();

        String sql = "SELECT c.*, u.nom, u.prenom, a.titre, cv.chemin_fichier " +
                "FROM candidature c " +
                "JOIN annonce a ON c.id_annonce = a.id_annonce " +
                "JOIN recruteur r ON a.id_recruteur = r.id_recruteur " +
                "JOIN utilisateur u ON c.id_candidat = u.id_utilisateur " +
                "LEFT JOIN cv ON c.id_cv = cv.id_cv " +
                "WHERE r.id_recruteur = ? " +
                "ORDER BY c.date_soumission DESC";


        try (Connection con = ConnexionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Candidature c = new Candidature();

                c.setId(rs.getInt("id_candidature"));
                c.setCandidatId(rs.getInt("id_candidat"));
                c.setAnnonceId(rs.getInt("id_annonce"));
                c.setDateSoumission(rs.getDate("date_soumission"));
                c.setStatutCandidature(rs.getString("statut_candidature"));
                c.setCvId(rs.getInt("id_cv"));

                // champs supplémentaires
                c.setNom(rs.getString("nom"));
                c.setPrenom(rs.getString("prenom"));
                c.setTitreAnnonce(rs.getString("titre"));
                c.setCheminCv(rs.getString("chemin_fichier"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    @Override
    public void updateStatut(int idCandidature, String statut) {

        String sql = "UPDATE candidature SET statut_candidature=? WHERE id_candidature=?";

        try (Connection con = ConnexionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, statut);
            ps.setInt(2, idCandidature);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    @Override
    public List<Candidature> getByRecruteurIdAndStatut(int recruteurId, String statut) {

        List<Candidature> list = new ArrayList<>();

        String sql = "SELECT c.*, u.nom, u.prenom, a.titre, cv.chemin_fichier " +
                "FROM candidature c " +
                "JOIN annonce a ON c.id_annonce = a.id_annonce " +
                "JOIN recruteur r ON a.id_recruteur = r.id_recruteur " +
                "JOIN utilisateur u ON c.id_candidat = u.id_utilisateur " +
                "LEFT JOIN cv ON c.id_cv = cv.id_cv " +
                "WHERE r.id_recruteur = ? AND c.statut_candidature = ? " +
                "ORDER BY c.date_soumission DESC";

        try (Connection con = ConnexionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, recruteurId);
            ps.setString(2, statut);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Candidature c = new Candidature();

                c.setId(rs.getInt("id_candidature"));
                c.setCandidatId(rs.getInt("id_candidat"));
                c.setAnnonceId(rs.getInt("id_annonce"));
                c.setDateSoumission(rs.getDate("date_soumission"));
                c.setStatutCandidature(rs.getString("statut_candidature"));
                c.setCvId(rs.getInt("id_cv"));

                c.setNom(rs.getString("nom"));
                c.setPrenom(rs.getString("prenom"));
                c.setTitreAnnonce(rs.getString("titre"));
                c.setCheminCv(rs.getString("chemin_fichier"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}