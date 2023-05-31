<%-- 
    Document   : edit_rental
    Created on : 04 16, 23, 7:12:56 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Rental Information</title>
    </head>
    <body>
        <h1>Updating Rental Information into the Asset Rentals Table</h1>
        <jsp:useBean id="rentBean" class="asset_management.asset_rentals" scope="session" />
        <%  String resDATE  = request.getParameter("reservation_date");                     %>
        <%  String resID = request.getParameter("resident_id"); %>
        <%  String rentAMT = request.getParameter("rental_amount"); %>
        <%  String discount = request.getParameter("discount"); %>
        <%  String status = request.getParameter("status"); %>
        <%  String insDETS = request.getParameter("inspection_details"); %>
        <%  String assVAL = request.getParameter("assessed_value"); %>
        <%  String accOFF = request.getParameter("accepting_officer_all"); 
            String[] parts = accOFF.split(" ");
            String accID = parts[0];
            String accPOS = parts[1];
            String accELEC = parts[2];
        %>
        <%  String retDATE = request.getParameter("return_date"); %>
        
      
        <% rentBean.reservation_date = resDATE; %>
        <% rentBean.resident_id =  Integer.parseInt(String.valueOf(resID)); %>
        <% rentBean.rental_amount = Float.parseFloat(String.valueOf(rentAMT)); %>
        <% rentBean.discount = Float.parseFloat(String.valueOf(discount)); %>
        <% rentBean.status = status; %>
        <% rentBean.inspection_details = insDETS;%>
        <% rentBean.assessed_value = Float.parseFloat(String.valueOf(assVAL)); %>
        <% rentBean.accept_hoid =  Integer.parseInt(String.valueOf(accID)); %>
        <% rentBean.accept_position = accPOS; %>
        <% rentBean.accept_electiondate = accELEC; %>
        <% rentBean.return_date = retDATE; %>
     
        <% if (rentBean.update_rental(rentBean.asset_id, rentBean.rental_date) == 1){ %>
            <h3>Asset Successfully Updated</h3>
        <% } %>
        
        <% if (rentBean.update_rental(rentBean.asset_id, rentBean.rental_date) != 1){ %>
            <h3>Asset Update Failed</h3>
        <% } %>
        <a href="index.html">Back to Main Menu</a>
    </body>
</html>
