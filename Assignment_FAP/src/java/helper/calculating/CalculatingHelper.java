/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package helper.calculating;

import dal.AssessmentDBContext;
import dal.GradeDBContext;
import entity.Assessment;
import entity.Course;
import entity.Result;
import entity.Grade;
import entity.Group;
import entity.Student;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CalculatingHelper {

    //Determines the results of all courses of a student
    public static ArrayList<Result> calculateResultCoursesOfStudent(String studentID, ArrayList<Group> groupList){
        ArrayList<Result> resultList = new ArrayList<>();
        //Loop each student's course
        for (Group group : groupList) {
            int courseID = group.getCourse().getId();
            
            AssessmentDBContext assessDB = new AssessmentDBContext();
            //Types are the grade catyegories of the course, 
            //within each type there are many small assessments
            ArrayList<Type> typeList = assessDB.getTypesOfCourse(courseID);
            
            GradeDBContext gradeDB = new GradeDBContext();
            ArrayList<Grade> gradeList = gradeDB.getGradeByCourse(studentID, courseID);
            
            for (Type type : typeList) {
                //Determine the average grade of the type
                Float valueTotal = caculateTotalOfType(type, gradeList);
                type.setValue(valueTotal);
            }
            
            //From list of types of a course then calculate the average grade, 
            //and status, comment of that course. Then return a result obj
            Result result = calcuateAverage(typeList);
        
            Student student = new Student();
            student.setId(studentID);
            result.setStudent(student);
        
            Course course = new Course();
            course.setId(courseID);
            result.setCourse(course);
            
            resultList.add(result);
        }
        return resultList;
    } 
    
    //Calculate the total value of each type component of the course
    public static Float caculateTotalOfType(Type type, ArrayList<Grade> gradeList) {
        float sum = 0;
        for (Grade grade : gradeList) {
            //Determine which grades belong to the type being considered
            if (type.getName().equalsIgnoreCase(grade.getAssessment().getType())) {
                if (grade.getValue() != null) {
                    sum += grade.getValue() * grade.getAssessment().getWeight();
                } //If there is a grade of a type that does not have a value, 
                //the average of the type's grade will not be counted 
                else {
                    return null;
                }
            }
        }
        return sum / type.getWeight();
    }

    //Determine average grade, status, and comment on the result of the course
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

    //Calculate the average grade of the course in case there is no final exam resit
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

    //Calculate the average grade of the course in case of final exam resit
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

    //Determine status of course through average grade and final grade
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
