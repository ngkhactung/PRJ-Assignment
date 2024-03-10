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
        <title>JSP Page</title>

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
        <div style="width: 400px; height: 300px; margin: 0 auto; background-color: bisque; text-align: center">
            <h2 style="color: blue">Please log in to continue...</h2>
            <a id="loginLink" href="/assign.fap.fpt/login">
                <button>OK</button>
            </a>

            <p><b>Redirecting in <span id="countdown"></span> seconds...</b></p>
            <script>updateCountdown();</script>
        </div>
    </body>
</html>
