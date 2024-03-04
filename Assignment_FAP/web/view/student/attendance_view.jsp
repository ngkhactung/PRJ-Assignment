<%-- 
    Document   : attendance_view
    Created on : Mar 3, 2024, 10:43:49 PM
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
            <c:forEach items="${requestScope.groupList}" var="group">
                <p>
                    <c:if test="${requestScope.courseID == group.course.id}">
                        <b>${group.course.name} (${group.course.code} - ${group.name})</b>
                    </c:if>
                    <c:if test="${requestScope.courseID != group.course.id}">
                        <a href="attendance_view?courseID=${group.course.id}">
                            ${group.course.name} (${group.course.code} - ${group.name})</a>
                    </c:if>
                </p>
            </c:forEach>
        </div>

        <table border="1px">
            <tr>
                <th>No</th>
                <th>Date</th>
                <th>Slot</th>
                <th>Room</th>
                <th>Lecturer</th>
                <th>Group Name</th>
                <th>Attendance Status</th>
                <th>Lecture's Comment</th>
            </tr>

            <c:forEach items="${requestScope.sessList}" var="session" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>
                        <fmt:formatDate pattern="E dd/MM/yyyy" 
                                        value="${session.date}"/>
                    </td>
                    <td>
                        ${session.slot.id}_
                        (${session.slot.start}-${session.slot.end})
                    </td>
                    <td>${session.room.building.id}-${session.room.name}</td>
                    <td>${session.instructor.code}</td>
                    <td>${session.group.name}</td>
                    <td>
                        <c:forEach items="${requestScope.attList}" var="att">
                            <c:if test="${att.session.id == session.id}">
                                <c:if test="${att.status == null}">
                                    Not Yet
                                </c:if>
                                <c:if test="${att.status == true}">
                                    <p style="color: green">Attended</p>
                                </c:if>
                                <c:if test="${att.status == false}">
                                    <p style="color: red">Absent</p>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach items="${requestScope.attList}" var="att">
                            <c:if test="${att.session.id == session.id}">
                                ${att.note}
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
