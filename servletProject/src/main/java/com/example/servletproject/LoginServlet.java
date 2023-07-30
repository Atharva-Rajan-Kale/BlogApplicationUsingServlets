package com.example.servletproject;

import com.example.dao.UserDao;
import com.example.entities.Message;
import com.example.entities.User;
import com.example.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "loginServlet", value = "/LoginServlet")

public class LoginServlet extends HttpServlet {


    @Override
    public void init() throws ServletException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        String userEmail=req.getParameter("email");
        String userPassword=req.getParameter("password");

        UserDao dao=new UserDao(ConnectionProvider.getConnection());
        User u=dao.getUserByEmailAndPassword(userEmail,userPassword);
        if(u==null){
//            out.println("Invalid Details...Please Try again");
            Message msg=new Message("Invalid Details! Please try again","error","alert-danger");
            HttpSession s=req.getSession();
            s.setAttribute("msg",msg);
            resp.sendRedirect("login_page.jsp");
        }
        else{
            HttpSession s=req.getSession();
            s.setAttribute("currentUser",u);
            resp.sendRedirect("profile.jsp");
        }
    }
    @Override
    public void destroy() {

    }
}
