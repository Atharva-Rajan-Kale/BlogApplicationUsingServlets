package com.example.servletproject;

import com.example.entities.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "logoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        // Hello
        PrintWriter out = resp.getWriter();
        HttpSession s= req.getSession();
        s.removeAttribute("currentUser");
        Message m=new Message("Logged Out Successfully","success","alert-success");
        s.setAttribute("msg",m);
        resp.sendRedirect("login_page.jsp");

    }

    @Override
    public void destroy() {
    }


}
