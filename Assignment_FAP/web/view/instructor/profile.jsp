<%-- 
    Document   : instructor_profile.jsp
    Created on : Mar 7, 2024, 4:01:53 AM
    Author     : Admin
--%>

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
        <link rel="stylesheet" href="/assign.fap.fpt/css/instructor/profile.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/instructor_menu.jsp"/>

        <br>
        <br>
        <br>

        <div id="profile" class="container px-5 py-2">
            <div class="row">
                <div class="col-md-4 col-12  ">
                    <div class="card wrap-table-card d-grid align-items-center">
                        <div class="card-body px-2 py-4 text-center ">
                            <img class="img-fluid img-border" src="${requestScope.instructor.image}" width="50%" height="auto" />
                            <h2 class="code">${requestScope.instructor.code}</h2>
                            <p class="sub-color">Instructor at FPT University</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-8 col-12 mt-md-0 mt-4">
                    <div class="wrap-table-card px-4 py-2">
                        <table class="table table-hover align-middle caption-top">
                            <caption class="ms-2">Detail Information</caption>
                            <tr>
                                <th>Code</th>
                                <td class="sub-color">${requestScope.instructor.code}</td>
                            </tr>
                            <tr>
                                <th>Full Name</th>
                                <td class="sub-color">${requestScope.instructor.name}</td>
                            </tr>
                            <tr>
                                <th>Gender</th>
                                <td class="sub-color">
                                    <c:if test="${requestScope.instructor.gender}">
                                        Male
                                    </c:if>
                                    <c:if test="${!requestScope.instructor.gender}">
                                        Female
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>Phone</th>
                                <td class="sub-color">${requestScope.instructor.phone}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td class="sub-color">${requestScope.instructor.email}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <br>
        <br>
        <br>
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
