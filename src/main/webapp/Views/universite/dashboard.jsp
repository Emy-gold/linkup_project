<%@ page import="Models.Diplome" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Universite" %>
<%
    // Récupérer les attributs
    Universite universite = (Universite) request.getAttribute("universite");
    List<Diplome> diplomesEnAttente = (List<Diplome>) request.getAttribute("diplomesEnAttente");
    List<Diplome> diplomesHistorique = (List<Diplome>) request.getAttribute("diplomesHistorique");

    // Si universite est null, rediriger
    if (universite == null) {
        response.sendRedirect(request.getContextPath() + "/universite-select");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - <%= universite.getNomUniversite() != null ? universite.getNomUniversite() : "Université" %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .header {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .header h1, .header h2 {
            margin: 0;
            color: #333;
        }
        .header-info {
            color: #666;
            margin-top: 10px;
        }
        .back-btn {
            background: #6c757d;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 15px;
        }
        .back-btn:hover {
            background: #5a6268;
        }
        .container {
            display: flex;
            gap: 20px;
        }
        .column {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .actions form {
            display: inline;
            margin: 0 2px;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 0.9em;
        }
        .btn-validate {
            background: #28a745;
            color: white;
        }
        .btn-reject {
            background: #dc3545;
            color: white;
        }
        .valide { color: green; }
        .rejete { color: red; }
        .stats {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .empty-message {
            color: #999;
            text-align: center;
            padding: 20px;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>ESPACE UNIVERSITÉ</h1>
    <h2><%= universite.getNomUniversite() != null ? universite.getNomUniversite() : "Université" %></h2>
    <div class="header-info">
        <p><strong>Agent responsable:</strong>
            <%= universite.getPrenom() != null ? universite.getPrenom() : "" %>
            <%= universite.getNom() != null ? universite.getNom() : "" %></p>
        <p><strong>Email contact:</strong>
            <%= universite.getEmailContact() != null ? universite.getEmailContact() : "Non spécifié" %></p>
        <p><strong>Téléphone:</strong>
            <%= universite.getTelephone() != null ? universite.getTelephone() : "Non spécifié" %></p>
    </div>
</div>

<a href="<%= request.getContextPath() %>/universite-select" class="back-btn">
    ← Changer d'université
</a>

<!-- Afficher les erreurs s'il y en a -->
<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<div class="error">
    <strong>Erreur:</strong> <%= error %>
</div>
<% } %>

<div class="container">
    <!-- Colonne gauche : Diplômes à valider -->
    <div class="column">
        <h3>DEMANDES DE VALIDATION EN ATTENTE</h3>

        <% if (diplomesEnAttente != null && !diplomesEnAttente.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Candidat</th>
                <th>Diplôme</th>
                <th>Document</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Diplome diplome : diplomesEnAttente) { %>
            <tr>
                <td><%= diplome.getId_diplome() %></td>
                <td><%= diplome.getId_candidat() %></td>
                <td><strong><%= diplome.getLibelle() != null ? diplome.getLibelle() : "" %></strong></td>
                <td><%= diplome.getDocument_justificatif() != null ? diplome.getDocument_justificatif() : "" %></td>
                <td class="actions">
                    <form action="<%= request.getContextPath() %>/universite-dashboard" method="post">
                        <input type="hidden" name="action" value="valider">
                        <input type="hidden" name="id_diplome" value="<%= diplome.getId_diplome() %>">
                        <input type="hidden" name="id_universite" value="<%= universite.getId_universite() %>">
                        <button type="submit" class="btn btn-validate" onclick="return confirm('Valider ce diplôme?')">Valider</button>
                    </form>
                    <form action="<%= request.getContextPath() %>/universite-dashboard" method="post">
                        <input type="hidden" name="action" value="rejeter">
                        <input type="hidden" name="id_diplome" value="<%= diplome.getId_diplome() %>">
                        <input type="hidden" name="id_universite" value="<%= universite.getId_universite() %>">
                        <button type="submit" class="btn btn-reject" onclick="return confirm('Rejeter cette demande?')">Rejeter</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p class="empty-message">Aucune demande en attente</p>
        <% } %>
    </div>

    <!-- Colonne droite : Historique -->
    <div class="column">
        <h3>HISTORIQUE DES VALIDATIONS</h3>

        <% if (diplomesHistorique != null && !diplomesHistorique.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Candidat</th>
                <th>Diplôme</th>
                <th>Document</th>
                <th>Statut</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <% for (Diplome diplome : diplomesHistorique) {
                String statutClass = "VALIDÉ".equals(diplome.getStatut_validation()) ? "valide" : "rejete";
            %>
            <tr>
                <td><%= diplome.getId_diplome() %></td>
                <td><%= diplome.getId_candidat() %></td>
                <td><%= diplome.getLibelle() != null ? diplome.getLibelle() : "" %></td>
                <td><%= diplome.getDocument_justificatif() != null ? diplome.getDocument_justificatif() : "" %></td>
                <td class="<%= statutClass %>">
                    <%= diplome.getStatut_validation() != null ? diplome.getStatut_validation() : "" %>
                    <%= "VALIDÉ".equals(diplome.getStatut_validation()) ? "✓" :
                            "REJETÉ".equals(diplome.getStatut_validation()) ? "✗" : "" %>
                </td>
                <td><%= diplome.getDate_traitement() != null ? diplome.getDate_traitement() : "N/A" %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p class="empty-message">Aucun diplôme dans l'historique</p>
        <% } %>
    </div>
</div>

<div class="stats">
    <p><strong>Statistiques:</strong></p>
    <p>• Demandes en attente: <%= diplomesEnAttente != null ? diplomesEnAttente.size() : 0 %></p>
    <p>• Diplômes traités: <%= diplomesHistorique != null ? diplomesHistorique.size() : 0 %></p>
    <p>• Total diplômes: <%= (diplomesEnAttente != null ? diplomesEnAttente.size() : 0) +
            (diplomesHistorique != null ? diplomesHistorique.size() : 0) %></p>
</div>

<div style="text-align: center; margin-top: 20px;">
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>
</div>

</body>
</html>