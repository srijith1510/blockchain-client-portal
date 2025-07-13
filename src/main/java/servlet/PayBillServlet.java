package servlet;

import util.DBUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/paybill")
public class PayBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        try {
            int billId = Integer.parseInt(req.getParameter("billId"));

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE bills SET status = 'Paid' WHERE id = ?"
            );
            ps.setInt(1, billId);
            int rows = ps.executeUpdate();

            res.setContentType("text/html");
            PrintWriter out = res.getWriter();
            if (rows > 0) {
                out.println("<p style='color:green;'>Bill marked as paid.</p>");
            } else {
                out.println("<p style='color:red;'>Failed to update bill.</p>");
            }
            out.println("<a href='jsp/clientmain.jsp'>Back to Dashboard</a>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
