<%-- 
    Document   : delete_rental
    Created on : 04 16, 23, 7:58:08 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Rental</title>
    </head>
    <body>
        <jsp:useBean id="rentBean" class="asset_management.asset_rentals" scope="session" />
        <form name="delete_rental" action="delete_rental_process.jsp" method="POST">
            <h1>Delete Rental Information</h1><br>
            President's Information: <select name="info_pres" id="info_pres">
            <% 
                rentBean.pres_info();
                List<Integer> idList = new ArrayList<>(rentBean.presID);
                List<String> DateList = new ArrayList<>(rentBean.presEDate);
                Collections.sort(idList);
                Collections.sort(DateList);
                for (int i=0; i<idList.size(); i++) {      
            %>
                <option value="<%=idList.get(i) + " " + DateList.get(i)%>"><%=idList.get(i) + " | " + DateList.get(i)%></option>
            <% 
                }
            %>     
            </select><br>

            Rental Information:<select name="info_rent" id="info_rent">
                <% 
                    rentBean.rent_info();
                    List<Integer> rentidList = new ArrayList<>(rentBean.rentID);
                    List<String> rentDateList = new ArrayList<>(rentBean.rentDate);
                    for (int i=0; i<rentidList.size(); i++) {      
                %>
                    <option value="<%=rentidList.get(i) + " " + rentDateList.get(i)%>"><%=rentidList.get(i) + " | " + rentDateList.get(i)%></option>
                <% 
                    }
                %>
                                                                  
                </select><br>
                <input type="submit" value="Submit Info" name ="Submit Info">
        </form> 
    </body>
</html>
