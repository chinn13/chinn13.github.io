
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petAdminOrder.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">
                    <div class="order">
                        <h2>Customer Orders</h2>
                        <div class="orderList">
                            <div class="order_id">
                                <p>ID</p>
                            </div>
                            <div class="qty">
                                <p>Qty</p>
                            </div>
                            <div class="amount">
                                <p>Amount</p>
                            </div>
                            <div class="createDate">
                                <p>Created Date</p>
                            </div>
                            <div class="name">
                                <p>Customer</p>
                            </div>
                            <div class="status">
                                <p>Status</p>
                            </div>
                            <div class="method">
                                <p>Method</p>
                            </div>
                            <div class="updateStatus">
                                <p>Action</p>
                            </div>
                        </div>
                        <c:forEach items="${adminOrderList}" var="order">
                            <form class="orderList" action="${pageContext.request.contextPath}/detail-list" method="post">
                                <div class="order_id">
                                    <input type="text" name="order_id" value="${order.order_id}">
                                </div>
                                <div class="qty">
                                    <input type="text" name="qty" value="${order.qty}">
                                </div>
                                <div class="amount">
                                    <input type="text" name="amount" value="${String.format("%.2f",order.amount)}">
                                </div>
                                <div class="createDate">
                                    <input type="text" name="createDate" value="${order.createDate}">
                                </div>
                                <div class="name">
                                    <input type="text" name="name" value="${order.user_id.customer.username}">
                                </div>
                                <div class="status">
                                    <button type="button" name="status" class="oStatus" value="${order.status}">${order.status}</button>
                                </div>
                                <div class="method">
                                    <input type="text" name="method" value="${order.method}">
                                </div>
                                <div class="updateStatus">
                                    <button type="submit" name="update" class="update"><i class="fa fa-truck" aria-hidden="true"></i></button>
                                </div>
                            </form>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var statusButtons = document.getElementsByClassName("oStatus");
                for (var i = 0; i < statusButtons.length; i++) {
                    var status = statusButtons[i].value;
                    if (status === "Paid") {
                        statusButtons[i].style.backgroundColor = "yellowgreen";
                        statusButtons[i].style.color = "white";
                    } else if (status === "Pending") {
                        statusButtons[i].style.backgroundColor = "orange";
                        statusButtons[i].style.color = "white";
                    } else if (status === "Cancel") {
                        statusButtons[i].style.backgroundColor = "red";
                        statusButtons[i].style.color = "white";
                    }
                }
            });

        </script>
    </body>
</html>
