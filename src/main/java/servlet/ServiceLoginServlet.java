package servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/servicelogin")
public class ServiceLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Hardcoded credentials for now
        if (email.equals("team@example.com") && password.equals("team123")) {
            HttpSession session = req.getSession();
            session.setAttribute("teamEmail", email);
            res.sendRedirect("jsp/servicemain.jsp");
        } else {
            res.getWriter().println("Invalid credentials.");
        }
    }
}
