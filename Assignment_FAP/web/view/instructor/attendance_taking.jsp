<%-- 
    Document   : attendance_taking.jsp
    Created on : Mar 2, 2024, 6:25:52 PM
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
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
              integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/footer.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/header.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/menu.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/instructor/attendance_taking.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/instructor_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="attendance_taking" class="container">
            <div class="row justify-content-center ">
                <div class="col-md-6 col-12">
                    <div class="wrap-info p-3">
                        <table class="table">
                            <tr>
                                <th>Group:</th>
                                <td>${requestScope.session.group.name}</td>
                                <th>Slot:</th>
                                <td>${requestScope.session.slot.id}</td>
                            </tr>
                            <tr>
                                <th>Room:</th>
                                <td>${requestScope.session.room.building.id} -
                                    ${requestScope.session.room.name}</td>
                                <th>Date:</th>
                                <td>
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${requestScope.session.date}" />
                                </td>
                            </tr>
                            <tr>
                                <th>Course: </th>
                                <td colspan="3">${requestScope.session.group.course.name}
                                    (${requestScope.session.group.course.code})</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <form action="attendance_taking" method="POST">
                <input type="hidden" name="sessionID" value="${requestScope.session.id}">
                <div class="row mt-5">
                    <div class="col-12">
                        <div class="wrap-list table-responsive-md">
                            <table class="table text-center align-middle">
                                <thead class="table-light">
                                <th>Index</th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Status</th>
                                <th>Note</th>
                                <th class="d-md-table-cell d-none">Record Time</th>
                                </thead>

                                <tbody>
                                    <c:forEach items="${requestScope.attList}" var="att" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${att.student.id}</td>
                                            <td>${att.student.name}</td>
                                            <td>
                                                <img src="${att.student.image}" style="height:146px;width:111px" />
                                            </td>
                                            <td>
                                                <input type="radio" <c:if test="${att.status == false}">
                                                       checked="checked"
                                                    </c:if>
                                                    name="status${att.student.id}" value="false"/> Absent
                                                <input type="radio" <c:if test="${att.status == true}">
                                                       checked="checked"
                                                    </c:if>
                                                    name="status${att.student.id}" value="true"/> Present
                                            </td>
                                            <td>
                                                <input type="text" name="note${att.student.id}" value="${att.note}">
                                            </td>
                                            <td class="d-md-table-cell d-none">
                                                <fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss" value="${att.recordTime}" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-12 text-center ">
                        <div class="d-grid col-md-2 m-md-auto ">
                            <input type="submit" class="btn btn-dark btn-lg" value="Save">
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <br>
        <br>
        <br>
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
