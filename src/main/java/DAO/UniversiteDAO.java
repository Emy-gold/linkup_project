package DAO;

import Models.Universite;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UniversiteDAO {
    // Ajouter cette méthode dans UniversiteDAO.java
    public List<Universite> getAllUniversites() {
        List<Universite> universites = new ArrayList<>();
        String sql = "SELECT u.*, univ.nom_universite, univ.adresse, univ.telephone, univ.email_contact " +
                "FROM utilisateur u " +
                "JOIN universite univ ON u.id_utilisateur = univ.id_universite " +
                "WHERE u.role = 'AGENT_UNIV' " +
                "ORDER BY univ.nom_universite";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Universite universite = new Universite();
                universite.setIdUtilisateur(rs.getInt("id_utilisateur"));
                universite.setId_universite(rs.getInt("id_universite")); // Si vous avez ajouté ce getter/setter
                universite.setEmail(rs.getString("email"));
                universite.setNom(rs.getString("nom"));
                universite.setPrenom(rs.getString("prenom"));
                universite.setRole(rs.getString("role"));
                universite.setNomUniversite(rs.getString("nom_universite"));
                universite.setAdresse(rs.getString("adresse"));
                universite.setTelephone(rs.getString("telephone"));
                universite.setEmailContact(rs.getString("email_contact"));

                universites.add(universite);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return universites;
    }
}
