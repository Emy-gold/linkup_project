<%@ page import="java.util.List" %>
<%@ page import="Models.Universite" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sélectionner une université</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .universite-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .universite-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
            background: white;
        }
        .universite-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: #007bff;
        }
        .universite-card h3 {
            margin-top: 0;
            color: #007bff;
        }
        .select-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 15px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .select-btn:hover {
            background: #0056b3;
        }
        .info {
            color: #666;
            font-size: 0.9em;
            margin: 5px 0;
        }
        .logout {
            display: inline-block;
            margin-top: 30px;
            color: #666;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>ESPACE UNIVERSITÉ</h1>
    <h2>Sélectionnez une université à gérer</h2>

    <%
        List<Universite> universites = (List<Universite>) request.getAttribute("universites");
    %>

    <div class="universite-list">
        <% if (universites != null && !universites.isEmpty()) {
            for (Universite universite : universites) { %>
        <div class="universite-card">
            <h3><%= universite.getNomUniversite() %></h3>
            <div class="info">
                <strong>Agent:</strong> <%= universite.getPrenom() %> <%= universite.getNom() %><br>
                <strong>Email contact:</strong> <%= universite.getEmailContact() %><br>
                <strong>Téléphone:</strong> <%= universite.getTelephone() %><br>
                <strong>Adresse:</strong> <%= universite.getAdresse() != null ? universite.getAdresse() : "Non spécifiée" %>
            </div>

            <a href="<%= request.getContextPath() %>/universite-dashboard?id_universite=<%= universite.getId_universite() %>"
               class="select-btn">
                Gérer les diplômes
            </a>
        </div>
        <% }
        } else { %>
        <p style="color: #666; text-align: center; grid-column: 1 / -1;">
            Aucune université disponible dans le système.
        </p>
        <% } %>
    </div>

    <div style="text-align: center; margin-top: 40px;">
        <a href="<%= request.getContextPath() %>/logout" class="logout">Déconnexion</a>
    </div>
</div>

</body>
</html>