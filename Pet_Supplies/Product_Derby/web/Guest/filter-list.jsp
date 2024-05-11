
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.Product" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petHome.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petFilter.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <%
                String action = request.getParameter("action");
                String displayStyle = ("T".equals(action)) ? "block" : "none";
            %>
            <style>
                .topSalesQty {
                    display: <%= displayStyle%>;
                }
            </style>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>Product</span>
            </p>
            <input type="hidden" id="action" value="${param.action}">

            <div class="filter">
                <div class="filterLeft">
                    <div class="dog">
                        <h4>TYPE</h4>
                        <ul>
                            <c:forEach items="${typeArr}" var="type">
                                <li>
                                    <a href="${pageContext.request.contextPath}/filter-list?action=${action}&type=${type[0]}">${type[1]}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="priceRange">
                        <h4>price</h4>
                        <div class="priceRangeInput">
                            <input type="text" name="min" placeholder="Min">
                            <input type="text" name="max" placeholder="Max">
                        </div>
                    </div>

                </div>
                <div class="filterRight">
                    <div class="product">

                        <c:forEach var="product" items="${productList}">
                            <div class="item">

                                <div class="topSalesQty">
                                    <span><i class="fa fa-line-chart" aria-hidden="true"></i> ${product.qty}</span>
                                </div>
                                
                                <c:if test="${'Out of Stock' eq product.store}">
                                    <div class="outOfStock">
                                    </div>
                                </c:if>

                                <a href="${pageContext.request.contextPath}/product-detail?product=${product.id}" class="imgHome">
                                    <img src="${pageContext.request.contextPath}/${product.image}" alt="">
                                </a>
                                <div class="info">
                                    <p class="content" style="height: 40px;overflow: hidden;">${product.name}</p>
                                    <p class="price">MYR${String.format("%.2f", product.price)}</p>
                                    <div class="btn">
                                        <a href="${pageContext.request.contextPath}/product-detail?product=${product.id}">
                                            <c:choose>
                                                <c:when test="${'Out of Stock' eq product.store}">
                                                    <button class="add" disabled>
                                                        <p><span>Out Of Stock</span></p>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="add">
                                                        <p><span><i class="fa fa-cart-plus" aria-hidden="true"></i></span><span>Details</span></p>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>            

                    </div>
                    <div class="page">
                        <div class="pageLeft">
                            <p>Show</p>
                            <select name="">
                                <option value="">10</option>
                                <option value="">20</option>
                                <option value="">30</option>
                            </select>
                        </div>
                        <div class="pageRight">
                            <button class="previous"><i class="fa fa-angle-left" aria-hidden="true"></i></button>
                            <button>1</button>
                            <button>2</button>
                            <button>3</button>
                            <button>4</button>
                            <button>5</button>
                            <button class="next"><i class="fa fa-angle-right" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
    </body>

</html>