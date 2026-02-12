<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Candidat" %>
<%@ page import="Models.Diplome" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Universite" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    utilisateur user = (utilisateur) session.getAttribute("user");
    if(user == null || !"CANDIDAT".equals(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }

    Candidat candidatInfo = (Candidat) request.getAttribute("candidat");
    List<Diplome> diplomes = (List<Diplome>) request.getAttribute("diplomes");
    List<Universite> universites = (List<Universite>) request.getAttribute("universites");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mon Profil - LinkUp</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#3ea721",
                        "primary-dark": "#2e8018",
                    },
                    fontFamily: {
                        sans: ["Inter", "sans-serif"],
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-gray-50 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <aside class="w-64 bg-white shadow-lg">
        <div class="p-6">
            <img src="${pageContext.request.contextPath}/logo.png" class="h-12 w-auto mb-8" alt="LinkUp">
            <nav class="space-y-2">
                <a href="dashboard" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a href="annonces" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">work</span>
                    <span class="font-medium">Annonces</span>
                </a>
                <a href="candidatures" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">description</span>
                    <span class="font-medium">Mes Candidatures</span>
                </a>
                <a href="cv" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">article</span>
                    <span class="font-medium">Mon CV</span>
                </a>
                <a href="entretiens" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">event</span>
                    <span class="font-medium">Entretiens</span>
                </a>
                <a href="profile" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
                    <span class="material-icons">person</span>
                    <span class="font-medium">Mon Profil</span>
                </a>
            </nav>
        </div>
        <div class="absolute bottom-0 w-64 p-6 border-t">
            <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-3 rounded-lg text-red-600 hover:bg-red-50 transition-colors">
                <span class="material-icons">logout</span>
                <span class="font-medium">Déconnexion</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-y-auto">
        <header class="bg-white shadow-sm sticky top-0 z-10">
            <div class="flex items-center justify-between px-8 py-4">
                <h1 class="text-2xl font-bold text-gray-800">Mon Profil</h1>
                <div class="flex items-center gap-3">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-800"><%= user.getPrenom() %> <%= user.getNom() %></p>
                        <p class="text-xs text-gray-500">Candidat</p>
                    </div>
                    <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-bold">
                        <%= user.getPrenom().substring(0,1) %><%= user.getNom().substring(0,1) %>
                    </div>
                </div>
            </div>
        </header>

        <div class="p-8">
            <!-- Messages -->
            <%
                String success = request.getParameter("success");
                if(success != null) {
                    String message = "profile".equals(success) ? "Profil mis à jour avec succès!" :
                            "diplome".equals(success) ? "Diplôme ajouté avec succès!" :
                                    "deleted".equals(success) ? "Diplôme supprimé avec succès!" : "Opération réussie!";
            %>
            <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6">
                <p class="font-semibold"><%= message %></p>
            </div>
            <% } %>

            <% if(request.getParameter("error") != null) { %>
            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
                <p class="font-semibold">Une erreur est survenue. Veuillez réessayer.</p>
            </div>
            <% } %>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Profile Card -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="text-center mb-6">
                            <div class="w-24 h-24 rounded-full bg-primary flex items-center justify-center text-white text-3xl font-bold mx-auto mb-4">
                                <%= user.getPrenom().substring(0,1) %><%= user.getNom().substring(0,1) %>
                            </div>
                            <h2 class="text-xl font-bold text-gray-800"><%= user.getPrenom() %> <%= user.getNom() %></h2>
                            <% if(candidatInfo != null && candidatInfo.getTitreProfil() != null) { %>
                            <p class="text-gray-600 mt-1"><%= candidatInfo.getTitreProfil() %></p>
                            <% } else { %>
                            <p class="text-gray-400 mt-1 text-sm">Titre professionnel non renseigné</p>
                            <% } %>
                        </div>

                        <div class="space-y-3 border-t pt-4">
                            <div class="flex items-center gap-3 text-sm">
                                <span class="material-icons text-gray-400">email</span>
                                <span class="text-gray-700"><%= user.getEmail() %></span>
                            </div>
                            <div class="flex items-center gap-3 text-sm">
                                <span class="material-icons text-gray-400">badge</span>
                                <span class="text-gray-700">ID: <%= user.getIdUtilisateur() %></span>
                            </div>
                            <div class="flex items-center gap-3 text-sm">
                                <span class="material-icons text-gray-400">calendar_today</span>
                                <span class="text-gray-700">Inscrit le <%= sdf.format(user.getDate()) %></span>
                            </div>
                            <div class="flex items-center gap-3 text-sm">
                                <span class="material-icons text-gray-400">verified</span>
                                <span class="px-2 py-1 bg-green-100 text-green-700 rounded-full text-xs font-medium">
                                        <%= user.getStatutCompte() %>
                                    </span>
                            </div>
                            <% if(candidatInfo != null && candidatInfo.getDisponibilite() != null) { %>
                            <div class="flex items-center gap-3 text-sm">
                                <span class="material-icons text-gray-400">schedule</span>
                                <span class="text-gray-700"><%= candidatInfo.getDisponibilite() %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Forms Column -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Edit Profile Form -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <h3 class="text-lg font-bold text-gray-800 mb-6">Modifier mes informations</h3>

                        <form action="profile" method="post" class="space-y-6">
                            <input type="hidden" name="action" value="updateProfile">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Prénom</label>
                                    <input type="text" name="prenom" value="<%= user.getPrenom() %>" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Nom</label>
                                    <input type="text" name="nom" value="<%= user.getNom() %>" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                                <input type="email" name="email" value="<%= user.getEmail() %>" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Titre professionnel</label>
                                <input type="text" name="titreProfil" value="<%= candidatInfo != null && candidatInfo.getTitreProfil() != null ? candidatInfo.getTitreProfil() : "" %>" placeholder="Ex: Développeur Full Stack" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Disponibilité</label>
                                <select name="disponibilite" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    <option value="">-- Sélectionner --</option>
                                    <option value="Immédiate" <%= candidatInfo != null && "Immédiate".equals(candidatInfo.getDisponibilite()) ? "selected" : "" %>>Immédiate</option>
                                    <option value="1 mois" <%= candidatInfo != null && "1 mois".equals(candidatInfo.getDisponibilite()) ? "selected" : "" %>>Dans 1 mois</option>
                                    <option value="2 mois" <%= candidatInfo != null && "2 mois".equals(candidatInfo.getDisponibilite()) ? "selected" : "" %>>Dans 2 mois</option>
                                    <option value="3 mois" <%= candidatInfo != null && "3 mois".equals(candidatInfo.getDisponibilite()) ? "selected" : "" %>>Dans 3 mois</option>
                                    <option value="Non disponible" <%= candidatInfo != null && "Non disponible".equals(candidatInfo.getDisponibilite()) ? "selected" : "" %>>Non disponible</option>
                                </select>
                            </div>

                            <button type="submit" class="w-full px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-semibold flex items-center justify-center gap-2">
                                <span class="material-icons">save</span>
                                <span>Enregistrer les modifications</span>
                            </button>
                        </form>
                    </div>

                    <!-- Diplomes Section -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-bold text-gray-800">Mes Diplômes</h3>
                            <button onclick="document.getElementById('addDiplomeModal').classList.remove('hidden')" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors flex items-center gap-2 text-sm">
                                <span class="material-icons text-sm">add</span>
                                <span>Ajouter</span>
                            </button>
                        </div>

                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-3 mb-4">
                            <p class="text-xs text-blue-800"><strong>Note:</strong> Les diplômes doivent être validés par un agent universitaire.</p>
                        </div>

                        <div class="space-y-3">
                            <%
                                if(diplomes != null && !diplomes.isEmpty()) {
                                    for(Diplome d : diplomes) {
                                        String statutClass = "";
                                        String statutIcon = "";
                                        switch(d.getStatut_validation()) {
                                            case "En attente": statutClass = "bg-yellow-100 text-yellow-700"; statutIcon = "schedule"; break;
                                            case "Validé": statutClass = "bg-green-100 text-green-700"; statutIcon = "check_circle"; break;
                                            case "Rejeté": statutClass = "bg-red-100 text-red-700"; statutIcon = "cancel"; break;
                                            default: statutClass = "bg-gray-100 text-gray-700"; statutIcon = "help";
                                        }
                            %>
                            <div class="flex items-center gap-4 p-4 bg-gray-50 rounded-lg border border-gray-200">
                                <div class="w-12 h-12 rounded-lg bg-purple-50 flex items-center justify-center flex-shrink-0">
                                    <span class="material-icons text-purple-500">school</span>
                                </div>
                                <div class="flex-1">
                                    <h4 class="font-semibold text-gray-800"><%= d.getLibelle() %></h4>
                                    <p class="text-xs text-gray-500">ID: <%= d.getId_diplome() %></p>
                                </div>
                                <span class="px-3 py-1 <%= statutClass %> rounded-full text-xs font-medium flex items-center gap-1">
                                        <span class="material-icons text-xs"><%= statutIcon %></span>
                                        <%= d.getStatut_validation()%>
                                    </span>
                                <div class="flex gap-2">
                                    <% if(d.getDocument_justificatif() != null) { %>
                                    <a href="<%= request.getContextPath() + "/" + d.getDocument_justificatif() %>" target="_blank" class="p-2 bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-100">
                                        <span class="material-icons text-sm">visibility</span>
                                    </a>
                                    <% } %>
                                    <form action="profile" method="post" onsubmit="return confirm('Supprimer ce diplôme?')">
                                        <input type="hidden" name="action" value="deleteDiplome">
                                        <input type="hidden" name="diplomeId" value="<%= d.getId_diplome()%>">
                                        <button type="submit" class="p-2 bg-red-50 text-red-600 rounded-lg hover:bg-red-100">
                                            <span class="material-icons text-sm">delete</span>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <% } } else { %>
                            <p class="text-center text-gray-500 py-8 text-sm">Aucun diplôme ajouté</p>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Add Diplome Modal -->
<div id="addDiplomeModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-xl shadow-xl p-8 max-w-md w-full mx-4">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Ajouter un diplôme</h2>
            <button onclick="document.getElementById('addDiplomeModal').classList.add('hidden')" class="text-gray-400 hover:text-gray-600">
                <span class="material-icons">close</span>
            </button>
        </div>

        <form action="profile" method="post" enctype="multipart/form-data" class="space-y-4">
            <input type="hidden" name="action" value="addDiplome">

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Nom du diplôme</label>
                <input type="text" name="libelle" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Ex: Licence en Informatique">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Université / École</label>
                <select name="id_universite" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="">-- Sélectionner une université --</option>
                    <%
                        if(universites != null && !universites.isEmpty()) {
                            for(Universite univ : universites) {
                    %>
                    <option value="<%= univ.getId_universite() %>"><%= univ.getNomUniversite() %></option>
                    <%
                        }
                    } else {
                    %>
                    <option value="" disabled>Aucune université disponible</option>
                    <% } %>
                </select>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Document (PDF ou Image)</label>
                <input type="file" name="documentJustificatif" accept=".pdf,.jpg,.jpeg,.png" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                <p class="text-xs text-gray-500 mt-2">PDF, JPG, PNG (max 10MB)</p>
            </div>

            <div class="flex gap-3 pt-4">
                <button type="submit" class="flex-1 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-semibold">
                    Ajouter
                </button>
                <button type="button" onclick="document.getElementById('addDiplomeModal').classList.add('hidden')" class="px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-semibold">
                    Annuler
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>