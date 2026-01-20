package internal.dev;

import java.io.IOException;
import java.io.PrintWriter;

// import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// @WebServlet("/app")
public class ServletApp extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
    res.setContentType("text/html; charset=utf-8");
    try (PrintWriter out = res.getWriter()) {
      out.println("<html><body>");
      out.println("<p>Hello, webapp001!</p>");
      out.println(getServletContext().getServerInfo());
      out.println("</body></html>");
    }
  }
}
