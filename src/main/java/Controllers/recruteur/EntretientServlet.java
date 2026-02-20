package Controllers.recruteur;

import DAO.CandidatureDAO;
import DAO.EntretienDAO;
import DAO.EntretienDAOImpl;
import Models.Candidature;
import Models.Entretien;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/recruteur/entretiens")
public class EntretientServlet extends HttpServlet {


    private EntretienDAO entretienDAO;

    @Override
    public void init() {
        entretienDAO = new EntretienDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("recruteurId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int recruteurId = (Integer) session.getAttribute("recruteurId");

        try {
            List<Entretien> entretiens = entretienDAO.getByRecruteurId(recruteurId);
            request.setAttribute("entretiens", entretiens);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des entretiens.");
        }

        request.getRequestDispatcher("/Views/recruteur/entretiens.jsp")
                .forward(request, response);
    }
}
