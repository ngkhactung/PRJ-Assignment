<%-- 
    Document   : instructor_profile.jsp
    Created on : Mar 7, 2024, 4:01:53 AM
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
        <table border="1px">
            <tr>
                <th>Code</th>
                <td>${requestScope.instructor.code}</td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td>${requestScope.instructor.name}</td>
            </tr>
            <tr>
                <th>Gender</th>
                <td>
                    <c:if test="${requestScope.instructor.gender}">
                        Male
                    </c:if>
                    <c:if test="${!requestScope.instructor.gender}">
                        Female
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>Image</th>
                <td>
                    <img src="${requestScope.instructor.image}" style="height:146px;width:111px"/>
                </td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${requestScope.instructor.phone}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${requestScope.instructor.email}</td>
            </tr>
        </table>
    </body>
</html>
