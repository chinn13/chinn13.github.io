
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petHome.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cancel.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="showing">
                <div class="cancel">
                    <div class="notice">
                        <h1>Order Cancellation</h1>
                        <p>Your order has been cancelled.</p>
                        <p>Redirecting you to the home page in <span id="countdown">5</span> seconds...</p>
                    </div>
                </div>
            </div>

            <script>
                let secondsLeft = 5;

                function updateCountdown() {
                    document.getElementById('countdown').textContent = secondsLeft;
                    if (secondsLeft === 0) {
                        window.location.href = "../all";
                    } else {
                        secondsLeft--;
                        setTimeout(updateCountdown, 1000); 
                    }
                }

                // Start the countdown
                updateCountdown();
            </script>

            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
    </body>

</html>