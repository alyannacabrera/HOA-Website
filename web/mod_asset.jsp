<%-- 
    Document   : mod_asset
    Created on : 04 15, 23, 6:32:32 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Asset</title>
    </head>
    <body>
        <h1>Make Changes to Selected Asset</h1>
        <jsp:useBean id="salesBean" class="asset_management.asset" scope="session" />
        <% String assetID_toEDIT = request.getParameter("asset_id");%>
        <% if (salesBean.load_for_update(Integer.parseInt(assetID_toEDIT))==1){  %>
            <h3>Type the Things You Want to Change</h3>
        <%} %>
    <form name="mod_asset" action="edit_asset.jsp" method="POST">
        <% salesBean.asset_id = Integer.parseInt(assetID_toEDIT);%>
        <tr>Asset ID: <%= salesBean.asset_id %></tr><br>
        Asset Name: <input type="text" name="asset_name" id="asset_name" value="<%=salesBean.asset_name%>"><br>
        Asset Description: <input type="text" name="asset_description" id="asset_description" value="<%=salesBean.asset_description%>"><br>
        For Rent: 
        <%if (salesBean.forrent == true){%>
        <input type="checkbox" name="forrent" id="forrent" value="1" checked><br>
        <% }else {%>
        <input type="checkbox" name="forrent" id="forrent" value="1"><br>
        <%}%>
        
        Asset Value: <input type="text" name="asset_value" id="asset_value" value="<%=salesBean.asset_value%>"><br>
        
        Asset Type: <select name="type_asset" id="type_asset">
                        <option value=<%=salesBean.type_asset%> selected><%=salesBean.type_asset%></option>
                        
                    <% if (salesBean.type_asset == 'P'){%>
                        <option value="E">E</option>
                        <option value="F">F</option>
                        <option value="O">O</option>
                    <% } %>
                    
                    <% if (salesBean.type_asset == 'E'){%>
                        <option value="P">P</option>
                        <option value="F">F</option>
                        <option value="O">O</option>
                    <% } %>
                    
                    <% if (salesBean.type_asset == 'F'){%>
                        <option value="P">P</option>
                        <option value="E">E</option>
                        <option value="O">O</option>
                    <% } %>
                    
                    <% if (salesBean.type_asset == 'O'){%>
                        <option value="P">P</option>
                        <option value="E">E</option>
                        <option value="F">F</option>
                    <% } %>

                </select><br>
        Status: <select name="status" id="status">
                    <option value=<%=salesBean.status%> selected><%=salesBean.status%></option>
                    <% if (salesBean.status == 'W'){%>
                        <option value="D">D</option>
                        <option value="P">P</option>
                        <option value="S">S</option>
                        <option value="X">X</option>
                    <% } %>
                    
                    <% if (salesBean.status == 'D'){%>
                        <option value="W">W</option>
                        <option value="P">P</option>
                        <option value="S">S</option>
                        <option value="X">X</option>
                    <% } %>
                    
                    <% if (salesBean.status == 'P'){%>
                        <option value="W">W</option>
                        <option value="D">D</option>
                        <option value="S">S</option>
                        <option value="X">X</option>
                    <% } %>
                    
                    <% if (salesBean.status == 'S'){%>
                        <option value="W">W</option>
                        <option value="D">D</option>
                        <option value="P">P</option>
                        <option value="X">X</option>
                    <% } %>
                    
                    <% if (salesBean.status == 'X'){%>
                        <option value="W">W</option>
                        <option value="D">D</option>
                        <option value="P">P</option>
                        <option value="S">S</option>
                    <% } %>
                </select><br>
    

        Location (Latitude): <input type="text" name="loc_lattitude" id="loc_lattitude" value="<%=salesBean.loc_lattitude%>"><br>
        Location (Longitude): <input type="text" name="loc_longiture" id="loc_longiture" value="<%=salesBean.loc_longiture%>"><br>

        HOA: <select name="hoa_name" id="hoa_name">
                <option value=<%=salesBean.hoa_name%> selected><%=salesBean.hoa_name%></option>
                    <% for (int i=0; i<salesBean.hoalist.size(); i++) { %>
                    <%      String hoaname = salesBean.hoalist.get(i); %>
                    <%      if (!hoaname.equals(salesBean.hoa_name)) { %>
                            <option value="<%=hoaname%>"><%=hoaname%></option>
                    <%      } %>
                    <% } %>
                    </select><br>
        Enclosing Asset: <select name="enclosing_asset" id="enclosing_asset">
            <% if (!salesBean.enclosing_asset.equals("0")) { %>
                <option value=<%=salesBean.enclosing_asset%> selected><%=salesBean.enclosing_asset%></option>
            <% } %>
            <option value="N/A">N/A</option>
            <% 
                List<Integer> AssetList = new ArrayList<>(salesBean.assetlist);
                Collections.sort(AssetList);
                for (Integer assetID : AssetList) {    
                    if (!assetID.equals(salesBean.enclosing_asset)) { 
                        if(Integer.parseInt(assetID_toEDIT) != (assetID)){
            %>
                            <option value="<%=assetID%>"><%=assetID%></option>
            <%          }
                    } 
                } 
            %>
        </select>


                        </select><br>
        <input type="submit" value="Update Asset" name ="Update Asset">
        </form> 
    </body>
</html>
