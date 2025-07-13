// GenerateBillServlet.java
package servlet;

import util.DBUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/generatebill")
public class GenerateBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        String adminEmail = (session != null) ? (String) session.getAttribute("adminEmail") : null;

        if (adminEmail == null) {
            res.sendRedirect("jsp/adminlogin.jsp");
            return;
        }

        try {
            String clientEmail = req.getParameter("clientEmail");
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            double amount = Double.parseDouble(req.getParameter("amount"));

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO bills (appointment_id, client_email, amount, status) VALUES (?, ?, ?, 'Unpaid')"
            );
            ps.setInt(1, appointmentId);
            ps.setString(2, clientEmail);
            ps.setDouble(3, amount);
            ps.executeUpdate();

            res.setContentType("text/html");
            res.getWriter().println("<p style='color:green;'>Bill generated for " + clientEmail + "</p>");
            res.getWriter().println("<a href='jsp/adminmain.jsp'>Back to Dashboard</a>");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error generating bill.");
        }
    }
}
