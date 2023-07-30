package com.example.servletproject;

import java.io.*;

import com.example.dao.UserDao;
import com.example.entities.User;
import com.example.helper.ConnectionProvider;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@MultipartConfig
@WebServlet(name = "registerServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    public void init(){

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();

        String check=request.getParameter("check");
        if(check==null){
            out.println("Please check the checkbox if you want to proceed");

        }
        else{
            String name=request.getParameter("user_name");
            String email=request.getParameter("user_email");
            String password=request.getParameter("user_password");
            String gender=request.getParameter("gender");

            User user=new User(name,email,password,gender);
            UserDao dao=new UserDao(ConnectionProvider.getConnection());
            if(dao.saveUser(user)){
                out.println("done");
            }else{
                out.println("error");
            }
        }

    }

    public void destroy() {
    }
}