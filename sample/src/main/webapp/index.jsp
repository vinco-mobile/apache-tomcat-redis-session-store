<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session</title>
</head>
<body>

<FONT COLOR="#0000FF">
    <p>Instance <%=InetAddress.getLocalHost()%></p>
</FONT>
<hr/>
<FONT COLOR="#CC0000">
    <p>Session Id : <%=request.getSession().getId()%></p>
    <p>Is it New Session : <%=request.getSession().isNew()%></p>
    <p>Session Creation Date : <%=new Date(request.getSession().getCreationTime())%></p>
    <p>Session Access Date : <%=new Date(request.getSession().getLastAccessedTime())%>></p>
</FONT>
<hr/>
<h2>User:</h2>
<p><strong>First Name: </strong> ${sessionScope.user.firstName}</p>
<p><strong>Last Name: </strong> ${sessionScope.user.lastName}</p>
<p><strong>Email: </strong>${sessionScope.user.email}</p>
<br>
<hr/>
<h1>Customer Sign Up</h1>

<form action="${pageContext.request.contextPath}/processcustomer" method="post">
    <label for="firstname">First Name : </label>
    <input type="text" name="firstname" id="firstname" value="${firstname}">
    <label for="lastname">Last Name:</label>
    <input type="text" name="lastname" id="lastname" value="${lastname}">
    <label for="email">Email: </label>
    <input type="text" name="email" id="email" value="${email}">
    <input type="submit" name="signup" value="Sign Up">
</form>
</body>
</html>