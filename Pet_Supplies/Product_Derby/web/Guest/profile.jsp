
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://www.w3schools.com/lib/w3.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petProfile.css">
        <title>Pet Supplies</title>
    </head>

    <body>
        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="profileDisplay">
                <h1>Profile</h1>
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <c:choose>
                        <c:when test="${profile.position eq 'customer'}">
                            <table>
                                <input type="hidden" name="position" id="position" value="${profile.position}">
                                <tr>
                                    <td>Your ID</td>
                                    <td><input type="text" name="custID" id="custID" value="${profile.customer.cust_id}" readonly></td>
                                </tr>
                                <tr>
                                    <td>Username</td>
                                    <td><input type="text" name="username" id="username" value="${profile.customer.username}"></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="email" name="email" id="email" value="${profile.customer.email}" readonly></td>
                                </tr>
                                <tr>
                                    <td>Phone Number</td>
                                    <td><input type="text" name="contact" value="${profile.customer.contact}" id="contact"></td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td><input type="text" name="address" value="${profile.customer.address}" id="address"></td>
                                </tr>
                                <tr>
                                    <td>Password</td>
                                    <td><input type="text" name="password" value="${profile.customer.password}" id="password"></td>
                                </tr>
                                <tr class="edit">
                                    <td colspan="2"><input type="submit" class="button" value="Save"></td>
                                </tr>
                            </table>
                        </c:when>
                        <c:when test="${profile.position eq 'staff' || profile.position eq 'manager'}">
                            <table>
                                <input type="hidden" name="position" id="position" value="${profile.position}">
                                <tr>
                                    <td>Your ID</td>
                                    <td><input type="text" name="staffID" id="staffID" value="${profile.staff.staff_id}" readonly></td>
                                </tr>
                                <tr>
                                    <td>Username</td>
                                    <td><input type="text" name="username" id="username" value="${profile.staff.username}"></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="email" name="email" id="email" value="${profile.staff.email}" readonly></td>
                                </tr>
                                <tr>
                                    <td>Phone Number</td>
                                    <td><input type="text" name="contact" value="${profile.staff.contact}" id="contact"></td>
                                </tr>
                                <tr>
                                    <td>Password</td>
                                    <td><input type="text" name="password" value="${profile.staff.password}" id="password"></td>
                                </tr>
                                <tr class="edit">
                                    <td colspan="2"><input type="submit" class="button" value="Save"></td>
                                </tr>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>No specific information available for this user.</p>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
    </body>
</html>