package Controllers.candidat;

import DAO.*;
import Models.Entretien;
import Models.Candidature;
import Models.Annonce;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/candidat/entretiens")
public class EntretiensServlet extends HttpServlet {

    private EntretienDAO entretienDAO = new EntretienDAOImpl();
    private CandidatureDAO candidatureDAO = new CandidatureDAOImpl();
    private AnnonceDAO annonceDAO = new AnnonceDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if(session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int candidatId = user.getIdUtilisateur();

        // Get filter parameter
        String filter = req.getParameter("filter");

        List<Entretien> entretiens;
        Date now = new Date();

        if("upcoming".equals(filter)) {
            // Get upcoming interviews
            entretiens = new ArrayList<>();
            List<Entretien> allEntretiens = entretienDAO.getByCandidatId(candidatId);
            for(Entretien e : allEntretiens) {
                if(e.getDateHeure().after(now)) {
                    entretiens.add(e);
                }
            }
        } else if("past".equals(filter)) {
            // Get past interviews
            entretiens = new ArrayList<>();
            List<Entretien> allEntretiens = entretienDAO.getByCandidatId(candidatId);
            for(Entretien e : allEntretiens) {
                if(e.getDateHeure().before(now)) {
                    entretiens.add(e);
                }
            }
        } else if("Planifié".equals(filter) || "Terminé".equals(filter) || "Annulé".equals(filter)) {
            // Get by status
            entretiens = new ArrayList<>();
            List<Entretien> allEntretiens = entretienDAO.getByCandidatId(candidatId);
            for(Entretien e : allEntretiens) {
                if(filter.equals(e.getStatutEntretien())) {
                    entretiens.add(e);
                }
            }
        } else {
            // Get all interviews
            entretiens = entretienDAO.getByCandidatId(candidatId);
        }

        // Enrich entretiens with candidature and annonce details
        List<EntretienDetails> entretienDetailsList = new ArrayList<>();

        for(Entretien e : entretiens) {
            EntretienDetails details = new EntretienDetails();
            details.setEntretien(e);

            // Get candidature
            Candidature c = candidatureDAO.getById(e.getCandidatureId());
            details.setCandidature(c);

            // Get annonce
            if(c != null) {
                Annonce a = annonceDAO.getById(c.getAnnonceId());
                details.setAnnonce(a);
            }

            entretienDetailsList.add(details);
        }

        // Set attributes
        req.setAttribute("entretienDetails", entretienDetailsList);
        req.setAttribute("filter", filter);

        // Forward to JSP
        req.getRequestDispatcher("/Views/candidat/entretiens.jsp").forward(req, resp);
    }

    // Inner class to hold entretien with related data
    public static class EntretienDetails {
        private Entretien entretien;
        private Candidature candidature;
        private Annonce annonce;

        public Entretien getEntretien() { return entretien; }
        public void setEntretien(Entretien entretien) { this.entretien = entretien; }

        public Candidature getCandidature() { return candidature; }
        public void setCandidature(Candidature candidature) { this.candidature = candidature; }

        public Annonce getAnnonce() { return annonce; }
        public void setAnnonce(Annonce annonce) { this.annonce = annonce; }
    }
}