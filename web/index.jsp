<%--
  Created by IntelliJ IDEA.
  User: suoyi
  Date: 2018/11/30
  Time: 8:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.DriverManager" %>
<html>
  <head>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <title>网上书店</title>
  </head>
  <body onload="initAJAX()">
  <div class="header">
    <div class="container">
      <div class="row">
        <div class="login span4">
            <%--判断用户登录情况更改页面--%>
            <% if(session.getAttribute("username")==null){%>
          <h1><a href="">欢迎来到<strong >我的</strong>书店</a>
           <span class="red">.</span> </h1>
            <% }else{%>
            <h1><a href="">欢迎用户<strong style="color:red;"><%=session.getAttribute("username")%></strong>来到我的书店</a>
                <span class="red">.</span> </h1>
            <%}%>
        </div>
        <div class="links span8">
            <% if(session.getAttribute("username")==null){%>
          <a class="login" href="login.html" rel="tooltip" data-placement="bottom"
           data-toggle="modal" data-target="#myModal"></a>
          <a class="register" href="newlogup.html" rel="tooltip" data-placement="bottom"
             data-toggle="modal" data-target="#myModal"></a>
            <%}else{%>
            <a class="logout" href="logout.html" rel="tooltip" data-placement="bottom"
               data-toggle="modal" data-target="#myModal"></a>
            <%}%>
        </div>
      </div>
    </div>
  </div><!--header-->
  <div class="row"><%--下方左右div控制--%>
    <div class="col-md-3"><%--左侧菜单div控制--%>
      <ul class="nav nav-list">
        <li class="navbar-header">书籍类型</li><br/>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/bookstore?useSSL=false";
            Connection conn = DriverManager.getConnection(url, "root", "123456");
            String sql="select * from category;";
            Statement stat=conn.createStatement();
            ResultSet rs=stat.executeQuery(sql);
            while(rs.next())
            {
        %>
          <li>
              <a href='javascript:showBook("<%=rs.getString("id")%>")'><%=rs.getString("name")%></a>
          </li>
          <%
              }
              stat.close();
              conn.close();
          %>
      </ul>
    </div><%--左侧菜单div控制--%>
      <div class="col-md-9" id="book"> <%--书籍布局控制--%>

      </div>
  </div><%--下方左右div控制--%>


  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header"></div>
        <div class="modal-body"></div>
        <div class="modal-footer"></div>
      </div>
    </div>
  </div>

  <%--ajax方法实现异步获取--%>
  <script language="JavaScript">
      function showBook(categoryID) {
          xmlHttp.onreadystatechange = function() {
              if (xmlHttp.readyState == 4) {
                  if(xmlHttp.status == 200) {
                      var data = xmlHttp.responseText;
                      document.getElementById("book").innerHTML = data;
                  }
              }
          }
          xmlHttp.open("GET", "getBook.jsp?id="+categoryID, true);
          xmlHttp.send();
      }
  </script>
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/commons.js"></script>
  </body>
</html>
