package Controllers.recruteur;

import DAO.RecruteurDAO;
import DAO.RecruteurDAOImpl;
import Models.Recruteur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/recruteur/complete-profile")
public class CompleteProfileServlet extends HttpServlet {

    private RecruteurDAO recruteurDAO;

    @Override
    public void init() {
        recruteurDAO = new RecruteurDAOImpl();
    }

    // Afiicher Form:
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println(">>> DEBUG : La methode doGet est bien appelée !"); // AJOUTEZ CECI
        request.getRequestDispatcher("/Views/recruteur/complete-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // recuperer Forign key userId
        int userId = (int) session.getAttribute("userId");

        String nomEntreprise = request.getParameter("nomEntreprise");
        String secteur = request.getParameter("secteurActivite");
        String descriptionEntreprise = request.getParameter("descriptionEntreprise");
        String poste = request.getParameter("posteOccupe");

        try {
            Recruteur r = new Recruteur();
            r.setUserId(userId);
            r.setNomEntreprise(nomEntreprise);
            r.setSecteurActivite(secteur);
            r.setDescriptionEntreprise(descriptionEntreprise);
            r.setPosteOccupe(poste);
            r.setLogo(null);

            recruteurDAO.create(r);

            // Update user in session to reflect new status/role if changed (though mostly
            // status)
            Models.utilisateur updatedUser = new DAO.UtilisateurDaoIMP().login(
                    ((Models.utilisateur) session.getAttribute("user")).getEmail(),
                    ((Models.utilisateur) session.getAttribute("user")).getPassword()); // Re-login strictly to get
                                                                                        // fresh object

            // Or better, just get by ID if possible, but login is safer to get full object
            // state
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                // Also set the recruteur object in session so Dashboard doesn't reject us
                // Actually, let's fetch the full recruteur object to be safe
                Recruteur brandNewRecruteur = recruteurDAO.getByUserId(userId);
                if (brandNewRecruteur != null) {
                    session.setAttribute("recruteur", brandNewRecruteur);
                    session.setAttribute("recruteurId", brandNewRecruteur.getRecruteurId());
                }
            }

            response.sendRedirect(request.getContextPath() + "/recruteur/dashboard");
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "Erreur lors de la création du profil");
            request.getRequestDispatcher("/Views/recruteur/complete-profile.jsp").forward(request, response);
        }
    }
}
