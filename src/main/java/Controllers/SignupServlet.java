package Controllers;

import DAO.CandidatDAO;
import DAO.CandidatDAOImpl;
import DAO.UtilisateurDAO;
import DAO.UtilisateurDaoIMP;
import Models.Candidat;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO = new UtilisateurDaoIMP(); // ← Instance

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        CandidatDAO candidatDAO = new CandidatDAOImpl();
        String role = req.getParameter("role");

        try {
            // 1. Insert into utilisateur
            utilisateur u = new utilisateur(
                    req.getParameter("email"),
                    req.getParameter("password"),
                    req.getParameter("nom"),
                    req.getParameter("prenom"),
                    role,
                    new Date(),
                    "ACTIF");

            utilisateurDAO.create(u);

            System.out.println("✅ Utilisateur créé avec ID: " + u.getIdUtilisateur());

            // 2. Insert into candidat table if role is CANDIDAT
            if ("CANDIDAT".equals(role)) {
                Candidat c = new Candidat();
                c.setIdUtilisateur(u.getIdUtilisateur());
                c.setTitreProfil(null);
                c.setDisponibilite(null);
                candidatDAO.create(c);
                System.out.println("✅ Candidat créé dans table candidat");
            }

            resp.sendRedirect("login.jsp?success=true");

        } catch (Exception e) {
            System.out.println("❌ Erreur signup: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("signup.jsp?error=server");
        }
    }
}