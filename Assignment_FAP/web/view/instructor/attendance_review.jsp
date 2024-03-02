<%-- 
    Document   : attendance_review
    Created on : Mar 2, 2024, 11:57:56 PM
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
        <div>
            <p>Class: ${requestScope.session.group.name}</p>
            <p>Course: ${requestScope.session.group.course.code} 
                - ${requestScope.session.group.course.name}</p>
            <p>Room: ${requestScope.session.room.building.id} 
                - ${requestScope.session.room.name}</p>
            <p>Slot: ${requestScope.session.slot.id}</p>
            <p>Date: ${requestScope.session.date}</p>
        </div>
        <table border="1px">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Image</th>
                <th>Status</th>
                <th>Note</th>
                <th>Record Time</th>
            </tr>
            <c:forEach items="${requestScope.attList}" var="att">
                <tr>
                    <td>${att.student.id}</td>
                    <td>${att.student.name}</td>
                    <td>
                        <img src="${att.student.image}" style="height:146px;width:111px"/>
                    </td>
                    <td>
                        <c:if test="${att.status == false}">
                            <p style="color: red">Absent</p>
                        </c:if>
                        <c:if test="${att.status == true}">
                            <p style="color: green">Attendanced</p>
                        </c:if>
                    </td>
                    <td>${att.note}</td>
                    <td>${att.recordTime}</td>
                </tr>
            </c:forEach>
        </table>
        <input type="button" value="Edit" 
               onclick="window.location.href = 'attendance_taking?sessId=${requestScope.session.id}'">
    </body>
</html>
