package Controllers;

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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UtilisateurDAO userDAO = new UtilisateurDaoIMP();

   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

       try {
           utilisateur u = userDAO.login(req.getParameter("email"),req.getParameter("password"));

           if( u != null){
               HttpSession session = req.getSession();
               session.setAttribute("user", u);
               session.setAttribute("userId", u.getIdUtilisateur());
               session.setAttribute("role", u.getRole());

               switch (u.getRole()) {

                   case "CANDIDAT":
                       resp.sendRedirect("Views/candidat/dashboard.jsp");
                       break;
                   case "RECRUTEUR":
                       resp.sendRedirect("Views/recruteur/dashboard.jsp");
                       break;
                   case "ADMIN":
                       resp.sendRedirect("Views/admin/dashboard.jsp");
                       break;
                   case "AGENT":
                       resp.sendRedirect("Views/universite/dashboard.jsp");
                       break;
                   default:
                       resp.sendRedirect("Views/login.jsp?error=invalid_role");
                       break;
               }
           }else {
               resp.sendRedirect("login.jsp?error=true");
           }
       } catch (Exception e) {
           e.printStackTrace();
           resp.sendRedirect("login.jsp?error=server");
       }
   }
}
