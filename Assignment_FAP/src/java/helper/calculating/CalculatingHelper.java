/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package helper.calculating;

import entity.Result;
import entity.Grade;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CalculatingHelper {

    public static Float caculateTotalOfType(Type type, ArrayList<Grade> gradeList) {
        float sum = 0;
        int count = 0;
        for (Grade grade : gradeList) {
            //Determine which grades belong to the type being considered
            if (type.getName().equalsIgnoreCase(grade.getAssessment().getType())) {
                if (grade.getValue() != null) {
                    sum += grade.getValue() * grade.getAssessment().getWeight();
                    count++;
                } //If there is a grade of a type that does not have a value, 
                //the average of the type's grade will not be counted 
                else {
                    return null;
                }
            }
        }
        return sum / type.getWeight();
    }

    public static Result calcuateAverage(ArrayList<Type> typeList) {
        Result result = new Result();

        //If there is total of type is null except in case of final exam resit 
        //then all marks are not completed. Otherwise, all total of types are completed,
        //divided into two cases: no final retake grade, or there is final retake grade.
        for (Type type : typeList) {
            if (type.getValue() == null && !type.getName().equals("Final Exam Resit")) {
                result.setAverage(0.0f);
                result.setStatus("STUDYING");
                return result;
            }
        }

        for (Type type : typeList) {
            //In case of no final retake then has no garde of final exam resit
            if (type.getName().equals("Final Exam Resit") && type.getValue() == null) {
                result = calculateAverageNoRetake(typeList);
            } //In case of final retake then has a garde of final exam resit
            if (type.getName().equals("Final Exam Resit") && type.getValue() != null) {
                result = calculateAverageRetake(typeList);
            }
        }
        return result;
    }

    public static Result calculateAverageNoRetake(ArrayList<Type> typeList) {
        Result result = new Result();
        Float average = 0f;
        Float gradeFinal = 0f;
        String typeName = "";
        Boolean flag = false;
        for (Type type : typeList) {
            if (!type.getName().equals("Final Exam Resit")) {
                average += type.getValue() * type.getWeight();

                if (type.getName().equals("Final Exam")) {
                    gradeFinal = type.getValue();
                }

                //Check there is a total of type equal 0
                if (type.getValue() == 0) {
                    typeName = type.getName();
                    flag = true;
                }
            }
        }

        //There is no total of type is 0
        if (flag == false) {
            result.setAverage(average);
            ArrayList<String> statusComment = getStatus(average, gradeFinal);
            result.setStatus(statusComment.get(0));
            result.setComment(statusComment.get(1));
            return result;
        } //There is one or more total of type is 0
        else {
            result.setAverage(average);
            result.setStatus("NOT PASS");
            result.setComment("Not Pass because the total of " + typeName + " is 0");
            return result;
        }

    }

    public static Result calculateAverageRetake(ArrayList<Type> typeList) {
        Result result = new Result();
        Float average = 0f;
        Float gradeFinalResit = 0f;
        String typeName = "";
        Boolean flag = false;
        for (Type type : typeList) {
            if (!type.getName().equals("Final Exam")) {
                average += type.getValue() * type.getWeight();

                if (type.getName().equals("Final Exam Resit")) {
                    gradeFinalResit = type.getValue();
                }

                //Check there is a total of type equal 0
                if (type.getValue() == 0) {
                    typeName = type.getName();
                    flag = true;
                }
            }
        }

        //There is no total of type is 0
        if (flag == false) {
            result.setAverage(average);
            ArrayList<String> statusComment = getStatus(average, gradeFinalResit);
            result.setStatus(statusComment.get(0));
            result.setComment(statusComment.get(1));
            return result;
        } //There is one or more total of type is 0
        else {
            result.setAverage(average);
            result.setStatus("NOT PASS");
            result.setComment("Not Pass because the total of " + typeName + " is 0");
            return result;
        }

    }

    public static ArrayList<String> getStatus(Float average, Float finalGrade) {
        ArrayList<String> list = new ArrayList<>();
        if (finalGrade >= 4 && average >= 5) {
            list.add("PASS");
            list.add("");
        } else if (finalGrade < 4 && average >= 5) {
            list.add("NOT PASS");
            list.add("Grade of final is less than 4");
        } else if (finalGrade >= 4 && average < 5) {
            list.add("NOT PASS");
            list.add("Average is less than 5");
        } else {
            list.add("NOT PASS");
            list.add("Grade of final is less than 4 and Average is less than 5");
        }
        return list;
    }
}
