<%-- 
    Document   : instructor_menu
    Created on : Mar 14, 2024, 2:20:10 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <c:set var="currentPage" value="${pageContext.request.servletPath}" />
        <div class="container">
            <div id="menu" class="navbar navbar-expand-md navbar-dark bg-dark rounded-2 p-md-0 p-2">
                <div class="container-fluid ">
                    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#menubar">
                        <span class="navbar-toggler-icon "></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-md-center" id="menubar">
                        <ul class="navbar-nav nav-pills text-md-center mt-md-0 mt-2">
                            <li class="nav-item mx-md-3">
                                <a href="../instructor/timetable" class="nav-link px-md-2
                                   ${currentPage == '/view/instructor/timetable.jsp' ? ' active':''} ">Time Table</a>
                            </li>
                            <li class="nav-item mx-md-3">
                                <a href="../instructor/grade_taking" class="nav-link px-md-2
                                   ${currentPage == '/view/instructor/grade_taking.jsp' ? ' active':''} ">Take Grade</a>
                            </li>
                            <li class="nav-item mx-md-3">
                                <a href="../instructor/search_student" class="nav-link px-md-2
                                   ${currentPage == '/view/instructor/search_student.jsp' ? ' active':''} ">Search Student</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="droplist" class="dropdown d-md-none float-end ">
                    <button class="btn btn-outline-light dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fa-regular fa-user"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item py-0" href="profile">Profile</a></li>
                        <li><hr class="dropdown-divider"></hr></li>
                        <li><a class="dropdown-item py-0" href="/assign.fap.fpt/logout">Sign Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
