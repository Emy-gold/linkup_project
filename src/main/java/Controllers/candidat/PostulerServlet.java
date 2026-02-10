package Controllers.candidat;

import DAO.*;
import Models.Candidature;
import Models.Annonce;
import Models.Cv;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/candidat/postuler")
@MultipartConfig
public class PostulerServlet extends HttpServlet {

    private CandidatureDAO candidatureDAO = new CandidatureDAOImpl();
    private AnnonceDAO annonceDAO = new AnnonceDAOImpl();
    private CVDAO cvDAO = new CVDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        // Get annonce details
        String annonceId = req.getParameter("id");
        if(annonceId != null) {
            Annonce a = annonceDAO.getById(Integer.parseInt(annonceId));
            req.setAttribute("annonce", a);
        }

        // Get candidate's CVs
        List<Cv> cvs = cvDAO.getByCandidatId(user.getIdUtilisateur());
        req.setAttribute("cvs", cvs);

        req.getRequestDispatcher("/Views/candidat/postuler.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        try {
            // Get form data
            int annonceId = Integer.parseInt(req.getParameter("annonceId"));
            int candidatId = user.getIdUtilisateur();
            int cvId = Integer.parseInt(req.getParameter("cvId"));
            String lettreMotivation = req.getParameter("lettreMotivation");

            // Create candidature
            Candidature c = new Candidature();
            c.setCandidatId(candidatId);
            c.setAnnonceId(annonceId);
            c.setDateSoumission(new Date());
            c.setStatutCandidature("En attente");
            c.setLettreMotivation(lettreMotivation);

            // Save to database
            candidatureDAO.create(c);

            // Redirect with success message
            resp.sendRedirect("candidatures?success=true");

        } catch(Exception e) {
            e.printStackTrace();
            resp.sendRedirect("postuler?id=" + req.getParameter("annonceId") + "&error=true");
        }
    }
}