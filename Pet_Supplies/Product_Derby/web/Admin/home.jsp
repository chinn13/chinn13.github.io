
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

                <div class="adminRight" style="text-transform: uppercase;">
                    <h2>HI, ${loginRole}</h2>
                </div>
            </div>
            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>  
    </body>
</html>
