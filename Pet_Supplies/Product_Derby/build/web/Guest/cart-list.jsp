
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petCart.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body>
        <div class="box">            
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>SHOPPING CART</span>
            </p>

            <div class="cart">
                <div class="cartLeft">
                    <div class="cartTitle">
                        <h2>Shopping Cart</h2>
                    </div>
                    <div class="product">
                        <div class="productList">
                            <div id="detail">
                                <h3>PRODUCT</h3>
                            </div>
                            <div id="productName">
                                <h3>PRODUCT NAME</h3>
                            </div>
                            <div id="qty">
                                <h3>QUANTITY</h3>
                            </div>
                            <div id="price">
                                <h3>PRICE</h3>
                            </div>
                            <div id="amount">
                                <h3>AMOUNT</h3>
                            </div>
                            <div id="remove">
                                <h3><strong><i class="fa fa-trash" aria-hidden="true"></i></strong></h3>
                            </div>
                        </div>

                        <c:forEach var="cartItem" items="${cartList}">
                            <form action="${pageContext.request.contextPath}/edit-cart" method="post" class="productList">
                                <div id="detail">
                                    <img src="${pageContext.request.contextPath}/${cartItem.product.image}">
                                    <input type="hidden" name="image" value="${cartItem.product.image}">
                                </div>
                                <div id="productName">
                                    <p>${cartItem.product.name}</p>
                                    <input type="hidden" name="name" value="${cartItem.product.name}">
                                </div>
                                <div id="qty">
                                    <button type="button" class="minus"><strong>-</strong></button>
                                    <input type="text" class="qty" name="qty" min="1" max="99" value="${cartItem.qty}">
                                    <button type="button" class="add"><strong>+</strong></button>
                                </div>
                                <div id="price">
                                    <p class="each_price">${String.format("%.2f",cartItem.product.price)}</p>
                                    <input type="hidden" name="price" value="${String.format("%.2f",cartItem.product.price)}">
                                </div>
                                <div id="amount">
                                    <p class="each_amount">${String.format("%.2f",cartItem.product.price * cartItem.qty)}</p>
                                    <input type="hidden" name="amount" value="${String.format("%.2f",cartItem.product.price * cartItem.qty)}">
                                </div>
                                <div id="remove">
                                    <button class="remove" type="button" name="remove">
                                        <a href="${pageContext.request.contextPath}/delete-cart?del=${cartItem.cart_id}&qty=${cartItem.qty}&user=${cartItem.user.user_id}"><i class="fa fa-times" aria-hidden="true"></i></a>
                                    </button>
                                </div>
                                <div class="hiddenIcon">
                                    <button type="submit" name="submit" value="${cartItem.cart_id}" class="hiddenConfirm"><i class="fa fa-check" aria-hidden="true"></i></button>
                                </div>
                            </form>
                        </c:forEach>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/add-order" method="post" class="cartRight">
                    <div class="cartTitle">
                        <h2>Order Summary</h2>
                    </div>
                    <div class="product">
                        <div class="productList">
                            <h3>ITEMS</h3>
                            <h3 class="itemQty"></h3>
                            <input type="hidden" name="getItemQty" class="getItemQty">
                        </div>
                        <div id="shipping">
                            <h3>SHIPPING</h3>
                            <select name="deliveryMethod" class="shipping" required>
                                <c:forEach items="${option}" var="opt">
                                    <option value="${opt}">${opt}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div id="promo">
                            <h3>PROMO CODE</h3>
                            <input type="text" class="promoCode" placeholder="Enter your code">
                            <button type="button" name="apply" class="apply">APPLY</button>
                        </div>
                        <div id="tax">
                            <h3>Tax</h3>
                            <input type="text" name="tax" class="taxInput">
                        </div>
                        <div class="productList">
                            <h3>TOTAL COUNT</h3>
                            <h3 class="itemAmount"></h3>
                            <input type="hidden" name="getItemAmount" class="getItemAmount">
                        </div>
                        <input type="submit" name="checkout" class="checkout" value="CHECK OUT">
                    </div>
                </form>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
        <script>

            let add = document.querySelectorAll(".add");
            let minus = document.querySelectorAll(".minus");
            let remove = document.querySelectorAll(".remove");
            let qty = document.querySelectorAll(".qty");

            let confirm = document.querySelectorAll(".hiddenIcon");

            let product = document.querySelector('.product');
            let productList = document.querySelector('.product');

            let price = document.querySelectorAll(".each_price");
            let amount = document.querySelectorAll(".each_amount");

            let itemQty = document.querySelector('.itemQty');
            let itemAmount = document.querySelector('.itemAmount');

            let getItemAmount = document.querySelector('.getItemAmount');
            let getItemQty = document.querySelector('.getItemQty');

            for (let i = 0; i < add.length; i++) {
                add[i].addEventListener('click', function () {
                    qty[i].value++;
                    qty[i].innerText = qty[i].value;
                    unit();

                    amount[i].innerText = (parseFloat(price[i].innerText) * parseFloat(qty[i].value)).toFixed(2);
                    calculate();

                    confirm[i].style.display = "block";
                });
                minus[i].addEventListener('click', function () {
                    qty[i].value--;
                    qty[i].innerText = qty[i].value;
                    unit();

                    amount[i].innerText = (parseFloat(price[i].innerText) * parseFloat(qty[i].value)).toFixed(2);
                    calculate();

                    confirm[i].style.display = "block";
                });
                remove[i].addEventListener('click', function () {
                    product.removeChild(this.parentNode.parentNode);
                    calculate();
                });
            }

            function unit() {
                for (let i = 0; i < qty.length; i++) {
                    if (qty[i].value == 99) {
                        add[i].disabled = true;
                    } else if (qty[i].value == 0) {
                        minus[i].disabled = true;
                    } else {
                        add[i].disabled = false;
                        minus[i].disabled = false;
                    }
                }
            }

            function calculate() {
                let qty = document.querySelectorAll(".qty");
                let price = document.querySelectorAll(".each_price");
                let amount = document.querySelectorAll(".each_amount");

                let sum = 0;
                let num = 0;

                for (let i = 0; i < amount.length; i++) {
                    sum += parseFloat(amount[i].innerText);
                    num += +qty[i].value;
                }

                let taxRate = 0;
                let taxInput = document.querySelector(".taxInput");

                if (sum <= 200) {
                    taxRate = 0.03;
                } else if (sum <= 500) {
                    taxRate = 0.05;
                } else if (sum <= 1500) {
                    taxRate = 0.1;
                } else {
                    taxRate = 0.15;
                }

                let taxAmount = sum * taxRate;

                let totalAmount = sum + taxAmount;

                itemQty.innerText = num;
                getItemQty.value = num;

                taxInput.value = (taxRate).toFixed(2) + "%";

                itemAmount.innerText = 'MYR ' + (totalAmount).toFixed(2);
                getItemAmount.value = (totalAmount).toFixed(2);

                console.log(getItemAmount.value);
            }
            calculate();
        </script>
    </body>

</html>
