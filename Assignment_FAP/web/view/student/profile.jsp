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
        <title>JSP Page</title>
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
        <img src="${requestScope.student.image}" style="height:146px;width:111px"/>
        <table border="1px">
            <tr>
                <th>Roll number</th>
                <td>${requestScope.student.id}</td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td>${requestScope.student.name}</td>
            </tr>
            <tr>
                <th>Gender</th>
                <td>
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
                <td>${requestScope.student.dob}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${requestScope.student.phone}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${requestScope.student.email}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${requestScope.student.address}</td>
            </tr>
        </table>

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
    </body>
</html>
