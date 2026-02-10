package Controllers.candidat;

import DAO.AnnonceDAO;
import DAO.AnnonceDAOImpl;
import Models.Annonce;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/candidat/annonces")
public class AnnoncesServlet extends HttpServlet {

    private AnnonceDAO annonceDAO = new AnnonceDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if(user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        // Get search parameters
        String keyword = req.getParameter("keyword");
        String typeContrat = req.getParameter("typeContrat");

        List<Annonce> annonces;

        // Search or get all
        if(keyword != null && !keyword.trim().isEmpty()) {
            annonces = annonceDAO.search(keyword);
        } else if(typeContrat != null && !typeContrat.equals("Tous les contrats")) {
            annonces = annonceDAO.getByTypeContrat(typeContrat);
        } else {
            annonces = annonceDAO.getAll();
        }

        // Set attributes
        req.setAttribute("annonces", annonces);
        req.setAttribute("keyword", keyword);
        req.setAttribute("typeContrat", typeContrat);

        // Forward to JSP
        req.getRequestDispatcher("/Views/candidat/annonces.jsp").forward(req, resp);
    }
}
