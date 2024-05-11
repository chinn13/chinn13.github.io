
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/view-order.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-profile.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>Profile</span>
            </p>

            <div class="order">
                <div class="orderbar">
                    <p><a href="${pageContext.request.contextPath}/profile">Profile</a></p>
                    <p><a href="${pageContext.request.contextPath}/view-order">My Purchase</a></p>
                </div>
                <div class="order-list">
                    <c:choose>
                        <c:when test="${userprofile.position eq 'customer'}">
                            <div class="img">
                                <img src="${pageContext.request.contextPath}/images/user.jpg" alt="">
                            </div>
                            <div class="info">
                                <a class="update" href="${pageContext.request.contextPath}/displayProfile"><i class="fa fa-cog" aria-hidden="true"></i></a>
                                <div class="id">
                                    <p>User id</p>
                                    <input type="text" name="" value="${userprofile.customer.cust_id}" disabled>
                                </div>
                                <div class="id">
                                    <p>Username</p>
                                    <input type="text" name="" value="${userprofile.customer.username}" disabled>
                                </div>
                                <div class="id">
                                    <p>Email</p>
                                    <input type="email" name="" value="${userprofile.customer.email}" disabled>
                                </div>
                                <div class="id">
                                    <p>Contact</p>
                                    <input type="tel" name="" value="${userprofile.customer.contact}" disabled>
                                </div>
                                <div class="id">
                                    <p>Address</p>
                                    <input type="text" name="" value="${userprofile.customer.address}" disabled>
                                </div>
                            </c:when>
                            <c:when test="${userprofile.position eq 'staff' || userprofile.position eq 'manager'}">
                                <a class="update" href="${pageContext.request.contextPath}/displayProfile"><i class="fa fa-cog" aria-hidden="true"></i></a>
                                <div class="id">
                                    <p>User id</p>
                                    <input type="text" name=" value="${userprofile.staff.staff_id}" disabled>
                                </div>
                                <div class="id">
                                    <p>Username</p>
                                    <input type="text" name=" value="${userprofile.staff.username}" disabled>
                                </div>
                                <div class="id">
                                    <p>Email</p>
                                    <input type="email" name=" value="${userprofile.staff.email}" disabled>
                                </div>
                                <div class="id">
                                    <p>Contact</p>
                                    <input type="tel" name=" value="${userprofile.staff.contact}" disabled>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>No specific information available for this user.</p>
                        </c:otherwise>
                    </c:choose>
                </div>                                
            </div>
        </div>
        <jsp:include page="../HeadFoot/footer.jsp"/>
    </div>
</body>

</html>