package Controllers;

import DAO.DiplomeDAOImpl;
import DAO.UniversiteDAO;
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

        String idUniversiteStr = request.getParameter("id_universite");

        // DEBUG: Afficher le paramètre reçu
        System.out.println("DEBUG: id_universite param = " + idUniversiteStr);

        if (idUniversiteStr == null || idUniversiteStr.isEmpty()) {
            // Rediriger vers la sélection si pas d'université spécifiée
            response.sendRedirect(request.getContextPath() + "/universite-select");
            return;
        }

        try {
            int idUniversite = Integer.parseInt(idUniversiteStr);

            // DEBUG
            System.out.println("DEBUG: id_universite parsed = " + idUniversite);

            // Récupérer les informations de l'université
            Universite universite = universiteDAO.getUniversiteById(idUniversite);

            // DEBUG
            System.out.println("DEBUG: universite from DAO = " + universite);
            if (universite != null) {
                System.out.println("DEBUG: nomUniversite = " + universite.getNomUniversite());
            }

            if (universite == null) {
                request.setAttribute("error", "Université non trouvée");
                response.sendRedirect(request.getContextPath() + "/universite-select");
                return;
            }

            // Récupérer les diplômes
            List<Diplome> diplomesEnAttente = diplomeDAO.getDiplomesEnAttente(idUniversite);
            List<Diplome> diplomesHistorique = diplomeDAO.getDiplomesHistorique(idUniversite);

            // DEBUG
            System.out.println("DEBUG: diplomesEnAttente size = " + (diplomesEnAttente != null ? diplomesEnAttente.size() : 0));
            System.out.println("DEBUG: diplomesHistorique size = " + (diplomesHistorique != null ? diplomesHistorique.size() : 0));

            // Passer les données à la JSP
            request.setAttribute("universite", universite);
            request.setAttribute("diplomesEnAttente", diplomesEnAttente);
            request.setAttribute("diplomesHistorique", diplomesHistorique);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/universite/dashboard.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "ID université invalide");
            response.sendRedirect(request.getContextPath() + "/universite-select");
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