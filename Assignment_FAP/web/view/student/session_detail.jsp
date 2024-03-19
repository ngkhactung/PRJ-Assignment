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
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/session_detail.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>
        <div id="session_detail" class="container">
            <div class="row justify-content-center ">
                <div class="col-md-8 col-12">
                    <div class="wrap-info p-4 table-responsive-md ">
                        <table class="table">
                            <tr>
                                <th>Course: </th>
                                <td colspan="3">${requestScope.session.group.course.name}
                                    (${requestScope.session.group.course.code})</td>
                            </tr>
                            <tr>
                                <th>Group:</th>
                                <td>${requestScope.session.group.name}</td>
                                <th>Instructor:</th>
                                <td><a href="../instructor/profile?instrucID=${requestScope.session.instructor.id}">
                                    ${requestScope.session.instructor.code}</td>
                            </tr>
                            <tr>
                                <th>Slot:</th>
                                <td>${requestScope.session.slot.id}</td>
                                <th>Date:</th>
                                <td>
                                    <fmt:formatDate pattern="E dd/MM/yyyy" value="${requestScope.session.date}" />
                                </td>
                            </tr>
                            <tr>
                                <th>Attendance:</th>
                                <td>
                                    <c:if test="${requestScope.att.status == null}">
                                        Not Yet
                                    </c:if>
                                    <c:if test="${requestScope.att.status == true}">
                                        <b style="color: green">Attended</b>
                                    </c:if>
                                    <c:if test="${requestScope.att.status == false}">
                                        <b style="color: red">Absent</b>
                                    </c:if>
                                </td>
                                <th>Record time:</th>
                                <td>
                                    <c:if test="${requestScope.att.recordTime == null}">
                                        Not Yet
                                    </c:if>
                                    <c:if test="${requestScope.att.recordTime != null}">
                                        <fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss"
                                                        value="${requestScope.att.recordTime}" />
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-12">
                    <div class="wrap-list px-md-5 py-md-2 table-responsive-md">
                        <table class="table text-center align-middle">
                            <thead class="table-light">
                            <th class="d-md-table-cell d-none">Index</th>
                            <th>Image</th>
                            <th>Member</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            </thead>

                            <tbody>
                                <c:forEach items="${requestScope.group.students}" var="student" varStatus="loop">
                                    <tr>
                                        <td>${loop.count}</td>
                                        <td>
                                            <img src="${student.image}" style="height:146px;width:111px" />
                                        </td>
                                        <td>${student.id}</td>
                                        <td>${student.name}</td>
                                        <td>${student.email}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
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
