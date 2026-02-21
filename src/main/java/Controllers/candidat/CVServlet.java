package Controllers.candidat;

import DAO.CVDAO;
import DAO.CVDAOImpl;
import Models.Cv;
import Models.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/candidat/cv")
@MultipartConfig(maxFileSize = 10485760) // 10MB
public class CVServlet extends HttpServlet {

    private CVDAO cvDAO = new CVDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if (user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        List<Cv> cvs = cvDAO.getByCandidatId(user.getIdUtilisateur());
        req.setAttribute("cvs", cvs);
        req.getRequestDispatcher("/Views/candidat/cv.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        utilisateur user = (utilisateur) session.getAttribute("user");

        if (user == null || !"CANDIDAT".equals(user.getRole())) {
            resp.sendRedirect("../../login.jsp");
            return;
        }

        try {
            String action = req.getParameter("action");

            if ("upload".equals(action)) {
                String titre = req.getParameter("titre");
                String competences = req.getParameter("competences");
                Part filePart = req.getPart("cvFile");

                // Validate file type (PDF only)
                String fileName = filePart.getSubmittedFileName();
                if (!fileName.toLowerCase().endsWith(".pdf")) {
                    resp.sendRedirect("cv?error=notpdf");
                    return;
                }

                // Create upload directory
                String uploadPath = getServletContext().getRealPath("/uploads/cvs");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // Save file with unique name
                String uniqueFileName = System.currentTimeMillis() + "_" + user.getIdUtilisateur() + "_" + fileName;
                filePart.write(uploadPath + File.separator + uniqueFileName);

                // Verify file was saved
                File savedFile = new File(uploadPath + File.separator + uniqueFileName);
                if(!savedFile.exists()) {
                    resp.sendRedirect("cv?error=filesave");
                    return;
                }

                // Save to DB
                Cv newCV = new Cv();
                newCV.setTitre(titre);
                newCV.setCheminFichier("uploads/cvs/" + uniqueFileName);
                newCV.setCompetences(competences);
                newCV.setDateMiseAJour(new Date());
                newCV.setCandidatId(user.getIdUtilisateur());

                System.out.println("Saving CV: " + newCV.getTitre() + " for candidat: " + newCV.getCandidatId());
                cvDAO.create(newCV);
                resp.sendRedirect("cv?success=uploaded");

            } else if ("delete".equals(action)) {
                int cvId = Integer.parseInt(req.getParameter("cvId"));
                cvDAO.delete(cvId);
                resp.sendRedirect("cv?success=deleted");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("cv?error=true");
        }
    }
}