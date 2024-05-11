<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="../css/topSales.css" rel="stylesheet" type="text/css"/>
    <title>Top 10 Sales Products</title>
</head>
<body>
    
    <div class="box">
    <jsp:include page="../HeadFoot/header.jsp"/>

    <div class="adminbar">
        <jsp:include page="../HeadFoot/LeftBar.jsp"/>
        
        
    <div class="adminRight">
    <div class="order">
    <h1>Top 10 Sales Products</h1>
    </div>
    <table class="tableContent"; border="1">
        <tr>
            <th>Rank</th>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Total Quantity Sold</th>
        </tr>
        <% 
            String host = "jdbc:derby://localhost:1527/pet_supplies";
            String user = "nbuser";
            String password = "nbuser";
            Connection conn = null; 
            Statement stmt = null; 
            
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection(host, user, password);
                stmt = conn.createStatement();
                String query = "SELECT p.product_id, MAX(p.name) AS product_name, SUM(od.qty) AS total_qty_sold " +
                               "FROM orderdetail od " +
                               "JOIN product p ON od.product_id = p.product_id " +
                               "JOIN order_ o ON od.order_id = o.order_id " +
                               "GROUP BY p.product_id " +
                               "ORDER BY total_qty_sold DESC";
                ResultSet rs = stmt.executeQuery(query);
                int count = 0;
                while (rs.next() && count < 10) {
                    count++;
                    String productID = rs.getString("product_id");
                    String productName = rs.getString("product_name");
                    int totalQtySold = rs.getInt("total_qty_sold");
        %>
        <tr>
            <td><%= count %></td>
            <td><%= productID %></td>
            <td><%= productName %></td>
            <td><%= totalQtySold %></td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                out.println("Database Error: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("Error loading JDBC Driver: " + e.getMessage());
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("Error closing database connection: " + e.getMessage());
                }
            }
        %>
    </table>
                
            </div>
         </div>
                     <jsp:include page="../HeadFoot/footer.jsp"/>
    
  </div>
</body>
</html>