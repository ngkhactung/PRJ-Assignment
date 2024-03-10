<%-- 
    Document   : login
    Created on : Mar 10, 2024, 1:57:45 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="login" method="POST">
            Username : <input type="text" name="username" 
                              <c:if test="${param.username != null}">
                                  value="${param.username}"
                              </c:if>
                              <c:if test="${param.username == null}">
                                  value="${cookie.cookieUser.value}"
                              </c:if>
                              autofocus required/> <br>
            Password : <input type="password" name="password" 
                              <c:if test="${param.password != null}">
                                  value="${param.password}"
                              </c:if>
                              <c:if test="${param.password == null}">
                                  value="${cookie.cookiePass.value}"
                              </c:if>
                              required/> <br>
            Remember me : <input type="checkbox" name="remember" 
                                 <c:if test="${cookie.cookieRem.value != null}">
                                     checked
                                 </c:if>
                                 value="remember"/> <br>
            <input type="submit" value="Login"/>

            <c:if test="${not empty requestScope.message}">
                <p style="color: red">${requestScope.message}</p>
            </c:if>
        </form>
    </body>
</html>
