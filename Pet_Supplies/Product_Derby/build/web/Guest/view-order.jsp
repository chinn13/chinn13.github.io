
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
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i></span>
            </p>

            <div class="order">
                <div class="orderbar">
                    <p><a href="${pageContext.request.contextPath}/profile">Profile</a></p>
                    <p><a href="${pageContext.request.contextPath}/view-order">My Purchase</a></p>
                </div>
                <div class="order-list">
                    <c:forEach var="entry" items="${orderDetailsMap}" varStatus="loop">
                        <c:set var="orderId" value="${entry.key}" />
                        <c:set var="details" value="${entry.value}" />
                        <div class="orderInfo">

                            <c:if test="${!prevOrderId.equals(orderId)}">
                                <div class="title">
                                    <h2>Order# <span>${orderId}</span></h2>
                                    <p>Created Date <span>${details[0].order.createDate}</span></p>
                                    <p class="status">${details[0].order.status}</p>
                                </div>
                            </c:if>
                            <c:set var="prevOrderId" value="${orderId}" />

                            <div class="order-item">
                                <h3 style="padding-bottom: 10px">Order Details</h3>
                                <div class="item">
                                    <div class="image" style="height: 40px;border:none;">
                                        <p></p>
                                    </div>
                                    <div class="name" style="text-align: center;height: 40px;border:none;text-align: left;">
                                        <p>Product</p>
                                    </div>
                                    <div class="price" style="height: 40px;border:none;">
                                        <p>Price</p>
                                    </div>
                                    <div class="qty" style="height: 40px;border:none;">
                                        <p>Qty</p>
                                    </div>
                                    <div class="amount" style="height: 40px;border:none;">
                                        <p>Amount</p>
                                    </div>
                                </div>
                                <c:forEach var="orderDetail" items="${details}" varStatus="detailLoop">
                                    <div class="item"">
                                        <div class="image">
                                            <p><img src="${pageContext.request.contextPath}/${orderDetail.product.image}" alt=""></p>
                                        </div>
                                        <div class="name">
                                            <p>${orderDetail.product.name}</p>
                                        </div>
                                        <div class="price">
                                            <p>${String.format("%.2f",orderDetail.product.price)}</p>
                                        </div>
                                        <div class="qty">
                                            <p>${orderDetail.qty}</p>
                                        </div>    
                                        <div class="amount">
                                            <p>${String.format("%.2f",orderDetail.product.price * orderDetail.qty)}</p>
                                        </div>
                                    </div>
                                </c:forEach>

                                <div class="total">
                                    <h4 id="total">Total MYR ${String.format("%.2f",details[0].order.amount)}</h4>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <jsp:include page="../HeadFoot/footer.jsp"/>
            <script>
                var title = document.querySelectorAll(".title");
                var item = document.querySelectorAll(".order-item");

                for (let i = 0; i < title.length; i++) {
                    title[i].addEventListener('click', function () {
                        // Check if the clicked item is already open
                        if (item[i].style.display === "block") {
                            // If it's open, close it
                            item[i].style.display = "none";
                        } else {
                            // Close all .order-item elements
                            for (let j = 0; j < item.length; j++) {
                                item[j].style.display = "none";
                            }
                            // Open the corresponding .order-item
                            item[i].style.display = "block";
                        }
                    });
                }
                var statusElements = document.querySelectorAll(".status");

                statusElements.forEach(function (statusElement) {
                    var status = statusElement.innerText.trim();
                    if (status === "Pending" || status === "PENDING") {
                        statusElement.style.backgroundColor = "orange";
                    } else if (status === "Paid" || status === "PAID") {
                        statusElement.style.backgroundColor = "yellowgreen";
                    } else if (status === "Cancel" || status === "CANCEL") {
                        statusElement.style.backgroundColor = "red";
                    }
                });
            </script>
        </div>
    </body>

</html>