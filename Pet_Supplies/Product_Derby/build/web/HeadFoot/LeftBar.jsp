
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="adminLeft">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/Admin/home.jsp">
                        <i class="fa fa-home" aria-hidden="true"></i>Dashboard
                    </a>
                </li>  
                <li>
                    <a href="${pageContext.request.contextPath}/product-list">
                        <i class="fa fa-th-list" aria-hidden="true"></i>Product
                    </a>
                </li>
                <c:if test="${loginRole eq 'manager'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/staff-list">
                            <i class="fa fa-user-md" aria-hidden="true"></i>Admin
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="${pageContext.request.contextPath}/cust-list">
                        <i class="fa fa-users" aria-hidden="true"></i>Customer
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/order-list">
                        <i class="fa fa-first-order" aria-hidden="true"></i>Order
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/Admin/report.jsp">
                        <i class="fa fa-calendar-minus-o" aria-hidden="true"></i>Report
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/Admin/topSales.jsp">
                        <i class="fa fa-fire" aria-hidden="true"></i>Top Sales
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/Admin/comment.jsp">
                        <i class="fa fa-comment-o" aria-hidden="true"></i>Comment
                    </a>
                </li>
            </ul>
        </div>
    </body>
</html>
