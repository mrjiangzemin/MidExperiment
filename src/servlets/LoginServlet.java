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

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //想法是不能放在dao中进行数据库查询，只能做到从数据库里面取出所有的用户信息然后拿出来进行匹配，这种做法比较危险；
        //故直接在servlet里面连接数据库进行用户信息判断
        //获取用户名和密码
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        //连接数据库，进行用户匹配
        Connection conn=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/bookstore?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Home7End1");
            String sql="select username from user where username= \'"+username+"' and password= \'"+password+"';";
            Statement stat=conn.createStatement();
            ResultSet rs=stat.executeQuery(sql);
            String userStatus="fail";
            if(rs.next()&&(rs.getString("username").equals(username))){
                userStatus="success";
                HttpSession session=request.getSession();
                session.setAttribute("userStatus",userStatus);
                session.setAttribute("username",username);
                response.sendRedirect("/index.jsp");
            }
            else{
                HttpSession session=request.getSession();
                session.setAttribute("userStatus",userStatus);
                ServletContext application=this.getServletContext();
                RequestDispatcher rd=
                        application.getRequestDispatcher("/loginfail.jsp");
                rd.forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }finally {
            try{
                if(conn!=null){
                    conn.close();
                    conn=null;
                }
            }catch (Exception e){

            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
