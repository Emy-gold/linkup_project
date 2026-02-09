package Controllers.candidat;

import DAO.*;
import Models.Candidature;
import Models.Entretien;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/candidat/dashboard")
public class DashboardServlet extends HttpServlet {

    utilisateur user = new utilisateur();
    CandidatureDAO candidatureDAO = new CandidatureDAOImpl();
    EntretienDAO entretienDAO = new EntretienDAOImpl();
    CVDAO cvdao = new CVDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int candidatId = user.getIdUtilisateur();

        //Get statistics
        int candidaturesCount = candidatureDAO.countByCandidatId(candidatId);
        int entretiensCount = entretienDAO.countByCandidatId(candidatId);
        int cvsCount = cvdao.countByCandidatId(candidatId);

        //Get recent applications (last 5)
        List<Candidature> recentCandidatures = candidatureDAO.getRecentByCandidatId(candidatId, 5);

        //Get upcoming interviews (last 3)
        List<Entretien> upcomingEntretiens = entretienDAO.getUpcomingByCandidatId(candidatId, 3);

        //Set attributes - NO annoncesVuesCount
        req.setAttribute("candidaturesCount",candidaturesCount);
        req.setAttribute("entretiensCount",entretiensCount);
        req.setAttribute("cvsCount",cvsCount);
        req.setAttribute("recentCandidatures", recentCandidatures);
        req.setAttribute("upcomingEntretiens", upcomingEntretiens);

        req.getRequestDispatcher("/Views/candidat/dashboard.jsp").forward(req, resp);
    }
}
