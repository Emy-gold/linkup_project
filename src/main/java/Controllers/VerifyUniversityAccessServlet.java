package Controllers;

import DAO.UniversiteDAO;
import DAO.UniversiteDAOImpl;
import Models.Universite;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/verify-university-access")
public class VerifyUniversityAccessServlet extends HttpServlet {
    private UniversiteDAO universiteDAO;

    @Override
    public void init() throws ServletException {
        this.universiteDAO = new UniversiteDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String idUniversiteStr = request.getParameter("id_universite");
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;

        JsonObject jsonResponse = new JsonObject();

        if (idUniversiteStr == null || email == null || password == null) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Paramètres manquants.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        try {
            int idUniversite = Integer.parseInt(idUniversiteStr);
            Universite universite = universiteDAO.getUniversiteById(idUniversite);

            if (universite != null) {
                // Debug logs
                System.out.println("Verification Attempt for ID: " + idUniversite);
                System.out.println("Input Email: " + email);
                System.out.println("Input Password: " + password);
                System.out.println("Stored Contact Email: " + universite.getEmailContact());
                System.out.println("Stored Agent Email: " + universite.getEmail());
                System.out.println("Stored Password: " + universite.getUniversityPassword());

                // Vérifier d'abord si le mot de passe de l'université est défini
                if (universite.getUniversityPassword() == null) {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Aucun mot de passe configuré pour cette université.");
                } else {
                    // Vérification : L'email peut être SOIT l'email de contact (université) SOIT l'email de l'agent (utilisateur)
                    boolean emailMatch = email.equalsIgnoreCase(universite.getEmailContact()) || email.equalsIgnoreCase(universite.getEmail());
                    boolean passwordMatch = password.equals(universite.getUniversityPassword());

                    if (emailMatch && passwordMatch) {
                        jsonResponse.addProperty("success", true);
                    } else {
                        jsonResponse.addProperty("success", false);
                        String errorMsg = "Email ou mot de passe incorrect.";
                        if (!emailMatch) errorMsg += " (Email attendu : " + universite.getEmailContact() + " ou " + universite.getEmail() + ")";
                        jsonResponse.addProperty("message", errorMsg);
                        // Log failure reason
                        System.out.println("Verification failed. EmailMatch: " + emailMatch + ", PasswordMatch: " + passwordMatch);
                    }
                }
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Université non trouvée.");
            }

        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "ID université invalide.");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Erreur serveur : " + e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }
}
