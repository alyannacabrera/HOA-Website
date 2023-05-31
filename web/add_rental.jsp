

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding Rental</title>
    </head>
    <body>
        <h1>Recording Rental</h1>
        <jsp:useBean id="recordBean" class="asset_management.asset_rentals" scope="session" />
        <% 
    String assetID  = request.getParameter("asset_id");                     
    String rent_DATE   = request.getParameter("rental_date");     
    String res_DATE   = request.getParameter("reservation_date");
    String res_ID   = request.getParameter("resident_id");                          
    String rentAMT = request.getParameter("rental_amount"); 
    String ornum = request.getParameter("ornum"); 
    String disc = request.getParameter("discount"); 
    String transactingOFF = request.getParameter("transacting_officer_all"); 
    String[] parts = transactingOFF.split(" ");
    String accID2 = parts[0];
    String accPOS2 = parts[1];
    String accELEC2 = parts[2];
%>
        
<% 
    recordBean.asset_id = Integer.parseInt(assetID); 
    recordBean.rental_date = rent_DATE; 
    recordBean.resident_id = Integer.parseInt(res_ID); 
    recordBean.rental_amount = Float.parseFloat(rentAMT);
    recordBean.ornum = Integer.parseInt(ornum);
    recordBean.discount = Float.parseFloat(disc); 
    recordBean.trans_hoid = Integer.parseInt(accID2); 
    recordBean.trans_position = accPOS2; 
    recordBean.trans_electiondate = accELEC2;
    recordBean.reservation_date = res_DATE;
%>
    
    <%  int status = recordBean.add_assettrans();
        if (status==1) {
    %>      <%recordBean.set_asset_rental(recordBean.asset_id);%>
            <% for (int i=0; i<recordBean.assetlist.size(); i++) { 
                recordBean.asset_id = recordBean.assetlist.get(i);
                recordBean.add_assettrans();
            }%>
            <h1>Rental Successfully Recorded </h1><br>
    <%  } else {
    %>    
            <h1>Rental Unsuccessfully Recorded</h1><br>
    <% }
    %>

        <a href="index.html">Back to Main Menu</a>

    </body>
</html>
