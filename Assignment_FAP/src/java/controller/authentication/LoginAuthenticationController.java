/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginAuthenticationController extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/authentication/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AccountDBContext accountDB = new AccountDBContext();
        Account account = accountDB.getAccount(username, password);
        if (account != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("account", account);
            
            String remember = request.getParameter("remember");
            Cookie cookieUser = new Cookie("cookieUser", username);
            Cookie cookiePass = new Cookie("cookiePass", password);
            Cookie cookieRem = new Cookie("cookieRem", "remember");
            if (remember != null) {
                cookieUser.setMaxAge(60 * 60 * 24 * 3);
                cookiePass.setMaxAge(60 * 60 * 24 * 3);
                cookieRem.setMaxAge(60 * 60 * 24 * 3);
                response.addCookie(cookieUser);
                response.addCookie(cookiePass);
                response.addCookie(cookieRem);
            } else {
                cookieUser.setMaxAge(0);
                cookiePass.setMaxAge(0);
                cookieRem.setMaxAge(0);
                response.addCookie(cookieUser);
                response.addCookie(cookiePass);
                response.addCookie(cookieRem);
            }

            //Check if the account belongs to the student or not 
            if (account.getStudent() != null) {
                response.sendRedirect("student/timetable");
            } else {
                response.sendRedirect("instructor/timetable");
            }
        } else {
            request.setAttribute("message", "Login Failed: Wrong username or password");
            request.getRequestDispatcher("view/authentication/login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
