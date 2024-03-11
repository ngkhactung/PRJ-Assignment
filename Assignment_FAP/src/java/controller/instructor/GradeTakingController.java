/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import controller.authorization.BaseRoleBACController;
import dal.AssessmentDBContext;
import dal.GradeDBContext;
import dal.GroupDBContext;
import entity.Account;
import entity.Assessment;
import entity.Feature;
import entity.Grade;
import entity.Group;
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
public class GradeTakingController extends BaseRoleBACController {

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
        String raw_groupID = request.getParameter("groupID");

        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groupList = groupDB.getGroupsByInstructor(account.getInstructor().getId());

        if (raw_groupID != null) {
            int groupID = Integer.parseInt(raw_groupID);
            Group group = groupDB.getGroupByGroup(groupID);

            AssessmentDBContext assessDB = new AssessmentDBContext();
            ArrayList<Assessment> assessList = assessDB.getAssessmentByGroup(groupID);

            GradeDBContext gradeDB = new GradeDBContext();
            ArrayList<Grade> gradeList = gradeDB.getGradeByGroup(groupID);

            request.setAttribute("group", group);
            request.setAttribute("assessList", assessList);
            request.setAttribute("gradeList", gradeList);
        }

        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("../view/instructor/grade_taking.jsp").forward(request, response);
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
        int groupID = Integer.parseInt(request.getParameter("groupID"));

        GradeDBContext gradeDB = new GradeDBContext();
        ArrayList<Grade> gradeList = gradeDB.getGradeNoValueByGroup(groupID);

        for (Grade grade : gradeList) {
            String raw_grade = request.getParameter("grade" + grade.getStudent().getId()
                    + "_" + grade.getAssessment().getId());
            if (!raw_grade.isEmpty()) {
                grade.setValue(Float.valueOf(raw_grade));
            }
        }

        gradeDB.setGradeIntoTable(groupID, gradeList);

        response.sendRedirect("grade_taking?groupID=" + groupID +"&save=true");
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
