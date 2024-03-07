<%-- 
    Document   : session_detail
    Created on : Mar 3, 2024, 8:36:38 PM
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
            <p>Date: <fmt:formatDate pattern="E dd/MM/yyyy" 
                     value="${requestScope.session.date}"/></p>
            <p>Slot: ${requestScope.session.slot.id}</p>
            <p>Student group: ${requestScope.session.group.name}</p>
            <p>Instructor: 
                <a href="../instructor/profile?instrucID=${requestScope.session.instructor.id}">
                    ${requestScope.session.instructor.code}</a>
            </p>
            <p>Course: ${requestScope.session.group.course.name}
                (${requestScope.session.group.course.code})</p>
            <p>Room: ${requestScope.session.room.building.id} 
                - ${requestScope.session.room.name}</p>
            <p>
                Attendance: 
                <c:if test="${requestScope.att.status == null}">
                    Not Yet
                </c:if>
                <c:if test="${requestScope.att.status == true}">
                    <p style="color: green">Attended</p>
                </c:if>
                <c:if test="${requestScope.att.status == false}">
                    <p style="color: red">Absent</p>
                </c:if>
            </p>
            <p>
                Record time: 
                <c:if test="${requestScope.att.recordTime == null}">
                    Not Yet
                </c:if>
                <c:if test="${requestScope.att.recordTime != null}">
                    <fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss" 
                                    value="${requestScope.att.recordTime}"/>
                </c:if>
            </p>
        </div>

        <p>Member List of Group</p>
        <table border="1px">
            <tr>
                <th>Index</th>
                <th>Image</th>
                <th>Member</th>
                <th>Full Name</th>
                <th>Email</th>
            </tr>
            <c:forEach items="${requestScope.group.students}" var="student" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>
                        <img src="${student.image}" style="height:146px;width:111px"/>
                    </td>
                    <td>${student.id}</td>
                    <td>${student.name}</td>
                    <td>${student.email}</td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
