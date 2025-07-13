package servlet;

import util.DBUtil;
import util.SHAUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/clientlogin")
public class ClientLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            String hashedPass = SHAUtil.hash(password);
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM clients WHERE email = ? AND password_hash = ?"
            );
            ps.setString(1, email);
            ps.setString(2, hashedPass);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("clientEmail", email);
                res.sendRedirect("jsp/clientmain.jsp");
            } else {
                res.sendRedirect("jsp/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("jsp/error.jsp");
        }
    }
}
