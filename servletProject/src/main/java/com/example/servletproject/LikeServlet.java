package com.example.servletproject;

import com.example.dao.LikeDao;
import com.example.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "likeServlet", value = "/LikeServlet")
public class LikeServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {

        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        String operation=req.getParameter("operation");
        int uid=Integer.parseInt(req.getParameter("uid"));
        int pid=Integer.parseInt(req.getParameter("pid"));
//        out.println("data from server");
//        out.println(uid);
//        out.println(pid);
        LikeDao ldao=new LikeDao(ConnectionProvider.getConnection());
        if(operation.equals("like")){
            boolean f=ldao.insertLike(pid,uid);
            out.println(f);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }


}
