/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authorization.BaseRoleBACController;
import dal.AssessmentDBContext;
import dal.GradeDBContext;
import dal.GroupDBContext;
import dal.ResultDBContext;
import entity.Account;
import entity.Assessment;
import entity.Feature;
import entity.Grade;
import entity.Group;
import helper.calculating.Type;
import helper.calculating.CalculatingHelper;
import entity.Result;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashMap;

/**
 *
 * @author Admin
 */
public class GradeViewController extends BaseRoleBACController {

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
        String raw_courseID = request.getParameter("courseID");

        if (raw_courseID != null) {
            int courseID = Integer.parseInt(raw_courseID);
            
            GradeDBContext gradeDB = new GradeDBContext();
            ArrayList<Grade> gradeList = gradeDB.getGradeByCourse(account.getStudent().getId(), courseID);

            //Types are the grade catyegories of the course, 
            //within each type there are many small assessments
            AssessmentDBContext assessDB = new AssessmentDBContext();
            ArrayList<Type> typeList = assessDB.getTypesOfCourse(courseID);

            //Using of LinkedHashMap maintains the insertion order of its elements.
            LinkedHashMap<Type, ArrayList<Grade>> categories = new LinkedHashMap<>();

            for (Type type : typeList) {
                //Determine the average grade of the type
                Float valueTotal = CalculatingHelper.caculateTotalOfType(type, gradeList);
                type.setValue(valueTotal);
                
                //Determine which grades belong to the type
                ArrayList<Grade> itemList = new ArrayList<>();
                for (Grade grade : gradeList) {
                    if (type.getName().equalsIgnoreCase(grade.getAssessment().getType())) {
                        itemList.add(grade);
                    }
                }
                
                categories.put(type, itemList);
            }
            
            ResultDBContext resultDB = new ResultDBContext();
            Result result = resultDB.getResultByStudentCourse(account.getStudent().getId(), courseID);
            
            request.setAttribute("categories", categories);
            request.setAttribute("gradeList", gradeList);
            request.setAttribute("result", result);
        }

        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groupList = groupDB.getGroupsByStudent(account.getStudent().getId());
        
        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("../view/student/grade_view.jsp").forward(request, response);
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
