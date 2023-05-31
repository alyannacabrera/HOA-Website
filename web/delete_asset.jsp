<%-- 
    Document   : delete_asset
    Created on : 04 16, 23, 11:05:10 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Asset</title>
    </head>
    <body>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <form name="delete_asset" action="delete_process.jsp" method="POST">
            <h1>Deleting an Wrongly Encoded Asset</h1><br>
            Asset ID: <select name="asset_id" id="asset_id">
                    <% 
                        salesBean.asset_fordeletion();
                        List<Integer> AssetList = new ArrayList<>(salesBean.assetlist);
                        Collections.sort(AssetList);
                        for (Integer assetID : AssetList) {      
                    %>
                        <option value="<%=assetID%>"><%=assetID%></option>
                    <% 
                        }
                    %>                                                       
                </select><br>
                <input type="submit" value="Delete Asset" name ="Dispose Asset">
        </form> 
    </body>
</html>