
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-profile.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/all"/>

        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">
                    <div class="order-list">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/images/user.jpg" alt="">
                        </div>
                        <div class="info" style="text-align: left;">
                            <div class="id">
                                <p>User id</p>
                                <input type="text" name=" value="">
                            </div>
                            <div class=" id">
                                <p>Username</p>
                                <input type="text" name=" value="">
                            </div>
                            <div class=" id">
                                <p>Email</p>
                                <input type="email" name=" value="">
                            </div>
                            <div class=" id">
                                <p>Contact</p>
                                <input type="tel" name=" value="">
                            </div>
                            <div class=" id">
                                <p>Address</p>
                                <input type="text" name=" value="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
    </body>
</html>
