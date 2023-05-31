<%-- 
    Document   : register_asset
    Created on : 04 14, 23, 6:36:34 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, asset_management.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register an Asset</title>
    </head>
    <body>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <% salesBean.load_hoa(); %>
        <% salesBean.load_asset();%>
        
        <form name="register_asset" action="adding_asset.jsp" method="POST">
            <h1>Register an Asset</h1><br>
            Asset Name: <input type="text" name="asset_name" id ="asset_name"><br>
            Asset Description: <input type="text" name="asset_description" id="asset_description"><br>
            For Rent: <input type="checkbox" value ="1" name="forrent" id="forrent"><br>
            Asset Value: <input type="text" name="asset_value" id ="asset_value"><br>
            Asset Type: <select name="type_asset" id="type_asset">
                    <option value="P">P</option>
                    <option value="E">E</option>
                    <option value="F">F</option>
                    <option value="O">O</option>
            </select><br>
            Location (Latitude): <input type="text" name="loc_lattitude" id ="loc_lattitude"><br>
            Location (Longitude): <input type="text" name="loc_longiture" id ="loc_longiture"><br>
            HOA: <select name="hoa_name" id="hoa_name">
                    <% for (int i=0; i<salesBean.hoalist.size(); i++) {    %>
                    <%    String hoaname = salesBean.hoalist.get(i);                    %>
                    <option value="<%=hoaname%>"><%=hoaname%></option>
                    <% }                                                       %>
                </select><br>
            Enclosing Asset: <select name="enclosing_asset" id="enclosing_asset">
                    <option value="N/A">N/A</option>
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
                    %>                                                       %>
                </select><br>
                <input type="submit" value="Register Asset" name ="Register Asset">
        </form> 
    </body>
</html>
