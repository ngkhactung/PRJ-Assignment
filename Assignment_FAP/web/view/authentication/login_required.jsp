<%-- 
    Document   : access_denied
    Created on : Mar 10, 2024, 3:58:00 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="/assign.fap.fpt/css/authentication/stylelogin_required.css"/>
        <script>
            var countdown = 10;

            function updateCountdown() {
                document.getElementById('countdown').textContent = countdown;
                if (countdown > 0) {
                    countdown--;
                    setTimeout(updateCountdown, 1000);
                } else {
                    redirectToLogin();
                }
            }

            function redirectToLogin() {
                window.location.href = document.getElementById('loginLink').getAttribute('href');
            }
        </script>
    </head>
    <body>
        <div class="container">
            <div class="row login_message align-content-center justify-content-center">
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
                    <div class="card border-light-subtle rounded-3 shadow-sm">
                        <div class="card-body p-3 p-md-4 p-xl-4">
                            <div class="col-12 text-center mb-2">
                                <h1 class="title">Please log in to continue...</h1>
                            </div>
                            <div class="col-12 text-center mb-5">
                                <h2 class="redirect">
                                    Redirecting in <span id="countdown"></span> seconds...
                                </h2>
                            </div>
                            <div class="col-12 mb-2 d-md-flex justify-content-md-center">
                                <div class="d-grid col-md-5">
                                    <a class="btn btn-dark" id="loginLink" href="/assign.fap.fpt/login">Go to Login</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>updateCountdown();</script>
    </body>
</html>
