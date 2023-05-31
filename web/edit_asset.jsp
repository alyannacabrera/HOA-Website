<%-- 
    Document   : edit_asset
    Created on : 04 15, 23, 9:33:30 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Asset</title>
    </head>
    <body>
        <h1>Updating Asset into the Asset Table</h1>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <% String assetNAME  = request.getParameter("asset_name");                     %>
        <% String assetDES   = request.getParameter("asset_description");                          %>
        <% 
            String forRENT;
            if (request.getParameter("forrent") == null) {
               forRENT = "false";
            } else {
               forRENT = "true";        
            }
            boolean forrent = Boolean.parseBoolean(forRENT);     
        %>
        <%  String assetVALUE = request.getParameter("asset_value"); %>
        <%  String typeASSET = request.getParameter("type_asset"); %>
        <%  String STATUS = request.getParameter("status"); %>
        <%  String locLAT = request.getParameter("loc_lattitude"); %>
        <%  String locLONG = request.getParameter("loc_longiture"); %>
        <%  String hoaNAME = request.getParameter("hoa_name"); %>
        <%  String enclosingAsset = request.getParameter("enclosing_asset");%>
        
      
        <% salesBean.asset_name = assetNAME; %>
        <% salesBean.asset_description = assetDES; %>
        <% salesBean.forrent = forrent; %>
        <% salesBean.asset_value = Double.parseDouble(assetVALUE); %>
        <% salesBean.type_asset = typeASSET.charAt(0); %>
        <% salesBean.status = STATUS.charAt(0);%>
        <% salesBean.loc_lattitude = Double.parseDouble(locLAT); %>
        <% salesBean.loc_longiture = Double.parseDouble(locLONG); %>
        <% salesBean.hoa_name = hoaNAME; %>
        <% salesBean.enclosing_asset = enclosingAsset; %>
        
     
        <% if (salesBean.update_asset(salesBean.asset_id) == 1){ %>
            <h3>Asset Successfully Updated</h3>
        <% } %>
        
        <% if (salesBean.update_asset(salesBean.asset_id) != 1){ %>
            <h3>Asset Update Failed</h3>
        <% } %>
        <a href="index.html">Back to Main Menu</a>
    </body>
</html>
