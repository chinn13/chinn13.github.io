
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminStaff.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/all"/>

        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>

                <div class="adminRight">
                    <div class="user">
                        <h2 style="text-align: left;padding: 10px;">Staff List <a href="${pageContext.request.contextPath}/Admin/add-staff.jsp" class="addstaff"><button>Add Staff</button></a></h2> 
                        <div class="userInfo" style="text-align: center;">
                            <div class="user_id">
                                <p>ID</p>
                            </div>
                            <div class="username">
                                <p>Username</p>
                            </div>
                            <div class="email">
                                <p>Email</p>
                            </div>
                            <div class="contact">
                                <p>Contact</p>
                            </div>
                            <div class="address">
                                <p>Action</p>
                            </div>
                        </div>

                        <c:forEach items="${staff}" var="staff">
                            <form action="${pageContext.request.contextPath}/edit-staffList" method="post" class="userInfo" style="text-align: center;">
                                <div class="user_id">
                                    <p>${staff.staff_id}</p>
                                    <input type="hidden" name="staffID" value="${staff.staff_id}" >
                                </div>
                                <div class="username">
                                    <p>${staff.username}</p>
                                    <input type="hidden" name="username" value="${staff.username}">
                                </div>
                                <div class="email" style="text-align: left;padding-left: 20px;">
                                    <p>${staff.email}</p>
                                    <input type="hidden" name="email" value="${staff.email}" >
                                </div>
                                <div class="contact">
                                    <p>${staff.contact}</p>
                                    <input type="hidden" name="contact" value="${staff.contact}" >
                                </div>
                                <div class="address">
                                    <button type="submit" name="edit" class="btnSubmit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                    <a href="${pageContext.request.contextPath}/delete-staff?staff=${staff.staff_id}" onclick="confirmDelete()" style="color: black;text-decoration: none;font-size: 18px;"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                                    <script>
                                        function confirmDelete(staffID) {
                                            if (confirm("Are you sure you want to delete this staff member?")) {
                                                window.location.href = "${pageContext.request.contextPath}/delete-staff?staff=" + staffID;
                                            }
                                            return false; // Prevent default anchor behavior
                                        }
                                    </script>
                                </div>
                            </form>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
    </body>
</html>
