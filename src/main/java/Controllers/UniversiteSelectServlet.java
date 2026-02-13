package Controllers;

import DAO.UniversiteDAO;
import DAO.UniversiteDAOImpl;
import Models.Universite;
import Models.utilisateur;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;


@WebServlet("/universite-select")
public class UniversiteSelectServlet extends HttpServlet {
    private UniversiteDAO universiteDAO;

    @Override
    public void init() throws ServletException {
        this.universiteDAO = new UniversiteDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Vérifier si c'est un agent universitaire
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"AGENT_UNIV".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer toutes les universités
        List<Universite> universites = universiteDAO.getAllUniversites();
        request.setAttribute("universites", universites);

        // Forward vers la page de sélection
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/universite/select-universite.jsp");
        dispatcher.forward(request, response);
    }
}