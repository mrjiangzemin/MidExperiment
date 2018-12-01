<%--
  Created by IntelliJ IDEA.
  User: suoyi
  Date: 2018/11/30
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册失败</title>
</head>
<body>
<script type="text/javascript">
    function timeMsg() {
        alert('您注册失败了\n'+'可能原因：\n' +
            '1.用户名重复\n' +
            '2.两次密码不一致\n' +
            '3.密码长度不够\n' +
            '4.用户名长度不够');
    }
    window.onload(timeMsg());
</script>
您注册失败了，<a href="index.jsp" style="color: red;">点击</a>重新注册
可能原因：<br>
1.用户名重复<br>
2.两次密码不一致<br>
3.密码长度不够<br>
4.用户名长度不够<br>
</body>
</html>
