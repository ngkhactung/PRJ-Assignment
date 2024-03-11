/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Feature;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class FeatureDBContext extends DBContext {

    //Get all the features of an account that are allowed to access 
    public ArrayList<Feature> getFeaturesOfAccount(String username) {
        ArrayList<Feature> featureList = new ArrayList<>();
        try {
            String sql = "select a.Username , r.Name as RoleName, f.ID as FeatureID, f.Url as FeatureUrl\n"
                    + "from Account a inner join AccountRole ar on a.Username = ar.Username\n"
                    + "			inner join [Role] r on r.ID = ar.RoleID\n"
                    + "			inner join RoleFeature rf on r.ID = rf.RoleID\n"
                    + "			inner join Feature f on f.ID = rf.FeatureID\n"
                    + "where a.Username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feature feature = new Feature();

                feature.setId(rs.getInt("FeatureID"));
                feature.setUrl(rs.getString("FeatureUrl"));

                featureList.add(feature);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return featureList;
    }
}
