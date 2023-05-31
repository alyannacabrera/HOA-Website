<%-- 
    Document   : update_rental
    Created on : 04 16, 23, 3:29:27 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Rental Information</title>
    </head>
    <body>
        <h1>Update Rental Information</h1>
        <jsp:useBean id="rentBean" class="asset_management.asset_rentals" scope="session" />
        <% rentBean.load_asset_rental();%>
        
        <form name="update_rental" action="mod_rental.jsp" method="POST">
        Asset ID:    <select name="asset_id_rental_date" id="asset_id_rental_date">
                <% 
                    List<Integer> assetList = new ArrayList<>(rentBean.assetlist);
                    List<String> rentalList = new ArrayList<>(rentBean.rentaldate_list);
                    for (int i = 0; i < assetList.size(); i++) {    
                %>
                    <option value="<%= assetList.get(i) + " " + rentalList.get(i) %>">
                        <%= assetList.get(i) + " | " + rentalList.get(i) %>
                    </option>
                <% 
                    }  
                %>
            </select><br>

            
        <input type="submit" value="Update Rental Information" name ="Update Rental Information">
    </body>
    </body>
</html>
