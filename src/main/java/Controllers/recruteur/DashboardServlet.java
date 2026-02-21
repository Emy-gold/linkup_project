package Controllers.recruteur;

import DAO.AnnonceDAO;
import DAO.EntretienDAO;
import Models.Activity;
import Models.Candidature;
import Models.Entretien;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet("/recruteur/dashboard")
public class DashboardServlet extends HttpServlet {

    private AnnonceDAO annonceDAO;
    private DAO.CandidatureDAO candidatureDAO;
    private EntretienDAO entretienDAO;

    @Override
    public void init() {
        annonceDAO = new DAO.AnnonceDAOImpl();
        candidatureDAO = new DAO.CandidatureDAOImpl();
        entretienDAO = new DAO.EntretienDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        int adsCount = annonceDAO.countByRecruteurId(recruteurId);
        int appsCount = candidatureDAO.countByRecruteurId(recruteurId);
        int entsCount = entretienDAO.countByRecruteurId(recruteurId);

        // Calcul du taux d'acceptation
        int acceptedCount = candidatureDAO.countByRecruteurIdAndStatut(recruteurId, "Acceptee");
        int acceptanceRate = 0;
        if (appsCount > 0) {
            acceptanceRate = (acceptedCount * 100) / appsCount;
        }

        // Récupération de l'activité récente
        List<Activity> recentActivity = new ArrayList<>();
        try {
            // 5 dernières candidatures
            List<Candidature> candidatures = candidatureDAO.getByRecruteurId(recruteurId);
            for (int i = 0; i < Math.min(candidatures.size(), 5); i++) {
                Candidature c = candidatures.get(i);
                recentActivity.add(new Activity(
                    "Nouvelle candidature",
                    c.getPrenom() + " " + c.getNom() + " a postulé pour : " + c.getTitreAnnonce(),
                    c.getDateSoumission().toString()
                ));
            }

            // 5 derniers entretiens
            List<Entretien> entretiens = entretienDAO.getByRecruteurId(recruteurId);
            for (int i = 0; i < Math.min(entretiens.size(), 5); i++) {
                Entretien e = entretiens.get(i);
                recentActivity.add(new Activity(
                    "Entretien planifié",
                    "Entretien avec " + e.getPrenom() + " " + e.getNom() + " pour : " + e.getTitreAnnonce(),
                    e.getDateHeure().toString()
                ));
            }

            // Trier par date (déjà trié par les DAOs individuellement mais on peut mélanger si besoin)
            // Pour l'instant on garde les plus récents en haut (candidatures puis entretiens)
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("adsCount", adsCount);
        request.setAttribute("appsCount", appsCount);
        request.setAttribute("entsCount", entsCount);
        request.setAttribute("acceptanceRate", acceptanceRate);
        request.setAttribute("recentActivity", recentActivity);


        request.getRequestDispatcher("/Views/recruteur/dashboard.jsp").forward(request, response);
    }

}
