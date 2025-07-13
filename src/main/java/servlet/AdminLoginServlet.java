package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminlogin")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Hardcoded admin credentials (you can make DB-based if you want)
        if (email.equals("admin@example.com") && password.equals("admin123")) {
            HttpSession session = req.getSession();
            session.setAttribute("adminEmail", email);
            res.sendRedirect("jsp/adminmain.jsp");
        } else {
            res.getWriter().println("Invalid admin credentials");
        }
    }
}
