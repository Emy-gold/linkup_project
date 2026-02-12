package Controllers;

import DAO.DiplomeDAOImpl;
import DAO.UniversiteDAO;
import DAO.UniversiteDAOImpl;
import Models.Diplome;
import Models.Universite;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;


@WebServlet("/universite-dashboard")
public class UniversiteDashboardServlet extends HttpServlet {
    private DiplomeDAOImpl diplomeDAO;
    private UniversiteDAO universiteDAO;

    @Override
    public void init() throws ServletException {
        this.diplomeDAO = new DiplomeDAOImpl();
        this.universiteDAO = new UniversiteDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }   

        // Vérifier si c'est un agent universitaire
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"AGENT_UNIV".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer l'université depuis la session
        Universite universite = (Universite) session.getAttribute("universite");

        if (universite == null) {
            // Si pas en session, tenter de la récupérer via DAO
            universite = universiteDAO.getUniversiteByAgentId(user.getIdUtilisateur());
            if (universite == null) {
                response.sendRedirect(request.getContextPath() + "/universite-complete-profile");
                return;
            }
            session.setAttribute("universite", universite);
        }

        int idUniversite = universite.getIdUtilisateur();

        try {
            // Récupérer les diplômes
            List<Diplome> diplomesEnAttente = diplomeDAO.getDiplomesEnAttente(idUniversite);
            List<Diplome> diplomesHistorique = diplomeDAO.getDiplomesHistorique(idUniversite);

            // Passer les données à la JSP
            request.setAttribute("universite", universite);
            request.setAttribute("diplomesEnAttente", diplomesEnAttente);
            request.setAttribute("diplomesHistorique", diplomesHistorique);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/universite/dashboard.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du tableau de bord");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String idDiplomeStr = request.getParameter("id_diplome");
        String idUniversiteStr = request.getParameter("id_universite");

        System.out.println("DEBUG POST: action=" + action + ", idDiplome=" + idDiplomeStr + ", idUniversite=" + idUniversiteStr);

        if (action != null && idDiplomeStr != null && idUniversiteStr != null) {
            int idDiplome = Integer.parseInt(idDiplomeStr);
            int idUniversite = Integer.parseInt(idUniversiteStr);

            if ("valider".equals(action)) {
                diplomeDAO.validerDiplome(idDiplome);
            } else if ("rejeter".equals(action)) {
                diplomeDAO.rejeterDiplome(idDiplome);
            }

            // Rediriger vers le dashboard de la même université
            response.sendRedirect(request.getContextPath() + "/universite-dashboard?id_universite=" + idUniversite);
        }
    }
}