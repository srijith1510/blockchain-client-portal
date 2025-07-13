package servlet;

import util.AESUtil;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;

@WebServlet("/downloadDecrypted")
public class DownloadDecryptedServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String email = (String) session.getAttribute("clientEmail");

        if (email == null) {
            res.sendRedirect("jsp/clientlogin.jsp");
            return;
        }

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT file_path FROM appointments WHERE client_email = ? ORDER BY upload_time DESC LIMIT 1"
            );
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String encryptedPath = rs.getString("file_path");
                byte[] encrypted = Files.readAllBytes(Paths.get(encryptedPath));
                byte[] decrypted = AESUtil.decrypt(encrypted);

                // Prepare file for download
                res.setContentType("application/octet-stream");
                res.setHeader("Content-Disposition", "attachment; filename=\"decrypted_" + Paths.get(encryptedPath).getFileName().toString().replace("enc_", "") + "\"");
                res.getOutputStream().write(decrypted);
                res.getOutputStream().flush();
            } else {
                res.getWriter().println("No file found to download.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error during file download.");
        }
    }
}
