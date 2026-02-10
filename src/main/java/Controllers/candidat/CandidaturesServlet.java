package Controllers.candidat;

import DAO.CandidatureDAO;
import DAO.CandidatureDAOImpl;
import Models.Candidature;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/candidat/candidatures")
public class CandidaturesServlet extends HttpServlet {

    private CandidatureDAO candidatureDAO = new CandidatureDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        int candidatId = user.getIdUtilisateur();

        // Get filter parameter
        String statut = req.getParameter("statut");

        List<Candidature> candidatures;

        if(statut != null && !statut.equals("Tous")) {
            candidatures = candidatureDAO.getByCandidatureIdAndStatut(candidatId, statut);
        } else {
            candidatures = candidatureDAO.getByCandidatId(candidatId);
        }

        // Set attributes
        req.setAttribute("candidatures", candidatures);
        req.setAttribute("statut", statut);

        // Forward to JSP
        req.getRequestDispatcher("/Views/candidat/candidatures.jsp").forward(req, resp);
    }
}
