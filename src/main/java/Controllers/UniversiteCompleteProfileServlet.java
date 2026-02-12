package Controllers;

import DAO.UniversiteDAO;
import DAO.UniversiteDAOImpl;
import Models.Universite;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/universite-complete-profile")
public class UniversiteCompleteProfileServlet extends HttpServlet {
    private UniversiteDAO universiteDAO = new UniversiteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/Views/universite/complete-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        utilisateur user = (utilisateur) session.getAttribute("user");
        
        String nomUniv = request.getParameter("nomUniversite");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        String emailContact = request.getParameter("emailContact");

        Universite univ = new Universite();
        univ.setIdUtilisateur(user.getIdUtilisateur());
        univ.setNomUniversite(nomUniv);
        univ.setAdresse(adresse);
        univ.setTelephone(telephone);
        univ.setEmailContact(emailContact);

        if (universiteDAO.createUniversite(univ)) {
            session.setAttribute("universite", univ);
            response.sendRedirect(request.getContextPath() + "/universite-dashboard");
        } else {
            request.setAttribute("error", "Erreur lors de l'enregistrement des informations.");
            request.getRequestDispatcher("/Views/universite/complete-profile.jsp").forward(request, response);
        }
    }
}
