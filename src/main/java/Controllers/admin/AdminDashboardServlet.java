package Controllers.admin;

import DAO.UtilisateurDAO;
import DAO.UtilisateurDaoIMP;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private UtilisateurDAO userDAO = new UtilisateurDaoIMP();
    private DAO.AnnonceDAO annonceDAO = new DAO.AnnonceDaoIMP();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String tab = req.getParameter("tab");
        if (tab == null || tab.isEmpty()) {
            tab = "dashboard";
        }
        req.setAttribute("activeTab", tab);

        try {
            // Global Stats
            int totalUsers = userDAO.countAll();
            int totalCompanies = userDAO.getTotalCompanies();
            int totalUniversities = userDAO.getTotalUniversities();
            int totalAnnonces = annonceDAO.countTotal();

            int pendingAds = annonceDAO.countPending();
            int pendingEntities = userDAO.countPendingEntities();

            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalCompanies", totalCompanies);
            req.setAttribute("totalUniversities", totalUniversities);
            req.setAttribute("totalAnnonces", totalAnnonces);
            req.setAttribute("pendingAds", pendingAds);
            req.setAttribute("pendingEntities", pendingEntities);

            // Tab specific data
            switch (tab) {
                case "users":
                    req.setAttribute("users", userDAO.findAllUsers());
                    break;
                case "entities":
                    req.setAttribute("allEntities", userDAO.findAllEntitiesDetails());
                    break;
                case "annonces":
                    req.setAttribute("allAnnonces", annonceDAO.findAllWithCompany());
                    break;
            }

            req.getRequestDispatcher("/Views/admin/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace(); // Crucial for debugging Task 4
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Dashboard Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");
        String idStr = req.getParameter("id"); // Generic ID param
        String currentTab = req.getParameter("tab");
        if (currentTab == null)
            currentTab = "dashboard";

        if (action != null && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                String msg = "";
                switch (action) {
                    case "suspend":
                        userDAO.updateStatus(id, "SUSPENDU");
                        msg = "Utilisateur suspendu avec succès";
                        break;
                    case "activate":
                    case "approve":
                        userDAO.updateStatus(id, "ACTIF");
                        msg = "Action effectuée avec succès";
                        break;
                    case "reject":
                        userDAO.updateStatus(id, "REJETE");
                        msg = "Demande rejetée";
                        break;

                    case "block_ad":
                        annonceDAO.toggleBlockStatus(id, true);
                        msg = "Annonce bloquée pour non-conformité";
                        break;
                    case "unblock_ad":
                        annonceDAO.toggleBlockStatus(id, false);
                        msg = "Annonce débloquée avec succès";
                        break;

                    case "block_entity":
                        userDAO.updateStatus(id, "BLOQUÉ");
                        // Cascade: block ads if recruiter
                        Models.utilisateur entity = userDAO.findById(id);
                        if (entity != null && "RECRUTEUR".equals(entity.getRole())) {
                            annonceDAO.blockAllAdsByRecruteur(id);
                            msg = "Structure bloquée et ses annonces ont été retirées";
                        } else {
                            msg = "Structure bloquée avec succès";
                        }
                        break;
                    case "activate_entity":
                        userDAO.updateStatus(id, "ACTIF");
                        msg = "Structure activée avec succès";
                        break;
                }
                if (!msg.isEmpty()) {
                    req.getSession().setAttribute("successMessage", msg);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard?tab=" + currentTab);
    }

}
