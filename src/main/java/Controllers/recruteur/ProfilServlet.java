package Controllers.recruteur;

import DAO.RecruteurDAO;
import DAO.RecruteurDAOImpl;
import DAO.UtilisateurDAO;
import DAO.UtilisateurDaoIMP;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import Models.Recruteur;

@WebServlet("/recruteur/profil")
public class ProfilServlet extends HttpServlet {

    private RecruteurDAO recruteurDAO;

    @Override
    public void init() {
        recruteurDAO = new RecruteurDAOImpl();
    }

    // =========================
    // GET → afficher profil
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        Recruteur recruteur = recruteurDAO.getByUserId(userId);

        request.setAttribute("recruteur", recruteur);

        request.getRequestDispatcher("/Views/recruteur/profil.jsp")
                .forward(request, response);
    }

    // =========================
    // POST → actions
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("actionRecruteur");

        try {
            if ("modifyRecruteur".equals(action)) {
                updateRecruteur(request);
            }
            response.sendRedirect(request.getContextPath() + "/recruteur/profil?success=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/recruteur/profil?error=true");
        }
    }

    // =========================
    // METHODS
    // =========================

    private void updateRecruteur(HttpServletRequest request) throws Exception {

        int userId = (Integer) request.getSession().getAttribute("userId");

        Recruteur r = recruteurDAO.getByUserId(userId);

        r.setNomEntreprise(request.getParameter("nomEntreprise"));
        r.setSecteurActivite(request.getParameter("secteurActivite"));
        r.setDescriptionEntreprise(request.getParameter("descriptionEntreprise"));
        r.setPosteOccupe(request.getParameter("posteOccupe"));

        recruteurDAO.update(r);
    }

}
