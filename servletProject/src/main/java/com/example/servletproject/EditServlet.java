package com.example.servletproject;

import com.example.dao.UserDao;
import com.example.entities.Message;
import com.example.entities.User;
import com.example.helper.ConnectionProvider;
import com.example.helper.Helper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
@MultipartConfig
@WebServlet(name = "editServlet", value = "/EditServlet")
public class EditServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/html");
        // Hello
        PrintWriter out = resp.getWriter();
        String userEmail=req.getParameter("user_email");
        String userName=req.getParameter("user_name");
        String userPassword=req.getParameter("user_password");
        String userGender=req.getParameter("gender");
        Part part=req.getPart("image");
        String imageName=part.getSubmittedFileName();
        HttpSession s=req.getSession();
        User user= (User) s.getAttribute("currentUser");
        user.setEmail(userEmail);
        user.setName(userName);
        user.setPassword(userPassword);
        user.setGender(userGender);
        String oldFile=user.getProfile();
        user.setProfile(imageName);

        UserDao userDao=new UserDao(ConnectionProvider.getConnection());
        boolean ans=userDao.updateUser(user);
        if(ans){
            ServletContext servletContext=req.getSession().getServletContext();
            String path=servletContext.getRealPath("/")+"pic"+ File.separator+user.getProfile();

            String pathOldFile=servletContext.getRealPath("/")+"pic"+ File.separator+oldFile;
            System.out.println(path);
            System.out.println(pathOldFile);
            if(!oldFile.equals("default.jpg")){
                Helper.deleteFile(pathOldFile);
            }
                if(Helper.saveFile(part.getInputStream(),path)){
                    out.println("Profile updated...");
                    Message msg=new Message("Profile details updated...","success","alert-success");
                    s.setAttribute("msg",msg);
                }
                else{
                    Message msg=new Message("Profile details updated...","success","alert-success");
                    s.setAttribute("msg",msg);
                }

        }
        else{
            out.println("not updated..");
            Message msg=new Message("Something went wrong...","error","alert-danger");
            s.setAttribute("msg",msg);
        }
        resp.sendRedirect("profile.jsp");
    }

    @Override
    public void destroy() {
    }

}


