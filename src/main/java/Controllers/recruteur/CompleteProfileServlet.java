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
public class CompleteProfileServlet extends HttpServlet{

    private RecruteurDAO recruteurDAO;

    @Override
    public void init() {
        recruteurDAO = new RecruteurDAOImpl();
    }

    //Afiicher Form:
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        //recuperer Forign key userId
        int userId = (int) session.getAttribute("userId");

        String nomEntreprise = request.getParameter("nomEntreprise");
        String secteur = request.getParameter("secteurActivite");
        String description = request.getParameter("descriptionEntreprise");
        String poste = request.getParameter("posteOccupe");

        try{
            Recruteur r = new Recruteur();
            r.setUserId(userId);
            r.setNomEntreprise(nomEntreprise);
            r.setSecteurActivite(secteur);
            r.setDescriptionEntreprise(description);
            r.setPosteOccupe(poste);
            r.setLogo(null);

            recruteurDAO.create(r);

            response.sendRedirect(request.getContextPath() + "/recruteur/dashboard");
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "Erreur lors de la création du profil");
            request.getRequestDispatcher("/Views/recruteur/complete-profile.jsp").forward(request, response);
        }
    }
}
