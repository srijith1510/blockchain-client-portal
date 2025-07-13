package servlet;

import util.DBUtil;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;

@WebServlet("/uploadDelivery")
@MultipartConfig
public class UploadDeliveryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        try {
            String clientEmail = req.getParameter("clientEmail");
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            Part filePart = req.getPart("deliveryFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadDir = getServletContext().getRealPath("/") + "delivered";
            new File(uploadDir).mkdirs();
            String filePath = uploadDir + File.separator + "delivered_" + fileName;

            byte[] fileBytes = filePart.getInputStream().readAllBytes();
            Files.write(Paths.get(filePath), fileBytes);

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO deliveries (appointment_id, client_email, file_path) VALUES (?, ?, ?)"
            );
            ps.setInt(1, appointmentId);
            ps.setString(2, clientEmail);
            ps.setString(3, filePath);
            ps.executeUpdate();

            res.setContentType("text/html");
            res.getWriter().println("Delivery uploaded successfully.<br>");
            res.getWriter().println("<a href='jsp/servicemain.jsp'>Back</a>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
