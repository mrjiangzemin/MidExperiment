package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "LogupServlet")
public class LogupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        if (username.equals("")) {
            response.sendRedirect("/logupfail.jsp");
        } else {
            //连接数据库，进行用户匹配
            Connection conn = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/bookstore?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "123456");
                String sql = "select username from user where username= \'" + username + "';";
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery(sql);
                if (rs.next()) {
                    response.sendRedirect("/logupfail.jsp");
                } else {
                    //下一步，注册用户
                    //如果失败的话，可以传递一个错误信息session，给第二个页面输出给用户方便下次注册
                    if (password.equals(repassword) && password.length() >= 6) {
                        String sql2 = "insert into user(username,password) value(?,?)";
                        PreparedStatement pStat = (PreparedStatement) conn.prepareStatement(sql2);
                        pStat.setString(1, username);
                        pStat.setString(2, password);
                        int success = pStat.executeUpdate();
                        if (success == 1) {
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);
                            session.setAttribute("userStatus", "successs");
                            response.sendRedirect("/index.jsp");
                        }
                    } else {
                        response.sendRedirect("/logupfail.jsp");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (conn != null) {
                        conn.close();
                        conn = null;
                    }
                } catch (Exception e) {

                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
