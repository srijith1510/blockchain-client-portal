// DeleteBillServlet.java
package servlet;

import util.DBUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deletebill")
public class DeleteBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        String adminEmail = (session != null) ? (String) session.getAttribute("adminEmail") : null;

        if (adminEmail == null) {
            res.sendRedirect("jsp/adminlogin.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            String clientEmail = req.getParameter("clientEmail");

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM bills WHERE appointment_id = ? AND client_email = ?");
            ps.setInt(1, appointmentId);
            ps.setString(2, clientEmail);
            ps.executeUpdate();

            res.sendRedirect("jsp/adminmain.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error deleting bill.");
        }
    }
}
