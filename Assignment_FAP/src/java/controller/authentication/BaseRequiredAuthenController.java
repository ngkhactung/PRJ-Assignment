/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author Admin
 */
public abstract class BaseRequiredAuthenController extends HttpServlet {

    public Account getAuthentication(HttpServletRequest request) {
        Account account = (Account) request.getSession().getAttribute("account");
        //In session scope,there is a account object;
        if (account != null) {
            return account;
        } //If there is no account in session, then check in cookies
        else {
            Cookie[] cookies = request.getCookies();
            String username = null;
            String password = null;
            for (Cookie cooky : cookies) {
                if (cooky.getName().equals("cookieUser")) {
                    username = cooky.getValue();
                }

                if (cooky.getName().equals("cookiePass")) {
                    password = cooky.getValue();
                }

                if (username != null && password != null) {
                    break;
                }
            }

            AccountDBContext accountDB = new AccountDBContext();
            Account acc = accountDB.getAccount(username, password);
            if (acc != null) {
                request.getSession().setAttribute("account", acc);
                return acc;
            } else {
                return null;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = getAuthentication(request);
        if (account != null) {
            doGet(request, response, account);
        } else {
            request.getRequestDispatcher("/view/authentication/login_required.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = getAuthentication(request);
        if (account != null) {
            doPost(request, response, account);
        } else {
            request.getRequestDispatcher("/view/authentication/login_required.jsp").forward(request, response);
        }
    }

    abstract protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException;

    abstract protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException;
}
