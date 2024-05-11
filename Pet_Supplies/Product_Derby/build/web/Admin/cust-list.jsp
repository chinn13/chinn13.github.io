
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petAdminProduct.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminCust.css">
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
                    <div class="user">
                        <h2 style="text-align: left;padding: 10px;">Customer List</h2>                       
                        <div class="userInfo" style="text-align: center;">
                            <div class="user_id">
                                <p>ID</p>
                            </div>
                            <div class="username">
                                <p>Username</p>
                            </div>
                            <div class="email">
                                <p>Email</p>
                            </div>
                            <div class="contact">
                                <p>Contact</p>
                            </div>
                            <div class="address">
                                <p>Address</p>
                            </div>
                        </div>

                        <c:forEach items="${cust}" var="customer">
                            <div class="userInfo" style="text-align: center;">
                                <div class="user_id">
                                    <p>${customer.cust_id}</p>
                                </div>
                                <div class="username">
                                    <p>${customer.username}</p>
                                </div>
                                <div class="email" style="text-align: left;padding-left: 20px;">
                                    <p>${customer.email}</p>
                                </div>
                                <div class="contact">
                                    <p>${customer.contact}</p>
                                </div>
                                <div class="address" style="text-align: left;padding-left: 20px; ">
                                    <p>${customer.address}</p>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
    </body>
</html>
