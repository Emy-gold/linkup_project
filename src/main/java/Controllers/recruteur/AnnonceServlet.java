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

@WebServlet("/recruteur/annonces/*")
public class AnnonceServlet extends HttpServlet {

    private AnnonceDAO annonceDAO;

    @Override
    public void init() {
        annonceDAO = new AnnonceDAOImpl();
    }

    // GET ROUTES
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        String action = request.getPathInfo(); // /edit /

        if (action == null || action.equals("/")) {
            listAnnonces(request, response, recruteurId);
        } else if (action.equals("/delete")) {
            deleteAnnonce(request, response);
        }
    }

    // ============
    // POST ROUTES
    // ============
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        String action = request.getPathInfo();

        if (action == null || action.equals("/")) {
            createAnnonce(request, response, recruteurId);
        } else if (action.equals("/update")) {
            updateAnnonce(request, response);
        }
    }

    // ========
    // METHODS
    // ========

    private void listAnnonces(HttpServletRequest request, HttpServletResponse response, int recruteurId)
            throws ServletException, IOException {

        List<Annonce> annonces = annonceDAO.getByRecruteurId(recruteurId);

        request.setAttribute("annonces", annonces);

        request.getRequestDispatcher("/Views/recruteur/annonces.jsp")
                .forward(request, response);
    }

    private void createAnnonce(HttpServletRequest request, HttpServletResponse response, int recruteurId)
            throws IOException {

        Annonce annonce = new Annonce();

        annonce.setRecruteurId(recruteurId);
        annonce.setTitre(request.getParameter("titre"));
        annonce.setDescription(request.getParameter("descriptionPoste"));
        annonce.setTypeContrat(request.getParameter("typeContrat"));
        annonce.setStatutAnnonce(request.getParameter("statutAnnonce"));
        annonce.setDatePublication(new Date());

        annonceDAO.create(annonce);

        response.sendRedirect(request.getContextPath() + "/recruteur/annonces");
    }

    // update Annonce
    private void updateAnnonce(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("idAnnonce"));

        Annonce annonce = annonceDAO.getById(id);

        annonce.setTitre(request.getParameter("titre"));
        annonce.setDescription(request.getParameter("description"));
        annonce.setTypeContrat(request.getParameter("typeContrat"));
        annonce.setStatutAnnonce(request.getParameter("statutAnnonce"));

        annonceDAO.update(annonce);

        response.sendRedirect(request.getContextPath() + "/recruteur/annonces");
    }

    // DeleteAnnonce:
    private void deleteAnnonce(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        annonceDAO.delete(id);

        response.sendRedirect(request.getContextPath() + "/recruteur/annonces");
    }

}
