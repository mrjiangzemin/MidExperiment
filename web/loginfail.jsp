<%--
  Created by IntelliJ IDEA.
  User: suoyi
  Date: 2018/11/30
  Time: 8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆失败</title>
</head>
<body>
    <script type="text/javascript">
        function timeMsg() {
            alert('您登陆失败了\n'+'可能原因：\n' +
                '    1.用户名、密码长度不够\n' +
                '    2.用户名已存在\n'+'3.两次密码不一致');
        }
        window.onload(timeMsg());
    </script>
您登陆失败了，<a href="index.jsp" style="color: red;">点击</a>重新登录<br>
    可能原因：<br>
    1.用户名、密码长度不够<br>
    2.用户名已存在<br>
    3.两次密码不一致<br>
    这些判断我zbm没有先进行js判断直接用servlet后台进行处理,用户体验不是很好<br>
</body>
</html>
