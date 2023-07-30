package com.example.servletproject;

import com.example.dao.PostDao;
import com.example.entities.Post;
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
@WebServlet(name = "addPostServlet",value = "/AddPostServlet")
public class AddPostServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        // Hello
        PrintWriter out = resp.getWriter();
        int cid=Integer.parseInt(req.getParameter("cid"));
        String pTitle=req.getParameter("pTitle");
//        out.println("post title: "+pTitle);
        String pContent=req.getParameter("pContent");
        String pCode=req.getParameter("pCode");
        Part part=req.getPart("pic");
//        out.println(part.getSubmittedFileName());
        HttpSession session=req.getSession();
        User user= (User) session.getAttribute("currentUser");
        Post p=new Post(pTitle,pContent,pCode,part.getSubmittedFileName(),null,cid, user.getId());
        PostDao dao=new PostDao(ConnectionProvider.getConnection());
        if(dao.savePost(p)){

            ServletContext servletContext=req.getSession().getServletContext();
            String path=servletContext.getRealPath("/")+"blog_pics"+ File.separator+part.getSubmittedFileName();
            Helper.saveFile(part.getInputStream(),path);
            out.println("done");
        }else{
            out.println("error");
        }
    }

    @Override
    public void destroy() {
    }


}
