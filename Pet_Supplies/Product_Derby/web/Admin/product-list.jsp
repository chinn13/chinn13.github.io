
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>        
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">
                    <div class="top">
                        <h2>Product Management</h2>
                        <button>
                            <a href="${pageContext.request.contextPath}/Admin/add-product.jsp">Add Product</a>
                        </button>
                    </div>

                    <div class="adminItem">
                        <div id="id">
                            <p>ID</p>
                        </div>
                        <div id="name">
                            <p>Product</p>
                        </div>
                        <div id="qty">  
                            <p>Qty</p>
                        </div>
                        <div id="price">
                            <p>Price</p>
                        </div>
                        <div id="status">
                            <p>Status</p>
                        </div>
                        <div id="action">
                            <p>Action</p>
                        </div>
                    </div>

                    <c:forEach items="${productList}" var="product">
                        <form action="${pageContext.request.contextPath}/edit-list" method="post" class="adminItem">
                            <div id="id">
                                <input type="text" name="product_id" value="${product.id}" >
                            </div>
                            <div id="name">
                                <input type="text" name="name" value="${product.name}">
                            </div>
                            <div id="qty">
                                <input type="text" name="qty" value="${product.qty}" >
                            </div>
                            <div id="price">
                                <input type="text" name="price_text" value="${String.format("%.2f", product.price)}" >
                                <input type="hidden" name="price" value="${product.price}" >
                            </div>
                            <div id="status">
                                <p><input type="text" name="store" value="${product.store}" ></p>
                            </div>
                            <div hidden id="action">
                                <a href="#" onclick="confirmEdit(${product.id})"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                                <a href="#" onclick="confirmDelete(${product.id})"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                            </div>
                            <div id="action">
                                <button type="submit" name="submit" class="submit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                <a href="${pageContext.request.contextPath}/remove-product?product=${product.id }" onclick="confirmDelete()"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                            </div>
                        </form>
                    </c:forEach>
                    <div class="adminClose">

                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
        <script>
            function confirmDelete(productId) {
                if (confirm("Sure to removed this product from shelves?")) {
                    window.location.href = "${pageContext.request.contextPath}/remove-product?product=" + productId;
                }
            }
        </script>
    </body>
</html>
