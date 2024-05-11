
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
        <title>Pet Supplies</title>
    </head>

    <body>            
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i></span>
            </p>

            <div class="advertisement">
                <div class="slide"><img src="${pageContext.request.contextPath}/images/home1.png" alt=""></div>
                <div class="slide"><img src="${pageContext.request.contextPath}/images/home2.png" alt=""></div>
                <div class="slide"><img src="${pageContext.request.contextPath}/images/home3.png" alt=""></div>
                <div class="slide"><img src="${pageContext.request.contextPath}/images/home4.png" alt=""></div>
            </div>

            <h3 class="product_h3">Feature Products</h3>

            <div class="store">
                <div class="product">

                    <c:forEach items="${productList}" var="product">
                        <div class="item">
                            <a href="${pageContext.request.contextPath}/product-detail?product=${product.id}" class="imgHome">
                                <img src="${pageContext.request.contextPath}/${product.image}" alt="">
                            </a>
                            <div class="info">
                                <p class="name" style="height: 40px;overflow: hidden;">${product.name}</p>
                                <p class="price">MYR${String.format("%.2f", product.price)}</p>
                                <div class="btn">
                                    <a href="${pageContext.request.contextPath}/product-detail?product=${product.id}">
                                        <button class="add">
                                            <p><span><i class="fa fa-cart-plus" aria-hidden="true"></i></span><span>Details</span></p>
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="social">
                    <h3>Promotion</h3>
                    <img src="${pageContext.request.contextPath}/images/social1.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social2.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social3.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social4.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social5.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social6.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social7.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social8.jpg" alt="alt"/>
                    <img src="${pageContext.request.contextPath}/images/social9.jpg" alt="alt"/>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>

        <script>
            w3.slideshow(".slide", 2000);
        </script>
    </body>

</html>