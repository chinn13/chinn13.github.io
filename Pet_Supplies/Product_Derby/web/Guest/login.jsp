
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>Login</span>
            </p>

            <div class="information">
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="login">
                        <h1>LOGIN</h1>

                        <div class="detail">
                            <label>Email</label>
                            <br />
                            <input type="email" name="email" id="email" required>
                            <br />
                        </div>

                        <div class="detail">
                            <label>Password</label>
                            <br />
                            <input type="password" name="password" id="password" required>
                            <br />
                        </div>

                        <div class="detail">
                            <input type="submit" class="button" value="SIGN IN" onclick="loginSuccess()">
                        </div>
                    </div>
                </form>
                <script>
                    function loginSuccess() {
                        var email = document.getElementById("email").value;
                        var password = document.getElementById("password").value;

                        if (username !== '' && email !== '') {
                            alert("User login successful!!!");
                        } else {
                            alert("Please fill out all required fields!!!");
                        }
                    }
                </script>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="register">
                        <h1>CREATE NEW ACCOUNT</h1>

                        <div class="detail">
                            <label>Username</label><br />
                            <input type="text" name="username" id="username" required><br />
                        </div>

                        <div class="detail">
                            <label>Email</label><br />
                            <input type="email" name="email" id="email" required><br />
                        </div>

                        <div class="detail">
                            <label>Phone Number</label><br />
                            <input type="text" name="contact" id="contact" required><br />
                        </div>

                        <div class="details">
                            <label>Address</label><br />
                            <input type="text" name="address" id="address" required></textarea>
                        </div>

                        <div class="detail">
                            <label>Password</label><br />
                            <input type="password" name="password" id="password" required><br />
                        </div>

                        <div class="detail">
                            <label>Confirm Password</label><br />
                            <input type="password" name="confirmPassword" id="confirmPassword" required><br />
                        </div>

                        <div class="detail">
                            <input type="submit" class="button" value="CREATE AN ACCOUNT" onclick="registerSuccess()">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="../HeadFoot/footer.jsp"/>
    </body>
</html>