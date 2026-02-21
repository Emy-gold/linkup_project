package Controllers.recruteur;

import DAO.AnnonceDAO;
import DAO.EntretienDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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

        request.setAttribute("adsCount", adsCount);
        request.setAttribute("appsCount", appsCount);
        request.setAttribute("entsCount", entsCount);
        request.setAttribute("acceptanceRate", acceptanceRate);


        request.getRequestDispatcher("/Views/recruteur/dashboard.jsp").forward(request, response);
    }

}
