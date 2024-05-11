
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminOrderDetail.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">

                    <div class="orderDetail">

                        <div class="orderInfo">
                            <div class="orderTitle">
                                <h2>Order Detail# ${adminOrderInfo.order_id}</h2>
                                <p>Order Time: <span> ${adminOrderInfo.createDate}</span></p>
                            </div>
                            <h3 style="text-align: left;">Order Items</h3>
                            <div class="orderItem">
                                <div id="product">
                                    <p><strong>Product</strong></p>
                                </div>
                                <div id="qty">
                                    <p><strong>Qty</strong></p>
                                </div>
                                <div id="price">
                                    <p><strong>Price</strong></p>
                                </div>
                                <div id="amount">
                                    <p><strong>Amount</strong></p>
                                </div>
                            </div>


                            <c:forEach items="${adminOrderDetail}" var="detail">
                                <div class="orderItem">
                                    <div id="product">
                                        <p>${detail.product.name}</p>
                                    </div>
                                    <div id="qty">
                                        <p>${detail.product.qty}</p>
                                    </div>
                                    <div id="price">
                                        <p>${String.format("%.2f",detail.product.price)}</p>
                                    </div>
                                    <div id="amount">
                                        <p>${String.format("%.2f",detail.product.price * detail.product.qty)}</p>
                                    </div>
                                </div>
                            </c:forEach>

                            <div class="orderItem">
                                <div id="product">
                                </div>
                                <div id="qty">
                                </div>
                                <div id="price">
                                </div>
                                <div id="amount" style="text-align: left;">
                                    <p>Tax <input type="text" class="tax" name="tax" value="0.00%" disabled></p>
                                    <p class="totalAmount"><h2 class="afterTax" style="padding: 5px 0 ;">Total ${String.format("%.2f",adminOrderInfo.amount)}</h2></p>
                                </div>
                            </div>
                            <div class="ordeStatus">
                                <div class="next">
                                    <c:choose>
                                        <c:when test="${status eq '1'}">
                                            <div class="status" style="width: 33%; background-color: orange;"></div>
                                            <div class="packing" style="background-color: orange;"></div>
                                        </c:when>
                                        <c:when test="${status eq '2'}">
                                            <div class="status" style="width: 66%; background-color: orange;"></div>
                                            <div class="ship" style="background-color: orange;"></div>
                                        </c:when>
                                        <c:when test="${status eq '3'}">
                                            <div class="status" style="width: 100%; background-color: yellowgreen;"></div>
                                            <div class="delivered" style="background-color: yellowgreen;"></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="status" style="width: 0%; background-color: #EEEEEE;"></div>
                                            <div class="paid" style="background-color: #EEEEEE;"></div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="status_bg"></div>

                                    <p id="paid">Paid</p>
                                    <p id="packing">Packing</p>
                                    <p id="ship">Shipping</p>
                                    <p id="delivered">Delivered</p>
                                </div>
                            </div>
                        </div>                
                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>      
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var btnAddress = document.querySelector('.addAddress');
                var hiddenAddress = document.querySelector('.hiddenAddress');

                hiddenAddress.style.display = 'none';
                btnAddress.addEventListener('click', function () {
                    if (hiddenAddress.style.display === 'none') {
                        hiddenAddress.style.display = 'block';
                    } else {
                        hiddenAddress.style.display = 'none';
                    }
                });
            });
            
            let amount = document.querySelector(".afterTax");

            let amountString = amount.textContent.trim().split(" ")[1];
            let sum = parseFloat(amountString);

            let taxRate = 0;
            if (sum <= 200) {
                taxRate = 0.03;
            } else if (sum <= 500) {
                taxRate = 0.05;
            } else if (sum <= 1500) {
                taxRate = 0.1;
            } else {
                taxRate = 0.15;
            }

            let taxInput = document.querySelector(".tax");
            taxInput.value = (taxRate).toFixed(2) + "%";

        </script>
    </body>

</html>