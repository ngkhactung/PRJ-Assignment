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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
              integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/footer.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/header.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/menu.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/attendance_view.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="attendance_view" class="container">
            <div class="row">
                <div class="col-md-3 col-12 mb-4">
                    <div class="wrap-info px-2 py-4">
                        <table class="table text-center mb-1">
                            <thead class="table-light">
                            <th>COURSES</th>
                            </thead>
                            <c:forEach items="${requestScope.groupList}" var="group">
                                <tr>
                                    <c:if test="${requestScope.courseID == group.course.id}">
                                        <td>
                                            <b>${group.course.name} (${group.course.code} - ${group.name})</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${requestScope.courseID != group.course.id}">
                                        <td>
                                            <a href="attendance_view?courseID=${group.course.id}">
                                                ${group.course.name} (${group.course.code} - ${group.name})</a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>

                <div class="col-md-9 col-12">
                    <div class="wrap-result table-responsive-md p-2">
                        <table class="table text-center align-middle ">
                            <thead>
                            <th class="d-md-table-cell d-none ">No</th>
                            <th>Date</th>
                            <th>Slot</th>
                            <th>Room</th>
                            <th>Lecturer</th>
                            <th>Group Name</th>
                            <th>Attendance Status</th>
                            <th>Lecture's Comment</th>
                            </thead>

                            <tbody>
                                <c:forEach items="${requestScope.sessList}" var="session" varStatus="loop">
                                    <tr>
                                        <td class="d-md-table-cell d-none">${loop.count}</td>
                                        <td>
                                            <span class="date">
                                                <fmt:formatDate pattern="E dd/MM/yyyy" value="${session.date}" />
                                            </span>
                                        </td>
                                        <td>
                                            <span class="time">${session.slot.id}_
                                                (${session.slot.start}-${session.slot.end})</span>
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
                                                        <b style="color: green">Attended</b>
                                                    </c:if>
                                                    <c:if test="${att.status == false}">
                                                        <b style="color: red">Absent</b>
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
                            </tbody>

                            <tfoot>
                                <tr>
                                    <td colspan="7">
                                        <b class="total-absent">ABSENT: 
                                            <fmt:formatNumber pattern="##" value="${requestScope.totalAbsent*100/20}"/>%
                                            ABSENT SO FAR (${requestScope.totalAbsent} ABSENT ON 20 TOTAL)
                                        </b>
                                    </td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <br>
        <br>
        <br>

        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
