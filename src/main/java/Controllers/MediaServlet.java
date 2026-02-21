package Controllers;

import Utils.FileUploadConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/uploads/*")
public class MediaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the requested file path from the URL
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Decode the path (to handle spaces, etc.)
        String decodedPath = URLDecoder.decode(pathInfo, StandardCharsets.UTF_8);
        
        // Construct the absolute path to the file in the project source
        File file = new File(FileUploadConfig.UPLOAD_BASE_PATH, decodedPath);

        if (!file.exists() || !file.isFile()) {
            // Fallback to default behavior (maybe it's in the real context path)
            String realPath = getServletContext().getRealPath("/uploads" + decodedPath);
            if (realPath != null) {
                file = new File(realPath);
            }
        }

        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Set content type based on file extension
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);
        response.setContentLength((int) file.length());

        // Stream the file to the response
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
