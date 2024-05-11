
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petPayment.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="loader"></div>

            <div class="payment">
                <div class="title">
                    <h2>Payment</h2>
                    <p>All transaction are secure and encrypted</p>
                </div>
                <div class="paymentType">
                    <div class="type">
                        <div class="type_list">
                            <input type="radio" name="payment" value="online">
                            <p>Online Banking</p>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/payment2.png" alt="">
                    </div>
                    <div class="type">
                        <div class="type_list">
                            <input type="radio" name="payment" value="cod">
                            <p>Cash on Delivery</p>
                        </div>
                        <i class="fa fa-truck" aria-hidden="true"></i>
                    </div>
                    <div class="type">
                        <div class="type_list">
                            <input type="radio" name="payment" value="card">
                            <p>Credit Card / Debit Card</p>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/payment1.png" alt="">
                    </div>
                    <form action="" method="post" id="card" class="type" style="height: auto;">
                        <div class="card">
                            <div class="cardnumber">
                                <p>Name</p>
                                <input type="text" name="name" placeholder="FULL NAME">
                            </div>
                            <div class="cardnumber">
                                <p>Card Number</p>
                                <input type="text" name="cardnumber" placeholder="XXXX XXXX XXXX XXXX" max="16">
                            </div>
                            <div class="card_ul">
                                <div class="card_list">
                                    <p>Expiration</p>
                                    <input type="text" name="expired" placeholder="MM / YY" max="4">
                                </div>
                                <div class="card_list">
                                    <p>Card Verification Value</p>
                                    <input type="text" name="cvv" placeholder="CVV" max="3">
                                </div>
                            </div>
                        </div>
                        <div class="btmLine" style="width: 45%">
                            <p>
                                <span>Tax ${tax}<br></span>
                                <span class="fee"></span>
                                <strong>Total MYR ${orderAmount}</strong>
                            </p>
                            <button type="button" name="placeorder" class="placeorder">Place Order</button>
                        </div>
                    </form>
                    <form action="" method="post" id="cod" class="type" style="height: auto;">
                        <div class="cashondelivery">
                            <div class="delivery">
                                <h2>Your item(s) will be deliverd to this address</h2>
                                <div class="deliveryInfo">
                                    <p>${customer.address}</p>
                                    <p>Shipping time: 2-5 days</p>
                                </div>
                            </div>
                            <div class="deliveryImage"></div>
                        </div>
                        <div class="btmLine" style="width: 35%">
                            <p>
                                <span>Tax ${tax}<br></span>
                                <span class="fee"></span>
                                <strong>Total MYR ${orderAmount}</strong>
                            </p>
                            <button type="button" name="placeorder" class="placeorder">Place Order</button>
                        </div>
                    </form>
                    <form action="" method="post" id="online" class="type" style="height: auto;">
                        <div class="online">
                            <select name="bank" class="bank" required>
                                <option value="">------------------------------------------------ Selected Bank ------------------------------------------------</option>
                                <option value="Maybank2u">Maybank2u</option>
                                <option value="CIMB Clicks">CIMB Clicks</option>
                                <option value="Public Bank">Public Bank</option>
                                <option value="Hong Leong Connect">Hong Leong Connect</option>
                                <option value="RHB Now">RHB Now</option>
                                <option value="Ambank">Ambank</option>
                                <option value="MyBSN">MyBSN</option>
                                <option value="Bank Rakyat">Bank Rakyat</option>
                                <option value="UOB">UOB</option>
                                <option value="Affin Bank">Affin Bank</option>
                                <option value="Bank Islam">Bank Islam</option>
                                <option value="HSBC Online">HSBC Online</option>
                                <option value="Standard Chartered Bank">Standard Chartered Bank</option>
                                <option value="Kuwait Finance House">Kuwait Finance House</option>
                                <option value="Bank Muamalat">Bank Muamalat</option>
                                <option value="OCBC Online">OCBC Online</option>
                                <option value="Alliance Bank">Alliance Bank</option>
                                <option value="Agrobank">Agrobank</option>
                            </select>

                        </div>

                        <div class="btmLine" style="width: 35%">
                            <p>
                                <span>Tax ${tax}<br></span>
                                <span class="fee"><br></span>
                                <strong>Total MYR ${orderAmount}</strong>
                            </p>
                            <button type="button" name="placeorder" class="placeorder">Place Order</button>
                        </div>
                    </form>
                </div>
            </div>
            <script>
                var online = document.querySelector("#online");
                var cod = document.querySelector("#cod");
                var card = document.querySelector("#card");

                const radios = document.querySelectorAll('input[type="radio"][name="payment"]');
                radios.forEach(function (radio) {
                    radio.addEventListener('click', function (event) {
                        radios.forEach(function (rb) {
                            rb.parentElement.style.backgroundColor = '';
                        });

                        switch (this.value) {
                            case 'online':
                                online.style.display = 'block';
                                cod.style.display = 'none';
                                card.style.display = 'none';
                                break;
                            case 'cod':
                                cod.style.display = 'block';
                                online.style.display = 'none';
                                card.style.display = 'none';
                                break;
                            case 'card':
                                card.style.display = 'block';
                                cod.style.display = 'none';
                                online.style.display = 'none';
                                break;
                            default:
                                break;
                        }
                    });
                });

                var loader = document.querySelector(".loader")
                var btn = document.querySelectorAll(".placeorder");

                for (let i = 0; i < btn.length; i++) {
                    btn[i].addEventListener('click', function () {
                        loader.style.display = 'flex';
                        setTimeout(function () {
                            window.location.href = "${pageContext.request.contextPath}/paid";
                        }, 2000);
                    });
                }
            </script>

            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
        <script>
            let totalElement = document.querySelector('.btmLine strong');
            let totalString = totalElement.textContent.trim().split('MYR ')[1];
            let total = parseFloat(totalString);

            let feeInput = document.querySelectorAll(".fee");

            let shippingFee = 0.00;

            if (total < 1000) {
                shippingFee = 25.00;
                for (i = 0; i < feeInput.length; i++) {
                    feeInput[i].innerHTML = `Shipping Fee MYR ` + shippingFee + `<br>`;
                }
            } else {
                shippingFee = 0.00;
                for (i = 0; i < feeInput.length; i++) {
                    feeInput[i].innerHTML = `Free Shipping<br>`;
                }
            }

            let totalWithShipping = total + shippingFee;

            totalElement.textContent = `Total MYR ` + totalWithShipping.toFixed(2);
        </script>
    </body>

</html>