/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authorization;

import controller.authentication.BaseRequiredAuthenController;
import dal.FeatureDBContext;
import entity.Account;
import entity.Feature;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public abstract class BaseRoleBACController extends BaseRequiredAuthenController {

    public Boolean getAuthorization(HttpServletRequest request, ArrayList<Feature> featureList) {
        String currentUrl = request.getServletPath();
        for (Feature feature : featureList) {
            if (feature.getUrl().equals(currentUrl)) {
                return true;
            }
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        FeatureDBContext featureDB = new FeatureDBContext();
        ArrayList<Feature> featureList = featureDB.getFeaturesOfAccount(account.getUsername());
        Boolean isAuthorization = getAuthorization(request, featureList);
        if (isAuthorization) {
            doGet(request, response, account, featureList);
        } else {
            //Check if the account belongs to the student or not 
            if (account.getStudent() != null) {
                request.setAttribute("homePage", "/assign.fap.fpt/student/timetable");
            } else {
                request.setAttribute("homePage", "/assign.fap.fpt/instructor/timetable");
            }
            request.getRequestDispatcher("/view/authorization/access_denied.jsp").forward(request, response);
        }
    }

    abstract protected void doGet(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList) throws ServletException, IOException;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        FeatureDBContext featureDB = new FeatureDBContext();
        ArrayList<Feature> featureList = featureDB.getFeaturesOfAccount(account.getUsername());
        Boolean isAuthorization = getAuthorization(request, featureList);
        if (isAuthorization) {
            doPost(request, response, account, featureList);
        } else {
            //Check if the account belongs to the student or not 
            if (account.getStudent() != null) {
                request.setAttribute("homePage", "/assign.fap.fpt/student/timetable");
            } else {
                request.setAttribute("homePage", "/assign.fap.fpt/instructor/timetable");
            }
            request.getRequestDispatcher("/view/authorization/access_denied.jsp").forward(request, response);
        }
    }

    abstract protected void doPost(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList) throws ServletException, IOException;
}
