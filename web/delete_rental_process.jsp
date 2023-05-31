<%-- 
    Document   : delete_rental_process
    Created on : 04 16, 23, 8:41:28 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting Rental Information</title>
    </head>
    <body>
        <jsp:useBean id="rentBean" class="asset_management.asset_rentals" scope="session" />
        <% String info_pres = request.getParameter("info_pres");%>
        
        <%  String[] presparts = info_pres.split(" "); %>
        <%
            int presAssetID = Integer.parseInt(presparts[0]);
            String presEDate = presparts[1];
        %>
        
        <% String info_rent = request.getParameter("info_rent");%>
        
        <%  String[] rentparts = info_rent.split(" "); %>
        <%
            int rentAssetID = Integer.parseInt(rentparts[0]);
            String rentRentalDate = rentparts[1];
        %>
        
        <% int status = rentBean.delete_rental(presAssetID, presEDate, rentAssetID, rentRentalDate);%>
        <%
            if (status==1) {
        %>
                <h1>Rental Information Deletion Successful</h1><br>
        <%  } else {
        %>    
                <h1>Rental Information Deletion Failed</h1><br>
        <% }
        %>

        
        </select>
        <a href="index.html">Back to Main Menu</a>
    </body>
</html>
