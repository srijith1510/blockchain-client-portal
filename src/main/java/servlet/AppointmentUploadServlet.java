package servlet;

import util.AESUtil;
import util.DBUtil;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/uploadAppointment")
@MultipartConfig
public class AppointmentUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        try {
            HttpSession session = req.getSession(false);
            String email = (String) session.getAttribute("clientEmail");

            Part filePart = req.getPart("requirementFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Save path (adjust as needed)
            String uploadDir = getServletContext().getRealPath("/") + "uploads";
            new File(uploadDir).mkdirs(); // create if not exists

            String encryptedFilePath = uploadDir + File.separator + "enc_" + fileName;

            // Encrypt and save file
            byte[] fileBytes = filePart.getInputStream().readAllBytes();
            byte[] encrypted = AESUtil.encrypt(fileBytes);
            Files.write(Paths.get(encryptedFilePath), encrypted);

            // Save in DB
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO appointments (client_email, file_path, encrypted) VALUES (?, ?, true)"
            );
            ps.setString(1, email);
            ps.setString(2, encryptedFilePath);
            ps.executeUpdate();

            res.setContentType("text/html");
            res.getWriter().println("<p style='color:green;'>File uploaded and encrypted successfully!</p>");
            res.getWriter().println("<a href='jsp/clientmain.jsp'>Back to Dashboard</a>");
        } catch (Exception e) {
            e.printStackTrace();
            try {
                res.getWriter().println("<p style='color:red;'>Error uploading file.</p>");
            } catch (IOException ignored) {}
        }
    }
}
