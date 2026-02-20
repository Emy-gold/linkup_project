package Controllers.recruteur;



import DAO.CandidatureDAO;
import DAO.CandidatureDAOImpl;
import DAO.EntretienDAO;
import DAO.EntretienDAOImpl;
import Models.Candidature;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/recruteur/candidatures")
public class CandidatureServlet extends HttpServlet {
    private CandidatureDAO candidatureDAO;
    private EntretienDAO entretienDAO;

    @Override
    public void init() {
        candidatureDAO = new CandidatureDAOImpl();
        entretienDAO = new EntretienDAOImpl();
    }

    // =========================
    // GET → afficher candidatures
    // =========================
    // =========================
    // GET → afficher candidatures
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Sécurité
        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        try {
            String statut = request.getParameter("statut");

            List<Candidature> candidatures;

            if (statut != null && !statut.isEmpty()) {
                candidatures = candidatureDAO.getByRecruteurIdAndStatut(recruteurId, statut);
            } else {
                candidatures = candidatureDAO.getByRecruteurId(recruteurId);
            }

            request.setAttribute("candidatures", candidatures);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des candidatures.");
        }

        System.out.println("Recruteur ID: " + recruteurId);

        request.getRequestDispatcher("/Views/recruteur/candidatures.jsp")
                .forward(request, response);
    }



    // =========================
    // POST → changer statut
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateStatut".equals(action)) {
            try {
                int candidatureId = Integer.parseInt(request.getParameter("id"));
                String nouveauStatut = request.getParameter("statut");

                // Sécurisation : vérifier statut valide
                if (nouveauStatut != null &&
                        (nouveauStatut.equals("En_attente")
                                || nouveauStatut.equals("Acceptee")
                                || nouveauStatut.equals("Rejetee"))) {

                    // Mettre à jour dans la base de données
                    candidatureDAO.updateStatut(candidatureId, nouveauStatut);

                    // Si accepté → créer entretien automatiquement
                    if (nouveauStatut.equals("Acceptee")) {
                        entretienDAO.createEntretien(candidatureId);
                    }

                    // Répondre avec JSON pour AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    System.out.println("Candidature " + candidatureId + " mise a jour: " + nouveauStatut);

                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"success\": false, \"message\": \"Statut invalide\"}");
                }

            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"ID invalide\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Erreur serveur\"}");
            }
        }
    }
}
