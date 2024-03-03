<%-- 
    Document   : attendance_review
    Created on : Mar 2, 2024, 11:57:56 PM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <p>Student group: ${requestScope.session.group.name}</p>
            <p>Course: ${requestScope.session.group.course.name}
                (${requestScope.session.group.course.code})</p>
            <p>Room: ${requestScope.session.room.building.id} 
                - ${requestScope.session.room.name}</p>
            <p>Slot: ${requestScope.session.slot.id}</p>
            <p>Date: <fmt:formatDate pattern="dd/MM/yyyy" 
                            value="${requestScope.session.date}"/></p>
        </div>
        <table border="1px">
            <tr>
                <th>Index</th>
                <th>ID</th>
                <th>Name</th>
                <th>Image</th>
                <th>Status</th>
                <th>Note</th>
                <th>Record Time</th>
            </tr>
            <c:forEach items="${requestScope.attList}" var="att" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
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
                            <p style="color: green">Attended</p>
                        </c:if>
                    </td>
                    <td>${att.note}</td>
                    <td>
                        <fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss" 
                                        value="${att.recordTime}"/>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <input type="button" value="Edit" 
               onclick="window.location.href = 'attendance_taking?sessId=${requestScope.session.id}'">
    </body>
</html>
