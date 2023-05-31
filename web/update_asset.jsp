<%-- 
    Document   : update_asset
    Created on : 04 15, 23, 5:25:12 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Asset</title>
    </head>
    <body>
        <h1>Update an Asset</h1>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <% salesBean.load_hoa(); %>
        <% salesBean.load_asset();%>
        <form name="update_asset" action="mod_asset.jsp" method="POST">
            Asset ID: <select name="asset_id" id="asset_id">
                      <% 
                        List<Integer> AssetList = new ArrayList<>(salesBean.assetlist);
                        Collections.sort(AssetList);
                        for (Integer assetID : AssetList) {    
                            if (!assetID.equals(salesBean.enclosing_asset)) { 
                      %>
                                <option value="<%=assetID%>"><%=assetID%></option>
                      <% 
                            } 
                        } 
                      %>                                                    %>
                </select><br>
        <input type="submit" value="Update Asset" name ="Update Asset">
    </body>
</html>
