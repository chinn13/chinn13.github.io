package Controller;

import DAO.AdminDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class UploadServlet extends HttpServlet {

    AdminDAO adminDAO;

    public UploadServlet() throws ClassNotFoundException {
        this.adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String action = request.getServletPath();

        try {
            switch (action) {
                case "/edit-image":
                    Edit_Image(request, response);
                    break;
                case "/add-image":
                    Add_Image(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DisplayServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void Edit_Image(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        int prodID = Integer.parseInt(request.getParameter("product_id"));
        out.print(prodID);

        Part part = request.getPart("upload");
        String filename = part.getSubmittedFileName();
        out.print("<h1>Filename: " + filename + "</h1>");

        String basePath = getServletContext().getRealPath("/");
        if (basePath == null) {
            out.print("Failed to get base path.");
            return;
        }

        String path = basePath + "images" + File.separator + filename;
        out.print("<h1>Path: " + path + "</h1>");

        //C:\Users\chxxp\OneDrive\Documents\NetBeansProjects\Product\build\web\images\
        InputStream is = part.getInputStream();
        boolean success = uploadFile(is, path);

        adminDAO.edit_image(prodID, filename);

        is.close();

        request.setAttribute("filename", "images/" + filename);
        request.getRequestDispatcher("edit-list").forward(request, response);
    }

    private void Add_Image(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        PrintWriter out = response.getWriter();

        Part part = request.getPart("upload");
        String filename = part.getSubmittedFileName();
        out.print("<h1>Filename: " + filename + "</h1>");

        String basePath = getServletContext().getRealPath("/");
        if (basePath == null) {
            out.print("Failed to get base path.");
            return;
        }

        String path = basePath + "images" + File.separator + filename;
        out.print("<h1>Path: " + path + "</h1>");

        //C:\Users\chxxp\OneDrive\Documents\NetBeansProjects\Product\build\web\images\
        InputStream is = part.getInputStream();
        boolean success = uploadFile(is, path);

        is.close();

        request.setAttribute("filename", "images/" + filename);
        request.getRequestDispatcher("Admin/add-product.jsp").forward(request, response);
    }

    public boolean uploadFile(InputStream is, String path) {
        boolean test = false;
        try {
            byte[] buffer = new byte[1024];
            int bytesRead;
            OutputStream os = new FileOutputStream(path);
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.flush();
            os.close();

            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for uploading files";
    }
}
