
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
        <title>Staff</title>
    </head>

    <body>        
        <div class="box">            
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">
                    <h2>Edit Staff</h2>
                    <div class="right">
                        <form action="${pageContext.request.contextPath}/edit-staff" method="post">
                            <c:if test="${retrieveStaff != null}">
                                <table>
                                    <tr>
                                        <th><label>Staff ID</label></th>
                                        <td><input style="background: #eeeeee;border:#6f6e6c 1px solid;" type="text" name="staffID" value="${retrieveStaff.staff_id}" readonly=""></td>
                                    </tr>
                                    <tr>
                                        <th><label>Username</label></th>
                                        <td><input type="text" name="username" value="${retrieveStaff.username}" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Email</label></th>
                                        <td><input style="background: #eeeeee;border:#6f6e6c 1px solid;" type="text" name="email" value="${retrieveStaff.email}" readonly></td>
                                    </tr>
                                    <tr>
                                        <th><label>Phone Number</label></th>
                                        <td><input type="text" name="contact" value="${retrieveStaff.contact}" required></td>
                                    </tr>
                                    <tr>
                                        <th><label>Password</label></th>
                                        <td><input type="text" name="password" value="${retrieveStaff.password}" required></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button type="submit" name="update" class="update">Update</button>
                                        </td>
                                    </tr>
                                </table>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>
    </div>
</body>
</html>