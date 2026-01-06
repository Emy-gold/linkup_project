package Controllers;

import DAO.UtilisateurDAO;
import DAO.UtilisateurDaoIMP;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

import static DAO.UtilisateurDAO.create;


@WebServlet("/signup")
public class SignupServlet extends HttpServlet{

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            utilisateur u = new utilisateur(
                    req.getParameter("email"),
                    req.getParameter("password"),
                    req.getParameter("nom"),
                    req.getParameter("prenom"),
                    req.getParameter("role"),
                    new Date(),
                    "Actif"
            );

            UtilisateurDaoIMP.create(u);
            resp.sendRedirect("login.jsp?success=true");
        }catch(Exception e){
            e.printStackTrace();
            resp.sendRedirect("signup.jsp?error=server");
        }
    }

}
