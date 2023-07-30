<%@ page import="com.example.dao.PostDao" %>
<%@ page import="com.example.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.entities.Post" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.dao.LikeDao" %>
<%@ page import="com.example.entities.User" %><%--
  Created by IntelliJ IDEA.
  User: Atharva
  Date: 27-06-2023
  Time: 01:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Load Post</title>
</head>
<body>
<div class="row">
    <%
        User uu=(User) session.getAttribute("currentUser");
        PostDao dao=new PostDao(ConnectionProvider.getConnection());
        int cid=Integer.parseInt(request.getParameter("cid"));
        List<Post> posts=null;
        if(cid==0){
            posts=dao.getAllPosts();
        }
        else{
            posts= dao.getPostByCatId(cid);
        }
        if(posts.size()==0){
            PrintWriter cout = response.getWriter();
            cout.println("<h3 class='display-3 text-center'>No posts in this category...</h3>");
            return;
        }
        for(Post p:posts){

    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%=p.getpTitle()%></b>
                <p><%=p.getpContent()%></p>
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="text-center btn  btn-sm">Read More...</a>

            </div>
            <div class="card-footer primary-background text-center">

<%--                <br>--%>
<%--                <br>--%>
                <%
                    LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                %>
                <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=uu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counterG"><%=ld.countLikeOnPost(p.getPid())%></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>



            </div>
        </div>
    </div>
<%
        }
        %>
</div>
</body>
</html>
