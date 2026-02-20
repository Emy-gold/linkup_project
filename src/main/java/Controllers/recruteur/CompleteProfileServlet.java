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

        // Recuperer l'utilisateur depuis la session pour avoir l'ID correct
        Models.utilisateur user = (Models.utilisateur) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = user.getIdUtilisateur();
        System.out.println(">>> DEBUG : CompleteProfileServlet - Session récupérée pour userId=" + userId);

        String nomEntreprise = request.getParameter("nomEntreprise");
        String secteur = request.getParameter("secteurActivite");
        String descriptionEntreprise = request.getParameter("descriptionEntreprise");
        String poste = request.getParameter("posteOccupe");

        try {
            System.out.println(">>> DEBUG : Preparation de l'objet Recruteur pour userId=" + userId);
            Recruteur r = new Recruteur();
            r.setUserId(userId);
            r.setNomEntreprise(nomEntreprise);
            r.setSecteurActivite(secteur);
            r.setDescriptionEntreprise(descriptionEntreprise);
            r.setPosteOccupe(poste);
            r.setLogo(null);

            recruteurDAO.create(r);
            System.out.println(">>> DEBUG : Profil recruteur créé avec succès.");

            // 1. Update user status in Database to 'ACTIF'
            DAO.UtilisateurDAO userDAO = new DAO.UtilisateurDaoIMP();
            userDAO.updateStatus(userId, "ACTIF");
            System.out.println(">>> DEBUG : Statut utilisateur mis à jour vers 'ACTIF'.");

            // 2. Refresh User Object in Session
            Models.utilisateur updatedUser = userDAO.findById(userId);
            if (updatedUser != null) {
                System.out.println(">>> DEBUG : Utilisateur rafraîchi en session : " + updatedUser.getEmail()
                        + " (Statut: " + updatedUser.getStatutCompte() + ")");
                session.setAttribute("user", updatedUser);

                // 3. Refresh Recruteur Object & IDs for Dashboard
                Recruteur brandNewRecruteur = recruteurDAO.getByUserId(userId);
                if (brandNewRecruteur != null) {
                    System.out.println(">>> DEBUG : RecruteurId trouvé : " + brandNewRecruteur.getRecruteurId());
                    session.setAttribute("recruteur", brandNewRecruteur);
                    session.setAttribute("recruteurId", brandNewRecruteur.getRecruteurId());
                }
            }

            String redirectUrl = request.getContextPath() + "/recruteur/dashboard";
            System.out.println(">>> DEBUG : Redirection vers : " + redirectUrl);
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "Erreur lors de la création du profil");
            request.getRequestDispatcher("/Views/recruteur/complete-profile.jsp").forward(request, response);
        }
    }
}
