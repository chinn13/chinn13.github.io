
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petOrderDetail.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>SHOPPING CART</span><i class="fa fa-chevron-right" aria-hidden="true"></i>Order</span>
            </p>

            <div class="orderDetail">

                <form action="${pageContext.request.contextPath}/edit-address" method="post" class="hiddenAddress">
                    <h2>Change Address</h2>
                    <textarea class="textAddress" name="textAddress" rows="10" cols="1"><c:choose><c:when test="${address != null}">${address}</c:when><c:otherwise>${customer.address}</c:otherwise></c:choose></textarea>
                            <p>This address will also update in your profile</p>
                            <button type="submit" name="btnAddress" class="btnAddress">Change Address</button>
                        </form>

                        <div class="orderInfo">
                            <div class="orderTitle">
                                    <h2>Order Detail# ${orderList.order_id}</h2>
                        <p>Order Time: <span> ${orderList.createDate}</span></p>
                    </div>
                    <h3>Order Items</h3>
                    <div class="orderItem">
                        <div id="product">
                            <p><strong>Product</strong></p>
                        </div>
                        <div id="price">
                            <p><strong>Price</strong></p>
                        </div>
                        <div id="qty">
                            <p><strong>Qty</strong></p>
                        </div>
                        <div id="amount">
                            <p><strong>Amount</strong></p>
                        </div>
                    </div>
                    <c:forEach items="${orderDetailList}" var="orderDetail">

                        <div class="orderItem">
                            <div id="product">
                                <p>${orderDetail.name}</p>
                            </div>
                            <div id="price">
                                <p>${String.format("%.2f",  orderDetail.price)}</p>
                            </div>
                            <div id="qty">
                                <p>${orderDetail.qty}</p>
                            </div>
                            <div id="amount">
                                <p>${String.format("%.2f",orderDetail.qty * orderDetail.price)}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="orderItem">
                        <div id="product">
                        </div>
                        <div id="price">
                        </div>
                        <div id="qty">
                        </div>
                        <div id="amount">
                            <p>Tax <input type="text" name="tax" value="${tax}" disabled></p>
                            <p class="totalAmount"><h2>Total ${String.format("%.2f",orderList.amount)}</h2></p>
                        </div>
                    </div>
                    <div class="statusBox">
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
                <form action="${pageContext.request.contextPath}/checkout-order" method="post" class="shipping">
                    <input type="hidden" name="orderid" value="${orderList.order_id}">                    
                    <div class="custInfo">
                        <h3>Customer</h3>
                        <input type="text" name="custName" placeholder="Name" value="${customer.username}" disabled>
                        <input type="tel" name="contact" placeholder="Tel" value="(60+) ${customer.contact}" disabled>
                    </div>

                    <div class="shippingInfo">
                        <h3>Shipping Information</h3>
                        <select name="deliveryMethod" required>                            
                            <c:forEach items="${option}" var="opt">
                                <option value="${opt}" <c:if test="${opt == orderList.method}">selected</c:if>>${opt}</option>
                            </c:forEach>
                        </select>
                        <br><br>
                        <h3>Delivery Address</h3>
                        <input type="text" name="address" value="<c:choose> <c:when test="${address != null}"> ${address} </c:when> <c:otherwise> ${customer.address} </c:otherwise> </c:choose>">
                                <button type="button" class="addAddress" name="addAddress">Change Address</button>
                            </div>

                            <button type="submit" name="pay" value="Pay Now" class="pay">Pay Now</button>
                            <button type="submit" name="pay" value="Cancel Order" class="cancel">Cancel Order</button>
                        </form>
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

        </script>
    </body>

</html>