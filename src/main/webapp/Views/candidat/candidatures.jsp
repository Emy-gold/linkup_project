<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Candidature" %>
<%@ page import="Models.Cv" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    utilisateur user = (utilisateur) session.getAttribute("user");
    if(user == null || !"CANDIDAT".equals(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }

    List<Candidature> candidatures = (List<Candidature>) request.getAttribute("candidatures");
    Map<Integer, Cv> cvMap = (Map<Integer, Cv>) request.getAttribute("cvMap");
    String currentStatut = (String) request.getAttribute("statut");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Candidatures - LinkUp</title>
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
            <img src="${pageContext.request.contextPath}/assets/logo.png" class="h-12 w-auto mb-8" alt="LinkUp">
            <nav class="space-y-2">
                <a href="dashboard" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a href="annonces" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">work</span>
                    <span class="font-medium">Annonces</span>
                </a>
                <a href="candidatures" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
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
                <a href="profile" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
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
        <!-- Header -->
        <header class="bg-white shadow-sm sticky top-0 z-10">
            <div class="flex items-center justify-between px-8 py-4">
                <h1 class="text-2xl font-bold text-gray-800">Mes Candidatures</h1>
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
            <!-- Filter Tabs -->
            <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                <div class="flex gap-2 flex-wrap">
                    <a href="candidatures" class="px-4 py-2 rounded-lg <%= (currentStatut == null || "Tous".equals(currentStatut)) ? "bg-primary text-white" : "bg-gray-100 text-gray-700 hover:bg-gray-200" %> transition-colors">
                        Toutes
                    </a>
                    <a href="candidatures?statut=En attente" class="px-4 py-2 rounded-lg <%= "En attente".equals(currentStatut) ? "bg-primary text-white" : "bg-gray-100 text-gray-700 hover:bg-gray-200" %> transition-colors">
                        En attente
                    </a>
                    <a href="candidatures?statut=Acceptée" class="px-4 py-2 rounded-lg <%= "Acceptée".equals(currentStatut) ? "bg-primary text-white" : "bg-gray-100 text-gray-700 hover:bg-gray-200" %> transition-colors">
                        Acceptées
                    </a>
                    <a href="candidatures?statut=Refusée" class="px-4 py-2 rounded-lg <%= "Refusée".equals(currentStatut) ? "bg-primary text-white" : "bg-gray-100 text-gray-700 hover:bg-gray-200" %> transition-colors">
                        Refusées
                    </a>
                </div>
            </div>

            <!-- Success Message -->
            <% if(request.getParameter("success") != null) { %>
            <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6">
                <p class="font-semibold">Candidature envoyée avec succès!</p>
            </div>
            <% } %>

            <!-- Candidatures List -->
            <div class="space-y-4">
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    if(candidatures != null && !candidatures.isEmpty()) {
                        for(Candidature c : candidatures) {
                            String statutClass = "";
                            String statutIcon = "";

                            switch(c.getStatutCandidature()) {
                                case "En attente":
                                    statutClass = "bg-yellow-100 text-yellow-700";
                                    statutIcon = "schedule";
                                    break;
                                case "Acceptée":
                                    statutClass = "bg-green-100 text-green-700";
                                    statutIcon = "check_circle";
                                    break;
                                case "Refusée":
                                    statutClass = "bg-red-100 text-red-700";
                                    statutIcon = "cancel";
                                    break;
                                default:
                                    statutClass = "bg-blue-100 text-blue-700";
                                    statutIcon = "info";
                            }

                            // Récupérer le CV associé
                            Cv cv = cvMap != null ? cvMap.get(c.getId()) : null;
                %>
                <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 hover:shadow-md transition-shadow">
                    <div class="flex items-start justify-between">
                        <div class="flex gap-4 flex-1">
                            <div class="w-14 h-14 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                                <span class="material-icons text-primary text-2xl">work</span>
                            </div>
                            <div class="flex-1">
                                <h3 class="text-lg font-bold text-gray-800 mb-1">
                                    Annonce #<%= c.getAnnonceId() %>
                                </h3>
                                <p class="text-sm text-gray-600 mb-3">
                                    Candidature soumise le <%= sdf.format(c.getDateSoumission()) %>
                                </p>
                                <div class="flex items-center gap-4 mb-3 flex-wrap">
                                    <span class="flex items-center gap-1 text-sm text-gray-600">
                                        <span class="material-icons text-sm">description</span>
                                        ID: <%= c.getId() %>
                                    </span>

                                    <!-- Affichage du CV -->
                                    <% if(cv != null) { %>
                                    <span class="flex items-center gap-1 text-sm text-green-600 bg-green-50 px-3 py-1 rounded-full">
                                        <span class="material-icons text-sm">picture_as_pdf</span>
                                        CV: <%= cv.getTitre() %>
                                    </span>
                                    <% } else { %>
                                    <span class="flex items-center gap-1 text-sm text-red-600 bg-red-50 px-3 py-1 rounded-full">
                                        <span class="material-icons text-sm">warning</span>
                                        Aucun CV attaché
                                    </span>
                                    <% } %>
                                </div>
                                <details class="text-sm text-gray-700">
                                    <summary class="cursor-pointer text-primary hover:underline font-medium">
                                        Voir la lettre de motivation
                                    </summary>
                                    <p class="mt-3 p-4 bg-gray-50 rounded-lg border border-gray-200">
                                        <%= c.getLettreMotivation() %>
                                    </p>
                                </details>
                            </div>
                        </div>
                        <div class="flex flex-col items-end gap-3">
                            <span class="px-4 py-2 <%= statutClass %> rounded-full text-sm font-medium flex items-center gap-2">
                                <span class="material-icons text-sm"><%= statutIcon %></span>
                                <%= c.getStatutCandidature() %>
                            </span>

                            <% if(cv != null) { %>
                            <a href="<%= request.getContextPath() + "/" + cv.getCheminFichier() %>" target="_blank"
                               class="text-blue-600 hover:text-blue-700 transition-colors flex items-center gap-1 text-sm">
                                <span class="material-icons text-sm">visibility</span>
                                <span>Voir CV</span>
                            </a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="text-center py-16">
                    <span class="material-icons text-6xl text-gray-300 mb-4">inbox</span>
                    <h3 class="text-xl font-semibold text-gray-600 mb-2">Aucune candidature</h3>
                    <p class="text-gray-500 mb-6">Vous n'avez pas encore postulé à des offres</p>
                    <a href="annonces" class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors">
                        <span class="material-icons">search</span>
                        <span>Parcourir les annonces</span>
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </main>
</div>
</body>
</html>