<%-- 
    Document   : academic_transcript
    Created on : Mar 9, 2024, 4:06:55 PM
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
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/academic_transcript.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="academic_transcript" class="container px-3">
            <div class="row">
                <div class="col-12 table-responsive-md">
                    <table class="table">
                        <thead class="table-light">
                        <th>NO</th>
                        <th>COURSE CODE</th>
                        <th>PREREQUISITE</th>
                        <th>REPLACED COURSE</th>
                        <th>COURSE NAME</th>
                        <th>CREDIT</th>
                        <th>GRADE</th>
                        <th>STATUS</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.resultList}" var="result" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${result.course.code}</td>
                                    <td>${result.course.preRequisite}</td>
                                    <td>${result.course.replacedCourse}</td>
                                    <td>${result.course.name}</td>
                                    <td>${result.course.credit}</td>
                                    <td>
                                        <fmt:formatNumber pattern="##.#" value="${result.average}" />
                                    </td>
                                    <td>
                                        <c:if test="${result.status == 'PASSED'}">
                                            <span class="status" style="background-color: #5cb85c">Passed</span>
                                        </c:if>
                                        <c:if test="${result.status == 'NOT PASSED'}">
                                            <span class="status" style="background-color: red">Not passed</span>
                                        </c:if>
                                        <c:if test="${result.status == 'STUDYING'}">
                                            <span class="status" style="background-color: #5bc0de">Studying</span>
                                        </c:if>
                                    </td>
                                <tr>
                                </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <br>
        <br>
        <br>

        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
