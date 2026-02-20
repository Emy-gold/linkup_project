package Controllers.universite;

import Models.Universite;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/agent-profile")
public class AgentProfileServlet extends HttpServlet {

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

        Universite universite = (Universite) session.getAttribute("universite");

        request.setAttribute("user", user);
        request.setAttribute("universite", universite);

        request.getRequestDispatcher("/Views/universite/agent-profile.jsp").forward(request, response);
    }
}
