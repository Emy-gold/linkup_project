package Controllers.candidat;

import DAO.*;
import Models.Universite;
import Models.utilisateur;
import Models.Candidat;
import Models.Diplome;
import Utils.FileUploadConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/candidat/profile")
@MultipartConfig(maxFileSize = 10485760) // 10MB
public class ProfileServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO = new UtilisateurDaoIMP();
    private CandidatDAO candidatDAO = new CandidatDAOImpl();
    private diplomeDAO diplomeDAO = new DiplomeDAOImpl();
    private UniversiteDAO universiteDAO = new UniversiteDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        // Get updated candidat info
        Candidat c = candidatDAO.getById(user.getIdUtilisateur());
        req.setAttribute("candidat", c);

        // Get diplomes
        List<Diplome> diplomes = diplomeDAO.getByCandidatId(user.getIdUtilisateur());
        req.setAttribute("diplomes", diplomes);

        // Get universites pour la liste déroulante
        List<Universite> universites = universiteDAO.getAllUniversites();
        req.setAttribute("universites", universites);

        req.getRequestDispatcher("/Views/candidat/profile.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        try {
            String action = req.getParameter("action");

            if("updateProfile".equals(action)) {
                // Update profile
                String nom = req.getParameter("nom");
                String prenom = req.getParameter("prenom");
                String email = req.getParameter("email");
                String titreProfil = req.getParameter("titreProfil");
                String disponibilite = req.getParameter("disponibilite");

                user.setNom(nom);
                user.setPrenom(prenom);
                user.setEmail(email);
                UtilisateurDAO.update(user);

                Candidat c = candidatDAO.getById(user.getIdUtilisateur());
                if(c != null) {
                    c.setTitreProfil(titreProfil);
                    c.setDisponibilite(disponibilite);
                    candidatDAO.update(c);
                }

                session.setAttribute("user", user);
                resp.sendRedirect("profile?success=profile");

            } else if("addDiplome".equals(action)) {
                // Add diplome
                String libelle = req.getParameter("libelle");
                String universiteIdStr = req.getParameter("id_universite"); // ✅ AJOUT : Récupérer l'ID de l'université
                Part filePart = req.getPart("documentJustificatif");

                String uploadPath = FileUploadConfig.UPLOAD_PATH_DIPLOMES;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                Diplome diplome = new Diplome();
                diplome.setLibelle(libelle);
                diplome.setDocument_justificatif("uploads/diplomes/" + fileName);
                diplome.setStatut_validation("En attente");
                diplome.setId_candidat(user.getIdUtilisateur());

                // ✅ AJOUT : Définir l'ID de l'université
                if(universiteIdStr != null && !universiteIdStr.isEmpty()) {
                    diplome.setId_universite(Integer.parseInt(universiteIdStr));
                }

                diplomeDAO.create(diplome);
                resp.sendRedirect("profile?success=diplome");

            } else if("deleteDiplome".equals(action)) {
                // Delete diplome
                int diplomeId = Integer.parseInt(req.getParameter("diplomeId"));
                diplomeDAO.delete(diplomeId);
                resp.sendRedirect("profile?success=deleted");
            }

        } catch(Exception e) {
            e.printStackTrace();
            resp.sendRedirect("profile?error=true");
        }
    }
}