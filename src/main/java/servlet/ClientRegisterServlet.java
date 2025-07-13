package servlet;

import util.DBUtil;
import util.SHAUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/clientreg")  // ✅ This manually maps the servlet to your form
public class ClientRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String phone = req.getParameter("phonenumber");
        String password = req.getParameter("password");

        try {
            String hashedPass = SHAUtil.hash(password);
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO clients (username, email, phone, password_hash) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, hashedPass);
            ps.executeUpdate();

            res.sendRedirect("jsp/clientlogin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("jsp/error.jsp");
        }
    }
}
