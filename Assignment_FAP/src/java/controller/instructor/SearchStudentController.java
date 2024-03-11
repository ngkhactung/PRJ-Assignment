/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import controller.authorization.BaseRoleBACController;
import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.Feature;
import entity.Group;
import entity.Student;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class SearchStudentController extends BaseRoleBACController {

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
        String raw_studentID = request.getParameter("studentID");
        String studentID = (raw_studentID == null) ? "" : raw_studentID;

        String raw_name = request.getParameter("name");
        String name = (raw_name == null) ? "" : raw_name;

        String raw_gender = request.getParameter("gender");
        Boolean gender = (raw_gender == null || raw_gender.isEmpty()) ? null : Boolean.valueOf(raw_gender);

        String raw_from = request.getParameter("from");
        Date from = (raw_from == null || raw_from.isEmpty()) ? null : Date.valueOf(raw_from);

        String raw_to = request.getParameter("to");
        Date to = (raw_to == null || raw_to.isEmpty()) ? null : Date.valueOf(raw_to);

        String raw_groupName = request.getParameter("groupName");
        String groupName = (raw_groupName == null) ? "" : raw_groupName;

        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Student> studentList = stuDB.getStudentsBySearch(studentID, name, gender, from, to, groupName);

        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groupNameList = groupDB.getListGroupnName();

        //Check first time to access this page, every variables is null then not display student list
        //in next time, every variable is not null
        if (raw_studentID != null) {
            request.setAttribute("studentList", studentList);
            if(studentList.isEmpty()){
                request.setAttribute("message", "List is empty");
            }
        }
        request.setAttribute("groupNameList", groupNameList);
        request.getRequestDispatcher("../view/instructor/search_student.jsp").forward(request, response);
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
