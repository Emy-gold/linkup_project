package Controllers;

import DAO.RecruteurDAO;
import DAO.RecruteurDAOImpl;
import DAO.UtilisateurDAO;
import DAO.UtilisateurDaoIMP;
import Models.Recruteur;
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

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            utilisateur u = userDAO.login(req.getParameter("email"), req.getParameter("password"));

            if (u != null) {
                // Check if account is suspended
                if ("SUSPENDU".equals(u.getStatutCompte())) {
                    req.setAttribute("error", "Votre compte a été suspendu par l'administrateur.");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    return;
                }

                HttpSession session = req.getSession();
                session.setAttribute("user", u);
                session.setAttribute("userId", u.getIdUtilisateur());
                session.setAttribute("role", u.getRole());

                switch (u.getRole()) {

                    case "CANDIDAT":
                        resp.sendRedirect(req.getContextPath() + "/candidat/dashboard");
                        break;
                    case "RECRUTEUR":

                        RecruteurDAO recruteurDAO = new RecruteurDAOImpl();
                        int userId = u.getIdUtilisateur();
                        Recruteur recruteur = recruteurDAO.getByUserId(userId);

                        if (recruteur != null) {

                            // STOCKER EN SESSION (IMPORTANT)
                            session.setAttribute("recruteur", recruteur);
                            session.setAttribute("recruteurId", recruteur.getRecruteurId());

                            resp.sendRedirect(req.getContextPath() + "/recruteur/dashboard");

                        } else {
                            resp.sendRedirect(req.getContextPath() + "/recruteur/complete-profile");
                        }

                        break;

                    case "ADMIN":
                        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                        break;
                    case "AGENT_UNIV":
                        DAO.UniversiteDAO univDAO = new DAO.UniversiteDAOImpl();
                        Models.Universite univ = univDAO.getUniversiteByAgentId(u.getIdUtilisateur());
                        if (univ != null) {
                            session.setAttribute("universite", univ);
                            resp.sendRedirect(req.getContextPath() + "/universite-dashboard");
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/universite-complete-profile");
                        }
                        break;
                    default:
                        resp.sendRedirect("/login.jsp?error=invalid_role");
                        break;
                }
            } else {
                resp.sendRedirect("login.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=server");
        }
    }
}
