
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
        <title>Add Staff</title>
    </head>

    <body>
        <div class="box">            
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>
                <div class="adminRight">
                    <div class="adminInfo">
                        <div class="right">
                            <h2>Add Staff</h2>
                            <form action="${pageContext.request.contextPath}/add-staff" method="post">
                                <table>
                                    <tr>
                                        <th><label>Username</label></th>
                                        <td><input type="text" name="username" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Email</label></th>
                                        <td><input type="text" name="email" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Phone Number</label></th>
                                        <td><input type="text" name="contact" value="" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Password</label></th>
                                        <td><input type="text" name="password" value="" required></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button type="submit" name="update" class="update">Add Staff</button>
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
    </body>

</html>