
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
                        <div class="left">
                            <form action="${pageContext.request.contextPath}/add-image" method="post" enctype="multipart/form-data">

                                <c:choose>
                                    <c:when test="${filename != null}">
                                        <img src="${pageContext.request.contextPath}/${filename}" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/unknown.png" alt="">
                                    </c:otherwise>
                                </c:choose>

                                <input type="file" name="upload" class="upload">
                                <br>
                                <button type="submit" name="submit" class="submit">Upload</button>
                            </form>
                        </div>
                        <div class="right">

                            <form action="${pageContext.request.contextPath}/add-product" method="post">

                                <input type="hidden" name="image" value="${filename}">
                                <table>
                                    <tr>
                                        <th><label>Product</label></th>
                                        <td><input type="text" name="name" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Type</label></th>
                                        <td>
                                            <select name="type" required>
                                                <c:forEach items="${typeList}" var="type">
                                                    <option value="${type[0]}">${type[1]}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><label>Quantity</label></th>
                                        <td><input type="text" name="qty" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Price</label></th>
                                        <td><input type="text" name="price" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Description</label></th>
                                        <td>
                                            <textarea name="description" rows="5" cols="10"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><label>Pet</label></th>
                                        <td>
                                            <select name="pet" required>
                                                <c:forEach items="${petList}" var="pet">
                                                    <option value="${pet.pet_id}">${pet.animal}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button type="submit" name="update" class="update">Add Product</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
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
    </body>

</html>