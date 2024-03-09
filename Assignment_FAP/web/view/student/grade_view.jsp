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
                <thead>
                    <tr>
                        <th>Grade Category</th>
                        <th>Grade Item</th>
                        <th>Weight</th>
                        <th>Value</th>
                        <th>Comment</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${requestScope.categories.entrySet()}" var="category">
                        <tr>
                            <td rowspan="${category.value.size() + 2}">${category.key.name}</td>
                        </tr>
                        <c:forEach items="${category.value}" var="item">
                            <tr>
                                <td>${item.assessment.name}</td>
                                <td>
                                    <fmt:formatNumber pattern="##" 
                                                      value="${item.assessment.weight*100}"/>%
                                </td>
                                <td>${item.value}</td>
                                <td>${item.comment}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>Total</td>
                            <td>
                                <fmt:formatNumber pattern="##" 
                                                  value="${category.key.weight*100}"/>%
                            </td>
                            <td>
                                <fmt:formatNumber pattern="0.0" 
                                                  value="${category.key.value}"/>
                            </td>
                            <td></td>
                        </tr>
                    </c:forEach>
                </tbody>

                <tfoot>
                    <tr>
                        <td rowspan="3">COURSE TOTAL</td>
                        <td>AVERAGE</td>
                        <td colspan="3">
                            <c:if test="${requestScope.result.average != null}">
                                <fmt:formatNumber pattern="0.0" 
                                                  value="${requestScope.result.average}"/>
                            </c:if>
                            <c:if test="${requestScope.result.average == null}">
                                0.0
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td>STATUS</td>
                        <c:if test="${requestScope.result.status != 'NOT PASSED'}">
                            <td style="color: green"colspan="3">${requestScope.result.status}</td>
                        </c:if>
                        <c:if test="${requestScope.result.status == 'NOT PASSED'}">
                            <td style="color: red"colspan="3">${requestScope.result.status}</td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>Comment</td>
                        <td colspan="3">${requestScope.result.comment}</td>
                    </tr>
                </tfoot>
            </table>
        </c:if>
    </body>
</html>
