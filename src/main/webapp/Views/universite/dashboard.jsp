<%@ page import="Models.Diplome" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Universite" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - <%= universite.getNomUniversite() %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        h1, h2, h3 {
            color: #333;
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
        .actions a {
            margin: 0 5px;
            text-decoration: none;
        }
        .valide { color: green; }
        .rejete { color: red; }
        .form-ajout {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .form-ajout input, .form-ajout select {
            padding: 5px;
            margin: 5px;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<h1>ESPACE UNIVERSITÉ</h1>
<%
    Universite universite = (Universite) session.getAttribute("user");
    if (universite != null) {
%>
<h2>Bienvenue, <%= universite.getNom() %></h2>
<% } %>

<p>Validez officiellement les diplômes de vos diplômés.</p>
<p>Consultez les demandes de vérification émises par les recruteurs et confirmez l’authenticité des diplômes présentés par les candidats.</p>
<hr>

<!-- Formulaire d'ajout de diplôme (simulation) -->
<div class="form-ajout">
    <h3>Ajouter un nouveau diplôme</h3>
    <form action="<%= request.getContextPath() %>/universite/dashboard" method="post">
        <input type="hidden" name="action" value="ajouter">

        <label>ID Candidat:</label>
        <input type="number" name="id_candidat" placeholder="Ex: 5001" required>

        <label>Libellé du diplôme:</label>
        <input type="text" name="libelle" placeholder="Ex: Master Informatique" required style="width:200px;">

        <label>Document justificatif:</label>
        <input type="text" name="document_justificatif" placeholder="Ex: diplome.pdf" required>

        <label>Statut initial:</label>
        <select name="statut_validation">
            <option value="EN_ATTENTE">EN_ATTENTE</option>
            <option value="VALIDÉ">VALIDÉ</option>
            <option value="REJETÉ">REJETÉ</option>
        </select>

        <button type="submit" class="btn">Ajouter à la base de données</button>
    </form>
    <p><em>Note: Ce formulaire simule l'ajout d'un diplôme. En réalité, les diplômes seraient ajoutés par les candidats/recruteurs.</em></p>
</div>

<div class="container">
    <!-- Colonne gauche : Diplômes à valider -->
    <div class="column">
        <h3>DEMANDES DE VALIDATION EN ATTENTE</h3>

        <%
            List<Diplome> diplomesEnAttente = (List<Diplome>) request.getAttribute("diplomesEnAttente");
            if (diplomesEnAttente != null && !diplomesEnAttente.isEmpty()) {
        %>
        <table>
            <thead>
            <tr>
                <th>ID Diplôme</th>
                <th>ID Candidat</th>
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
                <td><strong><%= diplome.getLibelle() %></strong></td>
                <td><%= diplome.getDocument_justificatif() %></td>
                <td class="actions">
                    <form action="<%= request.getContextPath() %>/universite/dashboard" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="valider">
                        <input type="hidden" name="id_diplome" value="<%= diplome.getId_diplome() %>">
                        <button type="submit" class="btn" onclick="return confirm('Valider ce diplôme?')">Valider</button>
                    </form>
                    <form action="<%= request.getContextPath() %>/universite/dashboard" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="rejeter">
                        <input type="hidden" name="id_diplome" value="<%= diplome.getId_diplome() %>">
                        <button type="submit" class="btn" style="background:#dc3545;" onclick="return confirm('Rejeter cette demande?')">Rejeter</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p style="color:#999; text-align:center;">Aucune demande en attente</p>
        <% } %>
    </div>

    <!-- Colonne droite : Historique des diplômes validés -->
    <div class="column">
        <h3>HISTORIQUE DES DIPLÔMES VALIDÉS/REJETÉS</h3>

        <%
            List<Diplome> diplomesHistorique = (List<Diplome>) request.getAttribute("diplomesHistorique");
            if (diplomesHistorique != null && !diplomesHistorique.isEmpty()) {
        %>
        <table>
            <thead>
            <tr>
                <th>ID Diplôme</th>
                <th>ID Candidat</th>
                <th>Diplôme</th>
                <th>Document</th>
                <th>Statut</th>
                <th>Date traitement</th>
            </tr>
            </thead>
            <tbody>
            <% for (Diplome diplome : diplomesHistorique) {
                String statutClass = "VALIDÉ".equals(diplome.getStatut_validation()) ? "valide" : "rejete";
            %>
            <tr>
                <td><%= diplome.getId_diplome() %></td>
                <td><%= diplome.getId_candidat() %></td>
                <td><%= diplome.getLibelle() %></td>
                <td><%= diplome.getDocument_justificatif() %></td>
                <td class="<%= statutClass %>">
                    <%= diplome.getStatut_validation() %>
                    <%= "VALIDÉ".equals(diplome.getStatut_validation()) ? "✓" : "✗" %>
                </td>
                <td><%= diplome.getDate_traitement() != null ? diplome.getDate_traitement() : "N/A" %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p style="color:#999; text-align:center;">Aucun diplôme dans l'historique</p>
        <% } %>
    </div>
</div>

<div style="margin-top: 20px; padding: 10px; background: #f0f0f0; border-radius: 5px;">
    <p><strong>Statistiques:</strong></p>
    <p>Demandes en attente: <%= diplomesEnAttente != null ? diplomesEnAttente.size() : 0 %></p>
    <p>Diplômes traités: <%= diplomesHistorique != null ? diplomesHistorique.size() : 0 %></p>
</div>

<div style="margin-top: 20px; text-align: center;">
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>
</div>

</body>
</html>