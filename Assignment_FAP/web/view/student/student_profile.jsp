<%-- 
    Document   : profile
    Created on : Mar 7, 2024, 2:31:42 AM
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
        <img src="${requestScope.student.image}" style="height:146px;width:111px"/>
        <table border="1px">
            <tr>
                <th>Roll number</th>
                <td>${requestScope.student.id}</td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td>${requestScope.student.name}</td>
            </tr>
            <tr>
                <th>Gender</th>
                <td>
                    <c:if test="${requestScope.student.name}">
                        Male
                    </c:if>
                    <c:if test="${!requestScope.student.name}">
                        Female
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>Date of birth</th>
                <td>${requestScope.student.dob}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${requestScope.student.phone}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${requestScope.student.email}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${requestScope.student.address}</td>
            </tr>
        </table>
    </body>
</html>
