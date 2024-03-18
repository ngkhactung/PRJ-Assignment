<%-- 
    Document   : profile
    Created on : Mar 7, 2024, 2:31:42 AM
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
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/profile.css"/>
        <script>
            function displayTranscript() {
                var tableTranscript = document.getElementById("transcriptTable");
                var buttonTranscript = document.getElementById("transcriptButton");
                tableTranscript.style.display = "table";
                buttonTranscript.value = "Hidden Transcript";
                buttonTranscript.onclick = hiddenTranscript;
            }

            function hiddenTranscript() {
                var tableTranscript = document.getElementById("transcriptTable");
                var buttonTranscript = document.getElementById("transcriptButton");
                tableTranscript.style.display = "none";
                buttonTranscript.value = "Academic Transcript";
                buttonTranscript.onclick = displayTranscript;
            }
        </script>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="profile" class="container px-5 py-2">
            <div class="row">
                <div class="col-md-4 col-12  ">
                    <div class="card wrap-table-card d-grid align-items-center ">
                        <div class="card-body px-2 py-md-0 py-4 text-center">
                            <img class="img-fluid img-border" src="${requestScope.student.image}" width="50%" height="auto" />
                            <h2 class="code">${requestScope.student.name}</h2>
                            <p class="sub-color">Student at FPT University</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-8 col-12 mt-md-0 mt-4">
                    <div class="wrap-table-card px-4 py-2">
                        <table class="table table-hover align-middle caption-top ">
                            <caption class="ms-2">Detail Information</caption>
                            <tr>
                                <th>Roll number</th>
                                <td class="sub-color">${requestScope.student.id}</td>
                            </tr>
                            <tr>
                                <th>Full Name</th>
                                <td class="sub-color">${requestScope.student.name}</td>
                            </tr>
                            <tr>
                                <th>Gender</th>
                                <td class="sub-color">
                                    <c:if test="${requestScope.student.gender}">
                                        Male
                                    </c:if>
                                    <c:if test="${!requestScope.student.gender}">
                                        Female
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>Date of birth</th>
                                <td class="sub-color">${requestScope.student.dob}</td>
                            </tr>
                            <tr>
                                <th>Phone</th>
                                <td class="sub-color">${requestScope.student.phone}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td class="sub-color">${requestScope.student.email}</td>
                            </tr>
                            <tr>
                                <th>Address</th>
                                <td class="sub-color">${requestScope.student.address}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <c:if test="${requestScope.resultList != null}">
            <input id="transcriptButton" type="button" value="Academic Transcript" onclick="displayTranscript()"/>

            <table id="transcriptTable" style="display: none" border="1px">
                <tr>
                    <th>NO</th>
                    <th>COURSE CODE</th>
                    <th>PREREQUISITE</th>
                    <th>REPLACED COURSE</th>
                    <th>COURSE NAME</th>
                    <th>CREDIT</th>
                    <th>GRADE</th>
                    <th>STATUS</th>
                </tr>

                <c:forEach items="${requestScope.resultList}" var="result" varStatus="loop">
                    <tr>
                        <td>${loop.count}</td>
                        <td>${result.course.code}</td>
                        <td>${result.course.preRequisite}</td>
                        <td>${result.course.replacedCourse}</td>
                        <td>${result.course.name}</td>
                        <td>${result.course.credit}</td>
                        <td>
                            <fmt:formatNumber pattern="##.#" 
                                              value="${result.average}"/>
                        </td>
                        <td>
                            <c:if test="${result.status == 'PASSED'}">
                                <b style="color: green">Passed</b>
                            </c:if>
                            <c:if test="${result.status == 'NOT PASSED'}">
                                <b style="color: red">Not passed</b>
                            </c:if>
                            <c:if test="${result.status == 'STUDYING'}">
                                <b style="color: aquamarine">Studying</b>
                            </c:if>
                        </td>
                    <tr>
                    </c:forEach>
            </table>
        </c:if>

        <br>
        <br>
        <br>
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
