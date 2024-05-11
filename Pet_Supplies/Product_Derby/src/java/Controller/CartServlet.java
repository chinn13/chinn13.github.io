/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import Model.Cart;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartServlet extends HttpServlet {
    
    CartDAO cartDao;
    
    public CartServlet() throws ClassNotFoundException {
        this.cartDao = new CartDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/delete-cart":
                    Delete_Cart(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/add-cart":
                    Add_Cart(request, response);
                    break;
                case "/edit-cart":
                    Edit_Cart(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    // ../add-cart (Servlet)
    // GET Method FROM Guest/home.jsp
    private void Add_Cart(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();
        
        String submit = request.getParameter("btnSubmit");
        
        if ("AddToCart".equalsIgnoreCase(submit)) {
            try {
                HttpSession session = request.getSession();
                User user = new User();
                user.setUser_id((Integer) session.getAttribute("user_id"));
                
                String product_id = request.getParameter("product");
                
                String qtyPost = request.getParameter("qty");
                
                int prodID = Integer.parseInt(product_id);
                int qty = Integer.parseInt(qtyPost);
                
                Cart cart = new Cart(prodID, qty, user);
                
                out.print(prodID +","+ qty);
                cartDao.add_cart(cart);

                response.sendRedirect("cart-list");
//                request.getRequestDispatcher("cart-list" + prodID).forward(request, response);
            } catch (Exception e) {
                out.println("Database Error: " + e.getMessage());
            }
        } else if ("Login".equalsIgnoreCase(submit)) {
            response.sendRedirect("Guest/login.jsp");
        }
        
    }

    // ../edit-cart (Servlet)
    // redirect FROM ../cart-list (Servlet)
    private void Edit_Cart(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));
        
        String cartPost = request.getParameter("submit");
        int cartID = Integer.parseInt(cartPost);
        
        String namePost = request.getParameter("name");
        String qtyPost = request.getParameter("qty");
        
        int qty = Integer.parseInt(qtyPost);
        
        Cart cart = new Cart(cartID, qty, user);
        cartDao.edit_cart(cart);
        
        response.sendRedirect("cart-list");
    }

    // ../delete-cart (Servlet)
    // redirect FROM ../cart (Servlet)
    private void Delete_Cart(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        
        HttpSession session = request.getSession();
        User user = new User();
        user.setUser_id((Integer) session.getAttribute("user_id"));
        
        String idGet = request.getParameter("del");
        
        String qtyGet = request.getParameter("qty");
        int cartID = Integer.parseInt(idGet);
        int qty = Integer.parseInt(qtyGet);
        
        Cart cart = new Cart(cartID, qty, user);
        cartDao.delete_cart(cart);
        
        response.sendRedirect("cart-list");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
