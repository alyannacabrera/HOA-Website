/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 * add, update, delete, and dispose assets
 * @author ccslearner
 */
package asset_management;

import java.sql.*;
import java.util.*;

public class asset {
    public int asset_id;
    public String asset_name;
    public String asset_description;
    public java.sql.Date acquisition_date;
    public boolean forrent;
    public double asset_value;
    public char type_asset;
    public char status;
    public double loc_lattitude;
    public double loc_longiture;
    public String hoa_name;
    public String enclosing_asset;
    
    public ArrayList<String> hoalist = new ArrayList<> ();
    public ArrayList<Integer> assetlist = new ArrayList<> ();
    
    public String sample;
    
    public asset() {
        asset_id = 0;
        asset_name = "";
        asset_description = "";
        acquisition_date = null;
        forrent = false;
        asset_value = 0;
        type_asset = ' ';
        status = ' ';
        loc_lattitude = 0;
        loc_longiture = 0;
        hoa_name = "";
        enclosing_asset = "";
        
        hoalist.clear();
        assetlist.clear();
    }

    public int load_hoa(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT hoa_name FROM hoa");
            ResultSet rs = pstmt.executeQuery();
            hoalist.clear();
            while (rs.next()) {
                String name = rs.getString("hoa_name");
                hoalist.add(name);
            }
            rs.close();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }           
    }
    
    public int load_asset(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id FROM assets");
            ResultSet rs = pstmt.executeQuery();
            assetlist.clear();
            while (rs.next()) {
                Integer assetID = rs.getInt("asset_id");
                assetlist.add(assetID);
            }
            rs.close();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }           
    }
    
    public int add_asset() {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            
            PreparedStatement pstmt_ID = conn.prepareStatement("SELECT MAX(asset_id) + 1 AS newID FROM assets");
            ResultSet rst = pstmt_ID.executeQuery();
            while (rst.next()) {
                asset_id = rst.getInt("newID");
            }
            pstmt_ID.close();
            
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO assets (asset_id, asset_name, asset_description, acquisition_date, forrent, asset_value, type_asset, status, loc_lattitude, loc_longiture, hoa_name, enclosing_asset) VALUES (?, ?, ?, DATE(now()), ?, ?, ?, 'W', ?, ?, ?, ?)");
            pstmt.setInt(1, asset_id);
            pstmt.setString(2, asset_name);
            pstmt.setString(3, asset_description);
            pstmt.setBoolean(4, forrent);
            pstmt.setDouble(5, asset_value);
            pstmt.setString(6, String.valueOf(type_asset));
            pstmt.setDouble(7, loc_lattitude);
            pstmt.setDouble(8, loc_longiture);
            pstmt.setString(9, hoa_name);
            if ("N/A".equals(enclosing_asset)){
                pstmt.setNull(10, java.sql.Types.INTEGER);
            }else{
                pstmt.setString(10, enclosing_asset);
            }
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int load_for_update(int assetID){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_name, asset_description, "
                    + "forrent, asset_value, "
                    + "type_asset, status, loc_lattitude, loc_longiture, hoa_name, enclosing_asset "
                    + "FROM assets WHERE asset_id=?");


            pstmt.setInt(1, assetID);

            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                asset_name = rst.getString("asset_name");
                asset_description = rst.getString("asset_description");
                forrent = rst.getBoolean("forrent");
                asset_value = rst.getDouble("asset_value");
                type_asset = rst.getString("type_asset").charAt(0);
                status = rst.getString("status").charAt(0);
                loc_lattitude = rst.getDouble("loc_lattitude");
                loc_longiture = rst.getDouble("loc_longiture");
                hoa_name = rst.getString("hoa_name");
                enclosing_asset = rst.getString("enclosing_asset");
                if (rst.wasNull()){
                    enclosing_asset="0";
                }
            }

            rst.close();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int update_asset(int assetID) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("UPDATE assets SET asset_name=?, "
                    + "asset_description=?, forrent=?, asset_value=?, "
                    + "type_asset=?, status=?, loc_lattitude=?, loc_longiture=?, hoa_name=?, enclosing_asset=? "
                    + "WHERE asset_id=?");

            pstmt.setInt(11, assetID);
            pstmt.setString(1, asset_name);
            pstmt.setString(2, asset_description);
            pstmt.setBoolean(3, forrent);
            pstmt.setDouble(4, asset_value);
            pstmt.setString(5, String.valueOf(type_asset));
            pstmt.setString(6, String.valueOf(status));
            pstmt.setDouble(7, loc_lattitude);
            pstmt.setDouble(8, loc_longiture);
            pstmt.setString(9, hoa_name);
            if ("N/A".equals(enclosing_asset)){
                pstmt.setNull(10, java.sql.Types.INTEGER);
            }else{
                pstmt.setString(10, enclosing_asset);
            }

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    
    public int asset_fordisposal(){
        try {
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id FROM assets WHERE status='S' ");
           ResultSet rst = pstmt.executeQuery();
           assetlist.clear();
           while (rst.next()) {
                Integer assetID = rst.getInt("asset_id");
                assetlist.add(assetID);
           }
           rst.close();
           pstmt.close();
           conn.close();
            
           System.out.println("Successful");
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       }
    }
    
    public int dispose_asset(int assetID){
        try {
           Connection conn;
           conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           
           // Update the status of the asset
           PreparedStatement pstmt = conn.prepareStatement("UPDATE assets SET status= 'X' WHERE asset_id=?  AND status = 'S'");
           pstmt.setInt(1, assetID);

           pstmt.executeUpdate();
           pstmt.close();
           conn.close();
           
           return 1;
           
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int asset_fordeletion(){
        try {
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           PreparedStatement pstmt = conn.prepareStatement("SELECT a.asset_id " +
                                                           "FROM assets a " +
                                                           "WHERE a.asset_id  NOT IN (" +
                                                                "SELECT     atr.asset_id " +
                                                                "FROM       asset_transactions atr " +
                                                            ") " +
                                                           "AND a.asset_id  NOT IN (" +
                                                                "SELECT     a1.enclosing_asset " +
                                                                "FROM       assets a1 " +
                                                                "WHERE      a1.enclosing_asset is not NULL" +
                                                            ") " +
                                                           "AND a.asset_id NOT IN (" +
                                                                "SELECT     da.asset_id " +
                                                                "FROM       donated_assets da " +
                                                            ") " +
                                                           "AND a.status = 'W'"
                                                            );
           ResultSet rst = pstmt.executeQuery();
           assetlist.clear();
           while (rst.next()) {
                Integer assetID = rst.getInt("asset_id");
                assetlist.add(assetID);
           }
           rst.close();
           pstmt.close();
           conn.close();
            
           System.out.println("Successful");
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       }
    }

    public int delete_asset(int assetID){
        try {
           Connection conn;
           conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           
           // Update the status of the asset
           PreparedStatement pstmt = conn.prepareStatement("DELETE FROM assets WHERE asset_id = ?");
           pstmt.setInt(1, assetID);

           pstmt.executeUpdate();
           pstmt.close();
           conn.close();
           
           return 1;
           
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String[] args) {
        /*asset asset = new asset();
        // asset.asset_id = 5011;
        asset.asset_name = "TV";
        asset.asset_description = "Smart TV";
        // asset.acquisition_date = Date.valueOf("2023-04-14");
        asset.forrent = true;
        asset.asset_value = 75000.00;
        asset.type_asset = 'E';
        // asset.status = 'W';
        asset.loc_lattitude = 101.3330;
        asset.loc_longiture = 101.3330;
        asset.hoa_name = "SJH";
        asset.enclosing_asset = "N/A";
        
        asset.add_asset();*/
    }
}