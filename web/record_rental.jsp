<%-- 
    Document   : record_rental
    Created on : 04 17, 23, 3:14:57 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Record Rental</title>
    </head>
    <body>
        <jsp:useBean id="lastBean" class="asset_management.asset_rentals" scope="session" />
        <% lastBean.load_assets_notRENTED();
           lastBean.load_resident_ID();
           lastBean.load_officer();%>
        <h1>Record Rental</h1>
        <form name="record_rental" action="add_rental.jsp" method="POST">
        Asset ID: <select name="asset_id" id="asset_id">
                    <% for (int i=0; i<lastBean.assetsNOTrented.size(); i++) {    %>
                    <%    int ID = lastBean.assetsNOTrented.get(i);                    %>
                    <option value="<%=ID%>"><%=ID%></option>
                    <% }                                                       %>
                </select><br>
        Rental Date: <input type="date" name="rental_date" id="rental_date"><br>
        Reservation Date: <input type="date" name="reservation_date" id="reservation_date"><br>
        Resident ID: <select name="resident_id" id="resident_id">
            <% for (int i=0; i<lastBean.residentlist.size(); i++) { %>
                    <%    int rID = lastBean.residentlist.get(i);                    %>
                    <option value="<%=rID%>"><%=rID%></option>
                    <% } %>
                    </select><br>
        Rental Amount: <input type="text" name="rental_amount" id="rental_amount"><br>
        OR Number: <input type="text" name="ornum" id="ornum"><br>
        Discount: <input type="text" name="discount" id="discount"><br>
        Transacting Officer: <select name="transacting_officer_all" id="transacting_officer_all">
            <% for (int i = 0; i < lastBean.officerIDlist.size(); i++) {
                   int ID1 = lastBean.officerIDlist.get(i);
                   String POS1 = lastBean.officerpositionlist.get(i);
                   String ELEC1 = lastBean.officerelectiondatelist.get(i);%>

                   <option value="<%=ID1 + " " + POS1 + " " + ELEC1%>"><%=ID1 + " | " + POS1 + " | " + ELEC1%></option>
               <% } %>
        </select><br>
        <input type="submit" value="Add Rental" name ="Add Rental">
        </form>
        
    </body>
</html>
