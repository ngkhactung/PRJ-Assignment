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
        <title>JSP Page</title>
    </head>
    <body>
        <form action="search_student" method="POST">
            Student ID :<input type="text" name="studentID" value="${param.studentID}"> <br>
            Student Name :<input type="text" name="name" value="${param.name}"> <br>
            Gender : 
            <input type="radio" name="gender" 
                   <c:if test="${param.gender == true}">
                       checked
                   </c:if>
                   value="true"> Male
            <input type="radio" name="gender" 
                   <c:if test="${not empty param.gender && param.gender == false}">
                       checked
                   </c:if>
                   value="false"> Female
            <input type="radio" name="gender" 
                   <c:if test="${empty param.gender}">
                       checked
                   </c:if>
                   value=""> All <br>
            DoB from <input type="date" name="from" value="${param.from}">
            to <input type="date" name="to" value="${param.to}"> <br>
            Group Name: 
            <select name="groupName">
                <option value="">All</option>
                <c:forEach items="${requestScope.groupNameList}" var="group">
                    <option 
                        <c:if test="${group.name == param.groupName}">
                            selected
                        </c:if>
                        value="${group.name}">${group.name}</option>
                </c:forEach>
            </select> <br>
            <input type="submit" value="Search">
        </form>

        <c:if test="${not empty requestScope.studentList}">
            <table border="1px">
                <tr>
                    <th>Index</th>
                    <th>Image</th>
                    <th>Student ID</th>
                    <th>Student Name</th>
                </tr>

                <c:forEach items="${requestScope.studentList}" var="student" varStatus="loop"> 
                    <tr>
                        <td>${loop.count}</td>
                        <td>
                            <img src="${student.image}" style="height:146px;width:111px"/>
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
            </table>
        </c:if>

        <c:if test="${requestScope.message != null }">
            <b style="color: red">No students were found matching the conditions</b>
        </c:if>
    </body>
</html>
