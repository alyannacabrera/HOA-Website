<%-- 
    Document   : dispose_asset
    Created on : 04 16, 23, 8:36:52 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dispose Asset</title>
    </head>
    <body>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <form name="dispose_asset" action="dispose_process.jsp" method="POST">
            <h1>Disposing an Asset</h1><br>
            Asset ID: <select name="asset_id" id="asset_id">
                    <% 
                       salesBean.asset_fordisposal();
                        List<Integer> AssetList = new ArrayList<>(salesBean.assetlist);
                        Collections.sort(AssetList);
                        for (Integer assetID : AssetList) {      
                    %>
                        <option value="<%=assetID%>"><%=assetID%></option>
                    <% 
                        } 
                    %>                                                       
                </select><br>
                <input type="submit" value="Dispose Asset" name ="Dispose Asset">
        </form> 
    </body>
</html>
