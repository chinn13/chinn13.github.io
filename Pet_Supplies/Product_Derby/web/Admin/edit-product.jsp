
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petAdminEdit.css">
        <title>Product</title>
    </head>

    <body>        
        <div class="box">            
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">

                    <div class="adminInfo">
                        <c:if test="${product != null}">
                            <div class="left">
                                <form action="${pageContext.request.contextPath}/edit-image" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="product_id" value="${product.id}">
                                    <c:choose>
                                        <c:when test="${filename != null}">
                                            <img src="${pageContext.request.contextPath}/${filename}" alt="">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${product.image}" alt="">
                                        </c:otherwise>
                                    </c:choose>

                                    <input type="file" name="upload" class="upload">
                                    <br>
                                    <button type="submit" name="submit" class="submit">Upload</button>
                                </form>
                            </div>
                            <div class="right">

                                <form action="${pageContext.request.contextPath}/edit-product" method="post">
                                    <input hidden type="text" name="product_id" value="${product.id}">
                                    <input hidden type="text" name="image" value="${product.image}">
                                    <table>
                                        <tr>
                                            <th><label>Product</label></th>
                                            <td><input type="text" name="name" value="${product.name}"></td>
                                        </tr>
                                        <tr>
                                            <th><label>Type</label></th>
                                            <td>
                                                <select name="type">
                                                    <option value="${product.type}">${product.type}</option>
                                                    <c:forEach items="${typeList}" var="type">
                                                        <option value="${type[0]}">${type[1]}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><label>Quantity</label></th>
                                            <td><input type="text" name="qty" value="${product.qty}"></td>
                                        </tr>
                                        <tr>
                                            <th><label>Price</label></th>
                                            <td><input type="text" name="price" value="${String.format("%.2f", product.price)}"></td>
                                        </tr>
                                        <tr>
                                            <th><label>Description</label></th>
                                            <td>
                                                <textarea name="description" rows="5" cols="10">${product.description}</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><label>Pet</label></th>
                                            <td>
                                                <select name="pet">
                                                    <option value="${product.pet.pet_id}">${product.pet.animal}</option>
                                                    <c:forEach items="${petList}" var="pet">
                                                        <c:if test="${!pet.pet_id.equals(product.pet.pet_id)}">
                                                            <option value="${pet.pet_id}">${pet.animal}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <button type="submit" name="update" class="update">Update</button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </c:if>
                    </div>

                </div>

            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>

        <script>
            let total = document.querySelector('.qty')
            let add = document.querySelector('.plus')
            let remove = document.querySelector('.remove')

            add.addEventListener('click', function () {
                total.value++
                remove.disabled = false
            })
            remove.addEventListener('click', function () {
                total.value--
                if (total.value <= 0) {
                    remove.disabled = true
                }
            })
        </script>
        <!-------------------------------------------------------->



    </body>

</html>