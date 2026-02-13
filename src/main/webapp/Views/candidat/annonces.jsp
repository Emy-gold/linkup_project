<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Annonce" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%
    utilisateur user = (utilisateur) session.getAttribute("user");
    if(user == null || !"CANDIDAT".equals(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }

    List<Annonce> annonces = (List<Annonce>) request.getAttribute("annonces");
    String keyword = (String) request.getAttribute("keyword");
    String typeContrat = (String) request.getAttribute("typeContrat");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Annonces - LinkUp</title>
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
                <a href="annonces" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
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
                <h1 class="text-2xl font-bold text-gray-800">Annonces Disponibles</h1>
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
            <!-- Search and Filter -->
            <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                <form action="annonces" method="get" class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="md:col-span-2">
                        <div class="relative">
                            <span class="material-icons absolute left-3 top-3 text-gray-400">search</span>
                            <input type="text" name="keyword" value="<%= keyword != null ? keyword : "" %>" placeholder="Rechercher par titre, entreprise..." class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                        </div>
                    </div>
                    <select name="typeContrat" onchange="this.form.submit()" class="px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                        <option value="">Tous les contrats</option>
                        <option value="CDI" <%= "CDI".equals(typeContrat) ? "selected" : "" %>>CDI</option>
                        <option value="CDD" <%= "CDD".equals(typeContrat) ? "selected" : "" %>>CDD</option>
                        <option value="Stage" <%= "Stage".equals(typeContrat) ? "selected" : "" %>>Stage</option>
                        <option value="Alternance" <%= "Alternance".equals(typeContrat) ? "selected" : "" %>>Alternance</option>
                    </select>
                </form>
            </div>

            <!-- Job Listings -->
            <div class="space-y-4">
                <%
                    if(annonces != null && !annonces.isEmpty()) {
                        for(Annonce a : annonces) {
                            // Calculate days since publication
                            long diffInMillies = Math.abs(new Date().getTime() - a.getDatePublication().getTime());
                            long daysSince = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
                            String timeAgo = daysSince == 0 ? "Aujourd'hui" :
                                    daysSince == 1 ? "Hier" :
                                            "Il y a " + daysSince + " jours";

                            String typeContratClass = "";
                            switch(a.getTypeContrat()) {
                                case "CDI":
                                    typeContratClass = "bg-primary/10 text-primary";
                                    break;
                                case "CDD":
                                    typeContratClass = "bg-green-50 text-green-600";
                                    break;
                                case "Stage":
                                    typeContratClass = "bg-yellow-50 text-yellow-600";
                                    break;
                                case "Alternance":
                                    typeContratClass = "bg-blue-50 text-blue-600";
                                    break;
                                default:
                                    typeContratClass = "bg-gray-50 text-gray-600";
                            }
                %>
                <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 hover:shadow-md transition-shadow">
                    <div class="flex items-start justify-between">
                        <div class="flex gap-4 flex-1">
                            <div class="w-16 h-16 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                                <span class="material-icons text-primary text-3xl">business</span>
                            </div>
                            <div class="flex-1">
                                <h3 class="text-xl font-bold text-gray-800 mb-2"><%= a.getTitre() %></h3>
                                <p class="text-gray-600 mb-3">Recruteur ID: <%= a.getId_recruteur() %></p>
                                <div class="flex flex-wrap gap-2 mb-4">
                                    <span class="px-3 py-1 <%= typeContratClass %> rounded-full text-sm font-medium"><%= a.getTypeContrat() %></span>
                                    <span class="px-3 py-1 bg-purple-50 text-purple-600 rounded-full text-sm">ID: <%= a.getId() %></span>
                                </div>
                                <p class="text-gray-600 text-sm mb-4"><%= a.getDescription() %></p>
                                <div class="flex items-center gap-4 text-sm text-gray-500">
                                        <span class="flex items-center gap-1">
                                            <span class="material-icons text-sm">schedule</span>
                                            <%= timeAgo %>
                                        </span>
                                    <span class="flex items-center gap-1">
                                            <span class="material-icons text-sm">calendar_today</span>
                                            <%= sdf.format(a.getDatePublication()) %>
                                        </span>
                                </div>
                            </div>
                        </div>
                        <a href="postuler?id=<%= a.getId() %>" class="px-6 py-2 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-medium">
                            Postuler
                        </a>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="text-center py-16">
                    <span class="material-icons text-6xl text-gray-300 mb-4">work_off</span>
                    <h3 class="text-xl font-semibold text-gray-600 mb-2">Aucune annonce disponible</h3>
                    <p class="text-gray-500">Il n'y a pas d'annonces correspondant à vos critères pour le moment</p>
                </div>
                <% } %>
            </div>
        </div>
    </main>
</div>
</body>
</html>