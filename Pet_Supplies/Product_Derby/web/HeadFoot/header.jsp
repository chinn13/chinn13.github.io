
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String host = "jdbc:derby://localhost:1527/pet_supplies";
    String username = "nbuser";
    String pass = "nbuser";

    Connection conn = null;
    PreparedStatement stmt = null;
    Statement stmtPet = null;
    ResultSet rs = null;

    int count = 0;

    Integer user = (Integer) session.getAttribute("user_id");
    if (user != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, username, pass);

            String sqlUser = "SELECT * FROM cart WHERE user_id = ?";
            stmt = conn.prepareStatement(sqlUser);
            stmt.setInt(1, user);
            rs = stmt.executeQuery();

            while (rs.next()) {
                count++;
            }
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("Error loading JDBC Driver: " + e.getMessage());
        }
    } else {
        count = 0;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petLogin.css">
        <title>Header</title>
    </head>
    <body>

        <div class="topPanel">
            <c:choose>
                <c:when test="${user_id != null}">
                    <p>
                        <a href="${pageContext.request.contextPath}/displayProfile">PROFILE</a>
                        <a href="${pageContext.request.contextPath}/logout">SIGN OUT</a>
                    </p>
                </c:when>
                <c:otherwise>
                    <p>
                        <a href="${pageContext.request.contextPath}/Guest/login.jsp">SIGN IN</a>
                        <a href="${pageContext.request.contextPath}/Guest/login.jsp">CREATE AN ACCOUNT</a>
                    </p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="btmPanel">

            <div id="reminder">
                <p>You have no items in your cart</p>
            </div>

            <div class="panel">
                <a href="${pageContext.request.contextPath}/all"><img class="logo" src="${pageContext.request.contextPath}/images/logo.png" alt=""></a>
                <div class="bar">
                    <div class="searchBar">
                        <input type="text" name="searchContent" id="searchContent" placeholder="Search...">
                    </div>
                    <div class="categoriesBar">

                        <select name="categoriesSelect">
                            <c:forEach items="${petList}" var="pet">
                                <option value="${pet.animal}">${pet.animal}</option>
                            </c:forEach>
                        </select>

                    </div>
                    <div class="searchIcon">
                        <a href=""><i class="fa fa-search" aria-hidden="true"></i></a>
                    </div>
                    <div class="empty"></div>
                </div>
            </div>

            <div class="cartBar">
                <a href="${pageContext.request.contextPath}/cart-list" id="cartLink">
                    <i class="fa fa-shopping-bag" aria-hidden="true"></i>
                    <div class="cartQty">
                        <span><%=count%></span>
                    </div>
                </a>
                <c:if test="${not empty user_id && loginRole eq 'customer'}">
                    <a href="${pageContext.request.contextPath}/profile" class="profile">
                        <i class="fa fa-user" aria-hidden="true"></i>
                    </a>
                </c:if>

            </div>
        </div>

        <form action="">
            <p class="dropdownBar">
                <span class="list"><a href="${pageContext.request.contextPath}/Guest/home.jsp">Home</a></span>
                <span class="list"><a href="${pageContext.request.contextPath}/filter-list?action=D">Dog<i class="fa fa-angle-down" aria-hidden="true"></i></a></span>
                <span class="list"><a href="${pageContext.request.contextPath}/filter-list?action=C">Cat<i class="fa fa-angle-down" aria-hidden="true"></i></a></span>
                <span class="list"><a href="${pageContext.request.contextPath}/filter-list?action=S">Small animals<i class="fa fa-angle-down" aria-hidden="true"></i></a></span>
                <span class="list"><a href="${pageContext.request.contextPath}/filter-list?action=T">Top picks of the month</a></span>
            </p>
        </form>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var cartQty = document.querySelector(".cartQty");
                var reminder = document.getElementById("reminder");
                var cartLink = document.getElementById("cartLink");

                // Event listener to toggle reminder visibility and prevent navigation if count is 0
                cartLink.addEventListener("click", function (event) {
                    if (parseInt(cartQty.innerText) === 0) {
                        event.preventDefault();
                        toggleReminderVisibility(); // Toggle the visibility of the reminder
                    }
                });

                document.addEventListener("click", function (event) {
                    if (!reminder.contains(event.target) && !cartLink.contains(event.target)) {
                        reminder.style.display = "none";
                    }
                });

                // Function to toggle reminder visibility
                function toggleReminderVisibility() {
                    if (reminder.style.display === "flex") {
                        reminder.style.display = "none"; // Hide the reminder if it's already open
                    } else {
                        reminder.style.display = "flex"; // Show the reminder if it's closed
                    }
                }
            });



        </script>
    </body>
</html>
