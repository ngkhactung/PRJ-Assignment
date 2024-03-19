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
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/grade_view.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="grade_view" class="container">
            <div class="row">
                <div class="col-md-5 col-12 mb-4">
                    <div class="wrap-info px-4 py-4">
                        <table class="table text-center mb-1">
                            <thead>
                            <th>COURSES</th>
                            </thead>
                            <c:forEach items="${requestScope.groupList}" var="group">
                                <tr>
                                    <c:if test="${param.courseID == group.course.id}">
                                        <td>
                                            <b>${group.course.name} (${group.course.code} - ${group.name})</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${param.courseID != group.course.id}">
                                        <td>
                                            <a href="grade_view?courseID=${group.course.id}">
                                                ${group.course.name} (${group.course.code} - ${group.name})</a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>

                <c:if test="${param.courseID != null}">
                    <div class="col-md-7 col-12">
                        <div class="wrap-result table-responsive-md p-4">
                            <table class="table align-middle table-sm ">
                                <thead>
                                <th>Grade Category</th>
                                <th>Grade Item</th>
                                <th>Weight</th>
                                <th>Value</th>
                                <th>Comment</th>
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
                                                    <fmt:formatNumber pattern="##" value="${item.assessment.weight*100}" />%
                                                </td>
                                                <td>${item.value}</td>
                                                <td>${item.comment}</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td>Total</td>
                                            <td>
                                                <fmt:formatNumber pattern="##" value="${category.key.weight*100}" />%
                                            </td>
                                            <td>
                                                <fmt:formatNumber pattern="0.0" value="${category.key.value}" />
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
                                                <fmt:formatNumber pattern="0.0" value="${requestScope.result.average}" />
                                            </c:if>
                                            <c:if test="${requestScope.result.average == null}">
                                                0.0
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>STATUS</td>
                                        <c:if test="${requestScope.result.status != 'NOT PASSED'}">
                                            <td style="color: green" colspan="3">${requestScope.result.status}</td>
                                        </c:if>
                                        <c:if test="${requestScope.result.status == 'NOT PASSED'}">
                                            <td style="color: red" colspan="3">${requestScope.result.status}</td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                        <td>Comment</td>
                                        <td colspan="3">${requestScope.result.comment}</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <br>
        <br>
        <br>

        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
