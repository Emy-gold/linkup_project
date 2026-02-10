package Controllers.recruteur;

import DAO.AnnonceDAOImpl;
import Models.Annonce;
import DAO.AnnonceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/recruteur/annonces")
public class AnnonceServlet extends HttpServlet {

    private AnnonceDAO annonceDAO;

    @Override
    public void init(){
        annonceDAO = new AnnonceDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // récuperer donnée form
        String titre = request.getParameter("titre");
        String description = request.getParameter("descriptionPoste");
        String typeContrat = request.getParameter("typeContrat");
        String statut = request.getParameter("statutAnnonce");

        //recuperer sesion recruteur




        // Creat Annonce Object
        Annonce annonce = new Annonce();
        //annonce.setRecruteurId(recruteurId);
        annonce.setTitre(titre);
        annonce.setDescriptionPoste(description);
        annonce.setTypeContrat(typeContrat);
        annonce.setStatutAnnonce(statut);
        annonce.setDatePublication(new Date());
        // Saving:
        annonceDAO.create(annonce);

        response.sendRedirect(request.getContextPath() + "/recruteur/annonces");


    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Logique pour afficher les annonces

        request.getRequestDispatcher("/Views/recruteur/annonces.jsp").forward(request, response);
    }

}
