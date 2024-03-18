<%-- 
    Document   : search_student
    Created on : Mar 6, 2024, 10:46:30 PM
    Author     : Admin
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <link rel="stylesheet" href="/assign.fap.fpt/css/instructor/search_student.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/instructor_menu.jsp"/>

        <br>
        <br>
        <br>
        <div id="search_student" class="container">
            <div class="row">
                <div class="col-md-5 col-12">
                    <div class="wrap-search p-4">
                        <form action="search_student" method="POST">
                            <table class="table caption-top">
                                <caption class="ms-2 mb-3 p-0">Filter Options</caption>
                                <tr>
                                    <th>Student ID:</th>
                                    <td>
                                        <input type="text" name="studentID" value="${param.studentID}">
                                    </td>
                                </tr>
                                <tr>
                                    <th>Student Name:</th>
                                    <td>
                                        <input type="text" name="name" value="${param.name}">
                                    </td>
                                </tr>
                                <tr>
                                    <th>Gender:</th>
                                    <td>
                                        <input type="radio" name="gender" 
                                               <c:if test="${param.gender == true}">
                                                   checked
                                               </c:if> value="true"> Male
                                        <input type="radio" name="gender" 
                                               <c:if test="${not empty param.gender && param.gender == false}">
                                                   checked
                                               </c:if> value="false"> Female
                                        <input type="radio" name="gender" 
                                               <c:if test="${empty param.gender}">
                                                   checked
                                               </c:if> value=""> All
                                    </td>
                                </tr>
                                <tr>
                                    <th>DoB from:</th>
                                    <td>
                                        <input type="date" name="from" value="${param.from}">
                                    </td>
                                </tr>
                                <tr>
                                    <th>DoB to:</th>
                                    <td>
                                        <input type="date" name="to" value="${param.to}">
                                    </td>
                                </tr>
                                <tr>
                                    <th>Group Name:</th>
                                    <td>
                                        <select name="groupName">
                                            <option value="">All</option>
                                            <c:forEach items="${requestScope.groupNameList}" var="group">
                                                <option <c:if test="${group.name == param.groupName}">
                                                        selected
                                                    </c:if>
                                                    value="${group.name}">${group.name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                            </table>

                            <div class="d-grid col-md-5 col-12 mx-md-auto py-2 mt-4">
                                <input type="submit" class="btn button-search btn-outline-dark" value="Search">
                            </div>
                        </form>
                                    
                        <c:if test="${requestScope.message != null }">
                            <div class="text-center mt-3 message">
                                <b>No students were found matching the conditions</b>
                            </div>
                        </c:if>
                    </div>
                </div>

                <c:if test="${not empty requestScope.studentList}">
                    <div class="col-md-7 col-12">
                        <div class="wrap-result ms-md-3 mt-md-0 mt-3">
                            <table class="table">
                                <thead>
                                <th class="d-md-table-cell d-none">Index</th>
                                <th>Image</th>
                                <th>StudentID</th>
                                <th>Student Name</th>
                                </thead>

                                <tbody>
                                    <c:forEach items="${requestScope.studentList}" var="student" varStatus="loop">
                                        <tr>
                                            <td class="d-md-table-cell d-none">${loop.count}</td>
                                            <td>
                                                <img src="${student.image}" style="height:146px;width:111px" />
                                            </td>
                                            <td>
                                                <a href="../student/profile?studentID=${student.id}">
                                                    ${student.id}</a>
                                            </td>
                                            <td>
                                                <a href="../student/profile?studentID=${student.id}">
                                                    ${student.name}</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
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
