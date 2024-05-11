<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.awt.event.*" %>
<%@ page import="javax.swing.*;" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%   
    String host = "jdbc:derby://localhost:1527/pet_supplies";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "ORDER_";
    Connection conn = null; 
    PreparedStatement stmt = null; 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="../css/pet.css" rel="stylesheet" type="text/css"/>
    <link href="../css/adminreport.css" rel="stylesheet" type="text/css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report</title>
</head>
<body>
<div class="box">
    <jsp:include page="../HeadFoot/header.jsp"/>

    <div class="adminbar">
        <jsp:include page="../HeadFoot/LeftBar.jsp"/>

        <div class="adminRight">
            <div class="order">
                <h1>Sales Report</h1></div>
                <div class="orderList">
                    <form action="" method="GET">
                        <label for="startDate">Start Date :</label> 
                        <input type="text" id="startDate" name="startDate" placeholder="dd/mm/yyyy">
                        <label for="endDate">End Date :</label>
                        <input type="text" id="endDate" name="endDate" placeholder="dd/mm/yyyy">
                        <input type="submit" value="Filter">
                    </form>
                </div>
                <div class="">
                    <table class="tableContent">
                        <tr>
                            <th class="order_id">Order ID</th>
                            <th class="qty">Quantity</th>
                            <th class="amount">Amount</th>
                            <th class="createDate">Create Date</th>
                            <th class="status">Status</th>
                        </tr>
                        <% 
                            String startDate = request.getParameter("startDate");
                            String endDate = request.getParameter("endDate");

                            // Validate if start and end dates are not empty
                            if (startDate == null || endDate == null || startDate.isEmpty() || endDate.isEmpty()) {
                                // Set default values or display an error message
                                startDate = endDate = java.time.LocalDate.now().toString();
                            } else {
                                try {
                                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                                    conn = DriverManager.getConnection(host, user, password);

                                    // Parse start and end dates
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                    java.util.Date parsedStartDate = dateFormat.parse(startDate);
                                    java.util.Date parsedEndDate = dateFormat.parse(endDate);

                                    // Convert parsed dates to Timestamps using yyyy-MM-dd format
                                    SimpleDateFormat timestampFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    Timestamp startTimestamp = new Timestamp(parsedStartDate.getTime());
                                    Timestamp endTimestamp = new Timestamp(parsedEndDate.getTime() + (24 * 60 * 60 * 1000 - 1)); // End of the day

                                    // Retrieve orders within the selected date range
                                    String selectSql = "SELECT * FROM " + tableName + " WHERE CREATEDATE >= ? AND CREATEDATE <= ? AND STATUS = 'Paid'";
                                    stmt = conn.prepareStatement(selectSql);
                                    stmt.setTimestamp(1, startTimestamp);
                                    stmt.setTimestamp(2, endTimestamp);
                                    ResultSet rs = stmt.executeQuery();

                                    // Display orders within the selected date range on the webpage
                                    while (rs.next()) {
                                        String orderID = rs.getString("ORDER_ID");
                                        int qty = rs.getInt("QTY");
                                        double amount = rs.getDouble("AMOUNT");
                                        Timestamp createDate = rs.getTimestamp("CREATEDATE");
                                        String status = rs.getString("STATUS");
                        %>
                        <tr>
                            <td><%= orderID %></td>
                            <td><%= qty %></td>
                            <td><%= amount %></td>
                            <td><%= createDate %></td>
                            <td><%= status %></td>
                        </tr>
                        <%
                                    }
                                } catch (SQLException e) {
                                    out.println("Database Error: " + e.getMessage());
                                } catch (ClassNotFoundException e) {
                                    out.println("Error loading JDBC Driver: " + e.getMessage());
                                } catch (ParseException e) {
                                    out.println("Error parsing date: " + e.getMessage());
                                } finally {
                                    // Close resources
                                    try {
                                        if (stmt != null) stmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        out.println("Error closing database connection: " + e.getMessage());
                                    }
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
                     <jsp:include page="../HeadFoot/footer.jsp"/>
    </div>

</body>

<script>
    // Function to retain text in textboxes after form submission
    function keepText() {
        // Retrieve the values entered by the user
        var startDate = document.getElementById("startDate").value;
        var endDate = document.getElementById("endDate").value;

        // Store the values in localStorage
        localStorage.setItem("startDate", startDate);
        localStorage.setItem("endDate", endDate);

        return true;
    }

    // Function to restore text from localStorage
    window.onload = function() {
        var startDate = localStorage.getItem("startDate");
        var endDate = localStorage.getItem("endDate");

        // Set the values in the textboxes
        document.getElementById("startDate").value = startDate;
        document.getElementById("endDate").value = endDate;
    }
</script>
</html>