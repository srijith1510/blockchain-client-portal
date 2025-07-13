package servlet;

import util.DBUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            String clientEmail = req.getParameter("clientEmail");
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO feedback (client_email, appointment_id, rating, comment) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, clientEmail);
            ps.setInt(2, appointmentId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            ps.executeUpdate();

            res.setContentType("text/html");
            PrintWriter out = res.getWriter();
            out.println("<p style='color:green;'>Feedback submitted successfully!</p>");
            out.println("<a href='jsp/clientmain.jsp'>Back to Dashboard</a>");
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error submitting feedback.");
        }
    }
}
