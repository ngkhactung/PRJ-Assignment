<%-- 
    Document   : access_denied
    Created on : Mar 11, 2024, 2:34:35 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    redirectToHomePage();
                }
            }

            function redirectToHomePage() {
                document.getElementById('homePageUrl').onclick();
            }
        </script>
    </head>
    <body>
        <div style="width: 400px; height: 300px; margin: 0 auto; background-color: bisque; text-align: center">
            <h2 style="color: blue">Access denied...</h2>
            <input id="homePageUrl" 
                   onclick="window.location.href = '${requestScope.homePage}'"
                   type="button" value="Back To HomePage"/>

            <p><b>Redirecting in <span id="countdown"></span> seconds...</b></p>
            <script>updateCountdown();</script>
        </div>
    </body>
</html>
