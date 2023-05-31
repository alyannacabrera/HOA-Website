<%-- 
    Document   : delete_process
    Created on : 04 16, 23, 12:03:41 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting Asset</title>
    </head>
    <body>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <% String assetID  = request.getParameter("asset_id");%>
        <% salesBean.asset_id = Integer.parseInt(assetID); %>
        <% int status = salesBean.delete_asset(salesBean.asset_id);%>
        <%
            if (status==1) {
        %>
                <h1>Asset Deletion Successful</h1><br>
        <%  } else {
        %>    
                <h1>Asset Deletion Failed</h1><br>
        <% }
        %>
        <a href="index.html">Back to Main Menu</a>
        
    </body>
</html>
