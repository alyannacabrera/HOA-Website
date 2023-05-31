<%-- 
    Document   : mod_rental
    Created on : 04 16, 23, 4:13:33 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Rental Information</title>
    </head>
    <body>
        <h1>Make Changes to Selected Rental</h1>
        <jsp:useBean id="rentBean" class="asset_management.asset_rentals" scope="session" />
        
           <%rentBean.load_resident_ID();
           rentBean.load_officer();%>
        <% String assetID_rentalDATE = request.getParameter("asset_id_rental_date");%>
        
        <%  String[] parts = assetID_rentalDATE.split(" ");
            int assetID = Integer.parseInt(parts[0]);
            String rentalDate = parts[1];%>
                
<form name="mod_rental" action="edit_rental.jsp" method="POST">
        <% rentBean.asset_id = assetID;%>
        <% rentBean.rental_date = rentalDate;%>
        <% rentBean.load_for_update_rental(rentBean.asset_id, rentBean.rental_date);%>
        
        <tr>Asset ID: <%= rentBean.asset_id %></tr><br>
        <tr>Rental Date: <%= rentBean.rental_date %></tr><br>
        Reservation Date: <input type="date" name="reservation_date" id="reservation_date" value="<%=rentBean.reservation_date%>"><br>
        Resident ID: <select name="resident_id" id="resident_id">
            <option value=<%=rentBean.resident_id%> selected><%=rentBean.resident_id%></option>
            <%      if (rentBean.resident_id==0) { %>
                          <option value="0" selected>-- Select resident ID (Optional) --</option>

                    <%      } %>
                    <% for (int i=0; i<rentBean.residentlist.size(); i++) { %>
                    <%      int resID = rentBean.residentlist.get(i); %>
                    <%      if (resID!=rentBean.resident_id) { %>
                                <option value="<%=resID%>"><%=resID%></option>
                    <%      } %>
                    <% } %>
                    </select><br>
        Rental Amount: <input type="text" name="rental_amount" id="rental_amount" value="<%=rentBean.rental_amount%>"><br>
        Discount: <input type="text" name="discount" id="discount" value="<%=rentBean.discount%>"><br>
        
        Status: <select name="status" id="status">
                    <option value=<%=rentBean.status%> selected><%=rentBean.status%></option>
                        
                    <% if (rentBean.status.equals("R")){%>
                        <option value="C">C</option>
                        <option value="N">N</option>
                        <option value="O">O</option>
                    <% } %>
                    
                    <% if (rentBean.status.equals("C")){%>
                        <option value="O">O</option>
                        <option value="N">N</option>
                        <option value="R">R</option>
                    <% } %>
                    
                    <% if (rentBean.status.equals("O")){%>
                        <option value="C">C</option>
                        <option value="N">N</option>
                        <option value="R">R</option>
                    <% } %>
                    
                    <% if (rentBean.status.equals("N")){%>
                        <option value="C">C</option>
                        <option value="O">O</option>
                        <option value="R">R</option>
                    <% } %>
                    <% if (rentBean.status.equals("")){%>
                        <option value="" selected>-- Select a status --</option>
                        <option value="C">C</option>
                        <option value="O">O</option>
                        <option value="R">R</option>
                        <option value="N">N</option>
                    <% } %>

                </select><br>
                
                
        Inspection Details: <input type="text" name="inspection_details" id="inspection_details" value="<%=rentBean.inspection_details%>"><br>
        Assessed Value: <input type="text" name="assessed_value" id="assessed_value" value="<%=rentBean.assessed_value%>"><br>
        Accepting Officer: <select name="accepting_officer_all" id="accepting_officer_all">
        <option value="" selected>-- Select an officer --</option>
        <% for (int i = 0; i < rentBean.officerIDlist.size(); i++) {
               int ID = rentBean.officerIDlist.get(i);
               String POS = rentBean.officerpositionlist.get(i);
               String ELEC = rentBean.officerelectiondatelist.get(i);
               String optionValue = ID + " " + POS + " " + ELEC;
               String optionLabel = ID + " | " + POS + " | " + ELEC;
               if (ID == rentBean.accept_hoid) { %>
                  <option value="<%= optionValue %>" selected><%= optionLabel %></option>
               <% } else { %>
                  <option value="<%= optionValue %>"><%= optionLabel %></option>
               <% }
           } %>
    </select><br>

        
        Return Date: <input type="date" name="return_date" id="return_date" value="<%=rentBean.return_date%>"><br>
        <input type="submit" value="Update Asset" name ="Update Asset">
        </form> 

           
    
    </body>
</html>
