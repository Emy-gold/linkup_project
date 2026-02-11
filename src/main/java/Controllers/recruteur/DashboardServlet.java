package Controllers.recruteur;

import DAO.AnnonceDAO;
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

    @Override
    public void init() {
        annonceDAO = new DAO.AnnonceDAOImpl();
        candidatureDAO = new DAO.CandidatureDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        int adsCount = annonceDAO.countByRecruteurId(recruteurId);
        int appsCount = candidatureDAO.countByRecruteurId(recruteurId);

        request.setAttribute("adsCount", adsCount);
        request.setAttribute("appsCount", appsCount);

        request.getRequestDispatcher("/Views/recruteur/dashboard.jsp").forward(request, response);
    }

}
