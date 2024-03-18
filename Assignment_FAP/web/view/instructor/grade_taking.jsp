<%-- 
    Document   : grade_taking
    Created on : Mar 4, 2024, 2:45:40 PM
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
        <link rel="stylesheet" href="/assign.fap.fpt/css/instructor/grade_taking.css"/>
        <script>
            function removeSuccess() {
                var message = document.getElementById("message");
                if (message !== null) {
                    message.remove();
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/instructor_menu.jsp"/>

        <br>
        <br>
        <br>
        <div id="grade_taksing" class="container">
            <div class="row justify-content-center ">
                <div class="col-md-6 col-12">
                    <div class="wrap-border p-md-4 p-2 ">
                        <table class="table align-middle mb-0">
                            <thead class="table-dark ">
                            <th>Course</th>
                            <th>Group Student</th>
                            </thead>
                            <c:forEach items="${requestScope.groupList}" var="group">
                                <tr>
                                    <td>${group.course.name} (${group.course.code})</td>
                                    <td>
                                        <c:if test="${param.groupID == group.id}">
                                            <b style="color: red">${group.name}</b>
                                        </c:if>
                                        <c:if test="${param.groupID != group.id}">
                                            <a href="grade_taking?groupID=${group.id}">${group.name}</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>

            <c:if test="${param.groupID != null}">
                <form action="grade_taking" method="POST">
                    <div class="row justify-content-center mt-5">
                        <div class="col-md-11 col-12 table-responsive-md">
                            <table class="table-grade table table-hover text-center align-middle">
                                <thead class="align-middle ">
                                <th>Student</th>
                                    <c:forEach items="${requestScope.assessList}" var="assess">
                                    <th>
                                        ${assess.name} <br>
                                        (<fmt:formatNumber pattern="##" value="${assess.weight*100}" />%)
                                    </th>
                                </c:forEach>
                                </thead>
                                <tbody>
                                    <c:forEach items="${group.students}" var="student">
                                        <tr>
                                            <td>${student.name}</td>
                                            <c:forEach items="${requestScope.assessList}" var="assess">
                                                <td>
                                                    <c:forEach items="${requestScope.gradeList}" var="grade">
                                                        <c:if test="${grade.assessment.id == assess.id 
                                                                      && grade.student.id == student.id}">
                                                              <input type="number"
                                                                     name="grade${grade.student.id}_${grade.assessment.id}"
                                                                     value="${grade.value}" min="0" max="10" step="0.1"
                                                                     maxlength="3" onfocus="removeSuccess()">
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-12 text-center ">
                            <div class="d-grid col-md-2 m-md-auto ">
                                <input type="submit" class="btn btn-dark btn-lg" value="Save">
                                <input type="hidden" name="groupID" value="${param.groupID}">
                            </div>
                            <c:if test="${param.save == true}">
                                <div id="message" class="mt-3">
                                    <h4><b>Save Successfully <i class="fa-regular fa-circle-check"></i> </b></h4>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </form>
            </c:if>
        </div>

        <br>
        <br>
        <br>
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
