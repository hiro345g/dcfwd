<%@ page contentType="text/html; charset=utf-8" %>
<html>
<body>
<p>Hello JSP!</p>
<p><%= pageContext.getServletContext().getServerInfo() %></p>
<ul>
    <li>java.vm.name: <%= System.getProperty("java.vm.name") %></li>
    <li>java.vm.vendor: <%= System.getProperty("java.vm.vendor") %></li>
    <li>java.vm.version: <%= System.getProperty("java.vm.version") %></li>
</ul>
</body>
</html>