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

    private CandidatureDAO candidatureDAO = new CandidatureDAOImpl();
    private EntretienDAO entretienDAO = new EntretienDAOImpl();
    private CVDAO cvDAO = new CVDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. RÉCUPÉRER LA SESSION
        HttpSession session = req.getSession(false);

        if(session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 2. RÉCUPÉRER L'UTILISATEUR DEPUIS LA SESSION
        utilisateur user = (utilisateur) session.getAttribute("user");

        // 3. VÉRIFIER SI L'UTILISATEUR EST CONNECTÉ ET EST UN CANDIDAT
        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 4. RÉCUPÉRER L'ID DU CANDIDAT
        int candidatId = user.getIdUtilisateur();

        System.out.println("✅ Dashboard - Candidat ID: " + candidatId);

        // 5. GET STATISTICS
        int candidaturesCount = candidatureDAO.countByCandidatId(candidatId);
        int entretiensCount = entretienDAO.countByCandidatId(candidatId);
        int cvsCount = cvDAO.countByCandidatId(candidatId);

        System.out.println("📊 Candidatures: " + candidaturesCount);
        System.out.println("📊 Entretiens: " + entretiensCount);
        System.out.println("📊 CVs: " + cvsCount);

        // 6. GET RECENT APPLICATIONS (last 5)
        List<Candidature> recentCandidatures = candidatureDAO.getRecentByCandidatId(candidatId, 5);
        System.out.println("📋 Recent candidatures: " + (recentCandidatures != null ? recentCandidatures.size() : 0));

        // 7. GET UPCOMING INTERVIEWS (last 3)
        List<Entretien> upcomingEntretiens = entretienDAO.getUpcomingByCandidatId(candidatId, 3);
        System.out.println("📅 Upcoming entretiens: " + (upcomingEntretiens != null ? upcomingEntretiens.size() : 0));

        // 8. SET ATTRIBUTES - CORRECTION DES NOMS
        req.setAttribute("candidaturesCount", candidaturesCount);
        req.setAttribute("entretiensCount", entretiensCount);
        req.setAttribute("cvsCount", cvsCount);
        req.setAttribute("recentCandidatures", recentCandidatures);
        req.setAttribute("upcomingEntretiens", upcomingEntretiens);

        // 9. FORWARD TO JSP
        req.getRequestDispatcher("/Views/candidat/dashboard.jsp").forward(req, resp);
    }
}