package Controllers;

import DAO.DiplomeDAO;
import DAO.UniversiteDAO;
import Models.Diplome;
import Models.Universite;
import Models.utilisateur;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/universite/*")
public class UniversiteDashboardServlet extends HttpServlet {
    private DiplomeDAO diplomeDAO;
    private UniversiteDAO universiteDAO;

    @Override
    public void init() throws ServletException {
        this.diplomeDAO = new DiplomeDAO();
        this.universiteDAO = new UniversiteDAO();
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

        String pathInfo = request.getPathInfo();

        // Route 1: Page de sélection des universités
        if (pathInfo == null || "/select".equals(pathInfo)) {
            List<Universite> universites = universiteDAO.getAllUniversites();
            request.setAttribute("universites", universites);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/universite/select-universite.jsp");
            dispatcher.forward(request, response);
        }
        // Route 2: Dashboard d'une université spécifique
        else if (pathInfo.startsWith("/dashboard")) {
            String idUniversiteStr = request.getParameter("id_universite");

            if (idUniversiteStr == null || idUniversiteStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/universite/select");
                return;
            }

            try {
                int idUniversite = Integer.parseInt(idUniversiteStr);

                // Récupérer les informations de l'université
                Universite universite = universiteDAO.getUniversiteById(idUniversite);
                if (universite == null) {
                    response.sendRedirect(request.getContextPath() + "/universite/select");
                    return;
                }

                // Récupérer les diplômes
                List<Diplome> diplomesEnAttente = diplomeDAO.getDiplomesEnAttente(idUniversite);
                List<Diplome> diplomesHistorique = diplomeDAO.getDiplomesHistorique(idUniversite);

                // Stocker dans la session pour garder l'université sélectionnée
                session.setAttribute("selectedUniversite", universite);

                // Passer les données à la JSP
                request.setAttribute("universite", universite);
                request.setAttribute("diplomesEnAttente", diplomesEnAttente);
                request.setAttribute("diplomesHistorique", diplomesHistorique);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/universite/dashboard.jsp");
                dispatcher.forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/universite/select");
            }
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

        if (action != null && idDiplomeStr != null && idUniversiteStr != null) {
            int idDiplome = Integer.parseInt(idDiplomeStr);
            int idUniversite = Integer.parseInt(idUniversiteStr);

            if ("valider".equals(action)) {
                diplomeDAO.validerDiplome(idDiplome);
            } else if ("rejeter".equals(action)) {
                diplomeDAO.rejeterDiplome(idDiplome);
            }

            // Rediriger vers le dashboard de la même université
            response.sendRedirect(request.getContextPath() + "/universite/dashboard?id_universite=" + idUniversite);
        }
    }
}