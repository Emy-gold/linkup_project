package Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")  // ✅ CORRECTION 1 : minuscule
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalider la session pour déconnecter l'utilisateur
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            System.out.println("✅ Session invalidée - Utilisateur déconnecté");
        }

        // ✅ CORRECTION 2 : Ajouter le / avant login.jsp
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}