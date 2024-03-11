/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authorization.BaseRoleBACController;
import dal.ResultDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.Feature;
import entity.Result;
import entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class StudentProfileController extends BaseRoleBACController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String studentID = request.getParameter("studentID");

        //If the student ID is not null, it is because the instructor accessed the url
        if (studentID != null) {
            StudentDBContext studentDB = new StudentDBContext();
            Student student = studentDB.getStudent(studentID);

            ResultDBContext resultDB = new ResultDBContext();
            ArrayList<Result> resultList = resultDB.getAllResultsOfStudent(studentID);

            request.setAttribute("student", student);
            request.setAttribute("resultList", resultList);
            request.getRequestDispatcher("../view/student/profile.jsp").forward(request, response);
        } //If the student ID is null, it is because the student accessed the url
        else {
            StudentDBContext studentDB = new StudentDBContext();
            Student student = studentDB.getStudent(account.getStudent().getId());
            
            request.setAttribute("student", student);
            request.getRequestDispatcher("../view/student/profile.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList)
            throws ServletException, IOException {
        processRequest(request, response, account);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList)
            throws ServletException, IOException {
        processRequest(request, response, account);
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
