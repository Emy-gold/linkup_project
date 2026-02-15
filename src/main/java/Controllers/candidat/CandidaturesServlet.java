package Controllers.candidat;

import DAO.CandidatureDAO;
import DAO.CandidatureDAOImpl;
import DAO.CVDAO;
import DAO.CVDAOImpl;
import Models.Candidature;
import Models.Cv;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/candidat/candidatures")
public class CandidaturesServlet extends HttpServlet {

    private CandidatureDAO candidatureDAO = new CandidatureDAOImpl();
    private CVDAO cvDAO = new CVDAOImpl(); // AJOUT

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        int candidatId = user.getIdUtilisateur();
        String statut = req.getParameter("statut");

        List<Candidature> candidatures;

        if(statut != null && !statut.equals("Tous")) {
            candidatures = candidatureDAO.getByCandidatureIdAndStatut(candidatId, statut);
        } else {
            candidatures = candidatureDAO.getByCandidatId(candidatId);
        }

        // AJOUT: Créer une map pour associer chaque candidature à son CV
        Map<Integer, Cv> cvMap = new HashMap<>();
        for(Candidature c : candidatures) {
            if(c.getCvId() > 0) {
                Cv cv = cvDAO.getById(c.getCvId());
                if(cv != null) {
                    cvMap.put(c.getId(), cv);
                }
            }
        }

        req.setAttribute("candidatures", candidatures);
        req.setAttribute("cvMap", cvMap); // AJOUT
        req.setAttribute("statut", statut);

        req.getRequestDispatcher("/Views/candidat/candidatures.jsp").forward(req, resp);
    }
}