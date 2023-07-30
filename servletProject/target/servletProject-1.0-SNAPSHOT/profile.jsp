<%@ page import="com.example.entities.User" %>
<%@ page import="com.example.entities.Message" %>
<%@ page import="com.example.dao.PostDao" %>
<%@ page import="com.example.helper.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.entities.Category" %>
<%@page errorPage="error_page.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Atharva
  Date: 12-06-2023
  Time: 00:54
  To change this template use File | Settings | File Templates.
--%>
<%
    User user=(User) session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="CSS/myStyle.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .banner-background{
            clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 100%, 70% 90%, 30% 100%, 0 90%, 0% 30%);
        }
        body{
            background-size: cover;
            background: url("Images/blog_bg.jpg") fixed;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="JS/myJS.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>

    <script>
        $(document).ready(function(){
            let editStatus=false;
            $('#edit-profile-button').click(function(){
                if(editStatus==false){
                    $("#profile-details").hide()
                    $("#profile-edit").show()
                    editStatus=true;
                    $(this).text("Back")
                }else{
                    $("#profile-details").show()
                    $("#profile-edit").hide()
                    editStatus=false;
                    $(this).text("Edit")

                }
            })
        });
    </script>

<%-- post   js--%>
    <script>
        $(document).ready(function (e){
            $("#add-post-form").on("submit",function (event){
                event.preventDefault();
                console.log("you have clicked on submit..")
                let form=new FormData(this);
                $.ajax({
                    url:"AddPostServlet",
                    type:"POST",
                    data:form,
                    success:function (data,textStatus,jqXHR) {
                        console.log(data);
                        if(data.trim()=='done'){
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Your work has been saved',
                                showConfirmButton: false,
                                timer: 1500
                            })
                                .then((value)=>{
                                    window.location = "profile.jsp"
                                });
                        }
                        else{
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong! Try again...',
                            })
                        }
                    },
                    error:function (jqXHR,textStatus,errorThrown){
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Something went wrong! Try again...',
                        })
                    },
                    processData:false,
                    contentType:false
                })
            })
        })
    </script>

    <script>
        function getPost(catId,temp){
            $("#loader").show();
            $("#post-container").hide();
            $(".c-link").removeClass('active')
            $.ajax({
                url:"load_posts.jsp",
                data:{cid:catId},
                success:function (data,textStatus,jqXHR){
                    console.log(data);
                    $("#loader").hide();
                    $("#post-container").show();
                    $("#post-container").html(data)
                    $(temp).addClass('active')
                }
            })
        }
        $(document).ready(function(e){
            let allPostRef=$('.c-link')[0]
        getPost(0,allPostRef)
        })
    </script>
</head>
<body>
<%----%>
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-graduation-cap"></span>skillBlog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fa fa-shopping-basket"></span>
                    Categories
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Programming Language</a>
                    <a class="dropdown-item" href="#">Project Implementation</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Data Structure</a>
                </div>
            </li>
            <%--      <li class="nav-item">--%>
            <%--        <a class="nav-link enabled" href="#">More</a>--%>
            <%--      </li>--%>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> Contact</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-magic"></span> Post</a>
            </li>

        </ul>
        <ul class="navbar-nav mr-right">
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet"><span class="fa fa-users"></span> Logout</a>
            </li>
        </ul>
    </div>
</nav>

<%----%>
<%
    Message m= (Message) session.getAttribute("msg");
    if(m!=null){
%>
<div class="alert <%= m.getCssClass()%>" role="alert">
    <%= m.getContent()%>
</div>
<%
        session.removeAttribute("msg");
    }
%>


<%--main body--%>
<main>
    <div class="container">
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="list-group">
                    <a href="#" onclick="getPost(0,this)" class=" c-link list-group-item list-group-item-action active">Posts</a>
                    <%
                        PostDao d=new PostDao(ConnectionProvider.getConnection());
                        ArrayList<Category> list1=d.getAllCategories();
                        for(Category cc:list1){
                    %>
                    <a href="#" onclick="getPost(<%= cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                        <%
                        }
                        %>

                </div>
            </div>
            <div class="col-md-8">
                <div class="container text-center" id="loader">
                    <i class="fa fa-refresh fa-2x fa-spin"></i>
                    <h3 class="mt-2">Loading...</h3>
                </div>
                <div class="container-fluid"  id="post-container">

                </div>
            </div>
        </div>
    </div>
</main>
<%----%>

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header primary-background text-white text-center">
                <h5 class="modal-title " id="exampleModalLabel">Profile</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
               <img src="pic/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 50%;max-width: 150px;">
                <br>
                <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
                <div id="profile-details">
                    <table class="table">
                    <tbody>
<%--                    <tr>--%>
<%--                        <th scope="row">ID :</th>--%>
<%--                        <td><%=user.getId()%></td>--%>

<%--                    </tr>--%>
                    <tr>
                        <th scope="row">Email : </th>
                        <td><%=user.getEmail()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Gender : </th>
                        <td><%=user.getGender().toUpperCase()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Registered On : </th>
                        <td><%=user.getDateTime().toString()%></td>
                    </tr>
                    </tbody>
                </table>
                </div>
                <div id="profile-edit" style="display: none;">
                    <h3 class="mt-2">Please Edit Carefully</h3>
                    <form action="EditServlet" method="post" enctype="multipart/form-data">
                        <table class="table">
<%--                            <tr>--%>
<%--                                <td>ID : </td>--%>
<%--                                <td><%=user.getId()%></td>--%>
<%--                            </tr>--%>

                            <tr>
                                <td>Email : </td>
                                <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                            </tr>
                            <tr>
                                <td>Name : </td>
                                <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                            </tr>
                            <tr>
                                <td>Password : </td>
                                <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                            </tr>
                            <tr>
                                <td>Gender : </td>
                                <td><input type="text" class="form-control" name="gender" value="<%=user.getGender().toUpperCase()%>"></td>
                            </tr>
                            <tr>
                                <td>New Profile : </td>
                                <td><input type="file" class="form-control" name="image"></td>
                            </tr>
                        </table>
                        <div class="container">
                            <button type="submit" class="btn btn-outline-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Post Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="add-post-form" action="AddPostServlet" method="post">

                    <div class="form-group" >
                        <select class="form-control" name="cid">
                            <option selected disabled>---Select Category---</option>
                            <%
                                PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list=postd.getAllCategories();
                                for(Category c:list){
                            %>
                            <option value="<%= c.getCid()%>"><%=c.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <input type="text" name="pTitle" placeholder="Enter Post Title" class="form-control"/>
                    </div>


                <div class="form-group">
                    <textarea class="form-control" name="pContent" style="height: 200px;" placeholder="Enter your content"></textarea>
                </div>
                <div class="form-group">
                    <textarea class="form-control" name="pCode" style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
                </div>
                <div class="form-group">
                    <label>Select a pic</label>
                    <br>
                    <input type="file" name="pic" >
                </div>
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>
            </form>
            </div>

        </div>
    </div>
</div>
</body>
</html>
