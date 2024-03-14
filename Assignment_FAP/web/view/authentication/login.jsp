<%-- 
    Document   : login
    Created on : Mar 10, 2024, 1:57:45 PM
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
        <link rel="stylesheet" href="/assign.fap.fpt/css/authentication/stylelogin.css"/>
    </head>
    <body>
        <div class="container">
            <div class="row login align-content-center justify-content-center">
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
                    <div class="card border-light-subtle rounded-4 shadow-sm">
                        <div class="card-body p-3 p-md-4 p-xl-4">
                            <div class="brand_title text-center">
                                <img src="./image/logo/fpt-logo.png" width="200" height="100" />
                                <h2 class="title">Sign in to FPT FAP</h2>
                            </div>
                            <form action="login" method="POST">
                                <div class="col-12 form-floating mb-4">
                                    <input type="text" class="form-control" name="username" id="username"
                                           <c:if test="${param.username != null}">
                                               value="${param.username}"
                                           </c:if>
                                           <c:if test="${param.username == null}">
                                               value="${cookie.cookieUser.value}"
                                           </c:if>
                                           placeholder="username" required>
                                    <label for="username" class="form-label">Username</label>
                                </div>
                                <div class="col-12 form-floating mb-4">
                                    <input type="password" class="form-control" name="password" id="password"
                                           <c:if test="${param.password != null}">
                                               value="${param.password}"
                                           </c:if>
                                           <c:if test="${param.password == null}">
                                               value="${cookie.cookiePass.value}"
                                           </c:if>
                                           placeholder="password" required>
                                    <label for="password" class="form-label">Password</label>
                                </div>
                                <div class="col-12 form-check mb-4">
                                    <input class="form-check-input " type="checkbox" name="remember"
                                           <c:if test="${cookie.cookieRem.value != null}">
                                               checked
                                           </c:if>
                                           value="remember" id="remember">
                                    <label class="form-check-label text-secondary" for="remember">Keep me logged
                                        in</label>
                                </div>
                                <div class="col-12 mb-4">
                                    <div class="d-grid gap-2 ">
                                        <button class="btn btn-dark btn-lg" type="submit">Log in</button>
                                    </div>
                                </div>
                                <c:if test="${not empty requestScope.message}">
                                    <div class="col-12 mb-4 text-center">
                                        <p class="message">${requestScope.message}<p>
                                    </div>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
</body>
</html>
