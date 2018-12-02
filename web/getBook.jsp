<%--
  Created by IntelliJ IDEA.
  User: suoyi
  Date: 2018/12/1
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<html>
<head>
    <title>getBook</title>
    <style>
        /*更改了单本书显示的样式*/
        .thumbnail{
            padding-top: 50px;
            height: 400px;
        }
        .des{
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            overflow: hidden;
        }
    </style>
</head>
<body>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/bookstore?useSSL=false";
    Connection conn = DriverManager.getConnection(url, "root", "123456");
    String sql = "select * from book" +
            " where category_id = ?";
    String categoryID = request.getParameter("id");
    PreparedStatement pstat = conn.prepareStatement(sql);
    pstat.setString(1,categoryID);
    ResultSet rs = pstat.executeQuery();
    while (rs.next()) {
%>
<div class="col-sm-9 col-md-3">
    <div class="thumbnail" >
        <img src="<%=rs.getString("image")%>">
        <div class="caption">
            <h4>
                <%=rs.getString("name")%>
            </h4>
            <p class="des"><%=rs.getString("description")%></p>
            <p>
                <a href="#" class="btn btn-primary" role="button">加入购物车</a>
                <a href="#" class="btn btn-default" role="button">查看详情</a>
            </p>
        </div>
    </div>
</div>
<%
    }
    pstat.close();
    conn.close();
%>
</body>
</html>

