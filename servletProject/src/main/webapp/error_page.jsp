  Created by IntelliJ IDEA.
  User: Atharva
  Date: 11-06-2023
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<html>
<head>
    <title>Sorry! Something went wrong...</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="CSS/myStyle.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .banner-background{
            clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 100%, 70% 90%, 30% 100%, 0 90%, 0% 30%);
        }
    </style>

</head>
<body>
    <div class="container text-center">
        <img src="Images/computer.png" style="width:500px; padding-top: 40px" class="img-fluid">
        <h3 class="display-3">Sorry! Something went wrong...</h3>
        <%= exception%>
        <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
    </div>
</body>
</html>
