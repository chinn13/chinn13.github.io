/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AdminDAO;
import Model.Customer;
import Model.Order;
import Model.OrderDetail;
import Model.Pet;
import Model.Product;
import Model.Staff;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminServlet extends HttpServlet {
    
    AdminDAO adminDao;

    public AdminServlet() throws ClassNotFoundException {
        this.adminDao = new AdminDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/product-list":
                    Product_List(request, response);
                    break;
                case "/order-list":
                    Order_List(request, response);
                    break;
                case "/cust-list":
                    Cust_List(request, response);
                    break;
                case "/staff-list":
                    Staff_List(request, response);
                    break;
                case "/remove-product":
                    Remove_Product(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/add-product":
                    Add_Product(request, response);
                    break;
                case "/edit-product":
                    Edit_Product(request, response);
                    break;
                case "/detail-list":
                    Detail_List(request, response);
                    break;
                case "/edit-list":
                    Edit_List(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // ../prepare-edit-product
    private void Edit_List(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();
        
        int prodID = Integer.parseInt(request.getParameter("product_id"));
        
        Product prod = new Product();
        prod.setId(prodID);
        
        try {
            Product product = adminDao.edit_list(prodID);
            
            request.setAttribute("product", product);
            
            request.getRequestDispatcher("Admin/edit-product.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../edit-product
    private void Edit_Product(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();
        
        int prodID = Integer.parseInt(request.getParameter("product_id"));
        String image = request.getParameter("image");
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int qty = Integer.parseInt(request.getParameter("qty"));
        double price = Double.parseDouble(request.getParameter("price"));
        Pet pet = new Pet();
        pet.setPet_id(request.getParameter("pet"));
        
        Product product = new Product(prodID, type, name, qty, price, description, image, pet);

        adminDao.edit_product(product);
        
        request.setAttribute("editPet", pet.getPet_id());
        response.sendRedirect("product-list");
    }
    
    // ../remove-product
    private void Remove_Product(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int prodID = Integer.parseInt(request.getParameter("product"));
        adminDao.remove_product(prodID);
        
        response.sendRedirect("product-list");
    }
    
    // ../add-product
    private void Add_Product(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        
        PrintWriter out = response.getWriter();
        
        String image = request.getParameter("image");
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int qty = Integer.parseInt(request.getParameter("qty"));
        double price = Double.parseDouble(request.getParameter("price"));
        
        Pet pet = new Pet();
        pet.setPet_id(request.getParameter("pet"));

//        C:\Users\chxxp\OneDrive\Documents\NetBeansProjects\Product\build\web\images\
        try {
            Product product = new Product(type, name, qty, price, description, image, pet);
            adminDao.add_product(product);
            
            response.sendRedirect("product-list");
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../product-list
    private void Product_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        PrintWriter out = response.getWriter();
        
        try {
            List<Product> productList = adminDao.product_list();
            
            request.setAttribute("productList", productList);
            
            request.getRequestDispatcher("Admin/product-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../staff-list
    private void Staff_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();
        try {
            List<Staff> staff = adminDao.staff_list();
            
            request.setAttribute("staff", staff);
            
            request.getRequestDispatcher("Admin/staff-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../cust-list
    private void Cust_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();
        try {
            List<Customer> customer = adminDao.cust_list();
            
            request.setAttribute("cust", customer);
            
            request.getRequestDispatcher("Admin/cust-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../order-list
    private void Order_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        PrintWriter out = response.getWriter();
        
        try {
            List<Order> adminOrderList = adminDao.order_list();
            
            request.setAttribute("adminOrderList", adminOrderList);
            request.getRequestDispatcher("Admin/order-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    // ../detail-list
    private void Detail_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        PrintWriter out = response.getWriter();
        
        Order order = new Order();
        order.setOrder_id(request.getParameter("order_id"));
        
        try {
            Order adminOrderInfo = adminDao.order_list(order);
            List<OrderDetail> adminOrderDetail = adminDao.detail_list(order);
            int status = adminDao.detail_status(order);
            
            request.setAttribute("adminOrderInfo", adminOrderInfo);
            request.setAttribute("adminOrderDetail", adminOrderDetail);
            request.setAttribute("status", status);
            
            out.print(order.getOrder_id());
            out.print(adminOrderDetail);
            out.print(status);
            
//            for(OrderDetail detail: adminOrderDetail){
//                out.print(detail.getProduct().getName());
//            }
//            
            request.getRequestDispatcher("Admin/detail-list.jsp").forward(request, response);
        } catch (SQLException e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
