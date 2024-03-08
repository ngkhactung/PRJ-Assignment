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
        <title>JSP Page</title>
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
        <table border="1px">
            <tr>
                <th>Course</th>
                <th>Group Student</th>
            </tr>

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

        <c:if test="${param.groupID != null}">
            <form action="grade_taking" method="POST">
                <table border="1px">
                    <tr>
                        <th>Student</th>
                            <c:forEach items="${requestScope.assessList}" var="assess">
                            <th>
                                ${assess.name} <br> 
                                (<fmt:formatNumber pattern="##" 
                                                  value="${assess.weight*100}"/>%)
                            </th>
                        </c:forEach>
                    </tr>

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
                                                     value="${grade.value}" min="0" max="10" 
                                                     step="0.1" maxlength="3" onfocus="removeSuccess()">
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>

                <input type="hidden" name="groupID" value="${param.groupID}">
                <input type="submit" value="Save">
                <c:if test="${param.save == true}">
                    <b id="message" style="color: blue">Save successfully</b>
                </c:if>
            </form>
        </c:if>
    </body>
</html>
