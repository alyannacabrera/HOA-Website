
package asset_management;
import java.sql.*;
import java.util.ArrayList;

public class asset_rentals {
    public  int     asset_id;
    public  String  rental_date;          
    public  String  reservation_date;
    public  int     resident_id;
    public  int     approval_hoid;
    public  String  approval_position;
    public  String  approval_electiondate;
    public  float   rental_amount;
    public  float   discount;        
    public  String  status;
    public  String  inspection_details;
    public  float   assessed_value;
    public  int     accept_hoid;          
    public  String  accept_position;
    public  String  accept_electiondate;
    public  String  return_date;
    
    public  String  transaction_date;
    public  int     trans_hoid;          
    public  String  trans_position;
    public  String  trans_electiondate;
    public  Boolean isdeleted;
    
    public  int     president_hoid;          
    public  String  president_position;
    public  String  president_electiondate;
    
    public ArrayList<Integer> presID = new ArrayList<> ();
    public ArrayList<String> presEDate = new ArrayList<> ();
    
    public ArrayList<Integer> rentID = new ArrayList<> ();
    public ArrayList<String> rentDate = new ArrayList<> ();
    
    public  ArrayList<Integer> assetlist = new ArrayList<> ();
    public  ArrayList<String> rentaldate_list = new ArrayList<> ();
    public  ArrayList<Integer> residentlist = new ArrayList<> ();
    public  ArrayList<Integer> officerIDlist = new ArrayList<> ();
    public  ArrayList<String> officerpositionlist= new ArrayList<> ();
    public  ArrayList<String> officerelectiondatelist= new ArrayList<> ();
    public  ArrayList<Integer> assetsNOTrented = new ArrayList<>();
    public  int     ornum; 
    
    public int delete_rental(int presAssetID, String presEDate, int rentAssetID, String rentRentalDate){
        try {
            Connection conn;     
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE asset_transactions SET isdeleted=?, approval_hoid=?, approval_position=?, approval_electiondate=? WHERE asset_id=? AND transaction_date=?");
            
            pstmt.setBoolean (1, true);
            pstmt.setInt    (2, presAssetID);
            pstmt.setString  (3, "President");
            pstmt.setString  (4, presEDate);
            pstmt.setInt    (5, rentAssetID);
            pstmt.setString (6, rentRentalDate);

            pstmt.executeUpdate();   
            pstmt.close();
            conn.close();
            return 1;
        }   catch (SQLException e) {
            System.out.println(e.getMessage());  
            return 0;
        }         
    } 
    
    public int rent_info(){
        try {
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           PreparedStatement pstmt = conn.prepareStatement("SELECT ar.asset_id, ar.rental_date " +
                                                            "FROM asset_rentals ar JOIN asset_transactions at ON (at.asset_id = ar.asset_id and at.transaction_date = ar.rental_date) " +
                                                            "WHERE at.isdeleted = 0");

           ResultSet rst = pstmt.executeQuery();
           rentID.clear();
           rentDate.clear();
           while (rst.next()) {
                int ID = rst.getInt("asset_id");
                String EDate = rst.getString("rental_date");
                rentID.add(ID);
                rentDate.add(EDate);
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
    
    public int pres_info(){
        try {
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
           System.out.println("Connection Successful");
           PreparedStatement pstmt = conn.prepareStatement("SELECT ho_id, election_date FROM officer_presidents");
           ResultSet rst = pstmt.executeQuery();
           presID.clear();
           presEDate.clear();
           while (rst.next()) {
                int ID = rst.getInt("ho_id");
                String EDate = rst.getString("election_date");
                presID.add(ID);
                presEDate.add(EDate);
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
    
    
    public int EnclosedAssets(int asset_id, String rental_date){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id " +
                                                            "FROM assets " +
                                                            "WHERE asset_id IN (" +
                                                                "SELECT a1.asset_id " +
                                                                "FROM assets a1" +
                                                                "WHERE a1.enclosing_asset = ?" +
                                                            ") " +
                                                            "AND asset_id NOT IN (" +
                                                                "SELECT a2.asset_id " +
                                                                "FROM assets a2 " +
                                                                "JOIN asset_transactions atr ON atr.asset_id = a2.asset_id " +
                                                                "JOIN asset_rentals ar ON ar.asset_id = atr.asset_id AND ar.rental_date = atr.transaction_date " +
                                                                "WHERE ar.accept_hoid IS NULL AND ar.rental_date = ?" +
                                                            ")"
                                                             );
            pstmt.setInt(1, asset_id);
            pstmt.setString(2, rental_date);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                assetlist.add(rs.getInt("asset_id"));
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
    
    public int add_assettrans(){
        try{
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO asset_transactions(asset_id, "+
            "transaction_date, trans_hoid, trans_position, trans_electiondate, "
            + "isdeleted, approval_hoid, approval_position, "
            + "approval_electiondate, ornum, transaction_type) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"); 
            
            pstmt.setInt(1, asset_id);
            pstmt.setString(2, rental_date); 
            pstmt.setInt(3, trans_hoid);
            pstmt.setString(4, trans_position);
            pstmt.setString(5, trans_electiondate);
            pstmt.setBoolean(6, false);
            pstmt.setNull(7, Types.NULL);
            pstmt.setNull(8, Types.NULL);
            pstmt.setNull(9, Types.NULL);
            pstmt.setInt(10, ornum);
            pstmt.setString(11, "R");
            pstmt.executeUpdate();
            pstmt.close();
            
            PreparedStatement pstmts = conn.prepareStatement("INSERT INTO asset_rentals "
                    + "(asset_id, rental_date, reservation_date, resident_id, rental_amount, "
                    + "discount, status, inspection_details, assessed_value, "
                    + "accept_hoid, accept_position, accept_electiondate, return_date) "
                    + "VALUES (?,?,?,?,?,?, ?, ?, ?, ?, ?, ?, ?)");

                    pstmts.setInt(1, asset_id);
                    pstmts.setString(2, rental_date);
                    pstmts.setString(3, reservation_date);
                    pstmts.setInt(4, resident_id);
                    pstmts.setFloat(5, rental_amount);
                    pstmts.setFloat(6, discount);
                    pstmts.setString(7, "R");
                    pstmts.setNull(8, Types.NULL);
                    pstmts.setNull(9, Types.NULL);
                    pstmts.setNull(10, Types.NULL);
                    pstmts.setNull(11, Types.NULL);
                    pstmts.setNull(12, Types.NULL);
                    pstmts.setNull(13, Types.NULL);
                    pstmts.executeUpdate();

                    pstmts.close();
                    conn.close();
                    return 1;
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return 0;
        }          
    }
    
    public int set_asset_rental(int asset_id){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("UPDATE assets SET forrent='0' WHERE asset_id = ?");
            
            pstmt.setInt(1, asset_id);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }        
    }
    
    public int load_asset_rental(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id, rental_date FROM asset_rentals");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                assetlist.add(rs.getInt("asset_id"));
                rentaldate_list.add(rs.getString("rental_date"));
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
    
    public int load_assets_notRENTED(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id FROM assets WHERE forrent='1'");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                assetsNOTrented.add(rs.getInt("asset_id"));
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
    
    public int load_resident_ID(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT resident_id FROM residents");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                residentlist.add(rs.getInt("resident_id"));
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
    
    public int load_officer(){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT ho_id, position, election_date FROM officer");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                officerIDlist.add(rs.getInt("ho_id"));
                officerpositionlist.add(rs.getString("position"));
                officerelectiondatelist.add(rs.getString("election_date"));
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
    
    public int load_for_update_rental(int assetID, String rentalDATE){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678&useSSL=false"); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT reservation_date, resident_id, "
                    + "rental_amount, discount, "
                    + "status, inspection_details, assessed_value, accept_hoid, accept_position, "
                    + "accept_electiondate, return_date "
                    + "FROM asset_rentals WHERE asset_id=? AND rental_date=?");


            pstmt.setInt(1, assetID);
            pstmt.setString(2, rentalDATE);

            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                reservation_date = rst.getString("reservation_date");
                resident_id = rst.getInt("resident_id");
                rental_amount = rst.getFloat("rental_amount");
                discount = rst.getFloat("discount");
                status = rst.getString("status");
                inspection_details = rst.getString("inspection_details");
                assessed_value = rst.getFloat("assessed_value");
                accept_hoid = rst.getInt("accept_hoid");
                accept_position = rst.getString("accept_position");
                accept_electiondate = rst.getString("accept_electiondate");
                return_date = rst.getString("return_date");
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
    
    public int update_rental(int assetID, String rentDATE){ 
        try {
            Connection conn;     
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HOADB?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE asset_rentals   SET    "
                    + "reservation_date=?, resident_id=?,"
                    + "rental_amount=?, discount=?, status=?,"
                    + "inspection_details = ?, assessed_value = ?, accept_hoid = ?, "
                    + "accept_position = ?, accept_electiondate = ?, return_date = ?   "
                    + "WHERE asset_id = ? AND rental_date=?");
            
            pstmt.setString (1, reservation_date);
            pstmt.setInt    (2, resident_id);
            pstmt.setFloat  (3, rental_amount);
            pstmt.setFloat  (4, discount);
            pstmt.setString (5, status);
            pstmt.setString (6, inspection_details);
            pstmt.setFloat  (7, assessed_value);
            pstmt.setInt    (8, accept_hoid);
            pstmt.setString (9, accept_position);
            pstmt.setString (10, accept_electiondate);
            pstmt.setString (11, return_date);
            pstmt.setInt    (12, assetID);
            pstmt.setString (13, rentDATE);

            pstmt.executeUpdate();   
            pstmt.close();
            conn.close();
            return 1;
        }   catch (SQLException e) {
            System.out.println(e.getMessage());  
            return 0;
        }         
    }
    
    public static void main (String[] args) {

    }  
}
