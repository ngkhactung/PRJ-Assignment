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
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1px">
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
    </body>
</html>
