<%-- 
    Document   : grade_view
    Created on : Mar 5, 2024, 10:43:46 AM
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
                    <c:if test="${param.courseID == group.course.id}">
                        <b>${group.course.name} (${group.course.code} - ${group.name})</b>
                    </c:if>
                    <c:if test="${param.courseID != group.course.id}">
                        <a href="grade_view?courseID=${group.course.id}">
                            ${group.course.name} (${group.course.code} - ${group.name})</a>
                    </c:if>
                </p>
            </c:forEach>
        </div>

        <c:if test="${param.courseID != null}">
            <table border="1px">
                <tr>
                    <th>Grade Category</th>
                    <th>Grade Item</th>
                    <th>Weight</th>
                    <th>Value</th>
                    <th>Comment</th>
                </tr>

                <c:forEach items="${requestScope.assessList}" var="assess">
                    <tr>
                        <td>${assess.type}</td>
                        <td>${assess.name}</td>
                        <td>
                            <fmt:formatNumber pattern="##.#" 
                                     value="${assess.weight*100}"/>%
                        </td>
                        <td>
                            <c:forEach items="${requestScope.gradeList}" var="grade">
                                <c:if test="${grade.value != null && grade.assessment.id == assess.id}">
                                    ${grade.value}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach items="${requestScope.gradeList}" var="grade">
                                <c:if test="${grade.comment != null && grade.assessment.id == assess.id}">
                                    ${grade.comment}
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </body>
</html>
