<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Candidature" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Entretien" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Le code Java-->
<%
    utilisateur user = (utilisateur) session.getAttribute("user");
    //alidation d'utilisateur
    if(user == null || !"CANDIDAT".equals(user.getRole())){
        response.sendRedirect("../../login.jsp");
        return;
    }

    Integer candidaturesCount = (Integer) request.getAttribute("candidaturesCount");
    Integer entretiensCount = (Integer) request.getAttribute("entretiensCount");
    Integer cvsCount = (Integer) request.getAttribute("cvCount");
    List<Candidature> recentCandidatures = (List<Candidature>) request.getAttribute("requestCandidatures");
    List<Entretien> upcomingEntretiens = (List<Entretien>) request.getAttribute("upcomingEntretiens");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
%>
<!--//Jsp code avec html et tailwind-->
<html>
<head>
    <title>Dashboard - LinkUp</title>
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
        <aside class="w-64 bg-white shadow-lg">
            <div class="p-6">
                <img src="${pageContext.request.contextPath}/assets/logo.png" class="h-12 w-auto mb-8" alt="LinkUp">
                <nav class="space-y-2">
                    <a href="${pageContext.request.contextPath}/candidat/dashboard" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
                        <span class="material-icons">dashboard</span>
                        <span class="font-medium">Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/candidat/annonces" class="flex items-center gap-3 px-3 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                        <span class="material-icons">work</span>
                        <span cñass="font-medium">Annonces</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/candidat/candidatures" class="flex items-center gap-3 px-3 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                        <span class="material-icons">description</span>
                        <span class="font-medium">Mes Candidatures</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/candidat/cv" class="flex items-center gap-3 px-3 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                        <span class="material-icons">article</span>
                        <span class="font-meduim">Mon Cv</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/candidat/entretiens" class="flex items-center gap-3 px-3 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                        <span class="material-icons">event</span>
                        <span class="font-meduim">Entretiens</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/candidat/profile" class="flex items-center gap-3 px-3 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                        <span class="material-icons">person</span>
                        <span class="font-meduim">Mon Profil</span>
                    </a>
                </nav>
            </div>
            <div class="absolute bottom-0 w-64 p-6 border-t">
                <a href="${pageContext.request.contextPath}/Logout" class="flex items-center gap-3 text-red-600 px-4 py-3 hover:bg-red-50 transition-colors">
                    <span class="material-icons">logout</span>
                    <span class="font-meduim">Déconnexion</span>
                </a>
            </div>
        </aside>
        <!--Main Content-->
        <main class=" flex-1 overflow-y-auto">
            <header class="bg-white shadow-sm sticky top-0 z-10">
                <div class="flex items-center justify-between px-8 py-4">
                    <h1 class="text-2xl font-bold text-gray-800">Bienvenue, <%= user.getPrenom()%>!</h1>
                    <div class="flex items-center gap-3">
                        <div class="text-right">
                            <p class="text-sm font-semibold text-gray-800"><%= user.getPrenom()%><%= user.getNom()%></p>
                            <p class="text-sm text-gray-500">Candidat</p>
                        </div>
                        <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-bold">
                            <%= user.getPrenom().substring(0,1)%><%= user.getNom().substring(0,1)%>
                        </div>
                    </div>
                </div>
            </header>
            <!--The 3 Crads-->
            <div class="p-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                    <!--The Card 1 -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-600 mb-1">Candidatures</p>
                                <p class="text-3xl font-bold text-gray-800"><%= candidaturesCount != null ? candidaturesCount : 0%></p>
                            </div>
                            <div class="w-12 h-12 rounded-lg bg-blue-50 flex items-center justify-center">
                                <span class="text-blue-500 material-icons">description</span>
                            </div>
                        </div>
                    </div>

                    <!--The Card 2 -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-600 mb-1">Entretiens</p>
                                <p class="text-3xl font-bold text-gray-800"><%= entretiensCount != null ? entretiensCount : 0 %></p>
                            </div>
                            <div class="w-12 h-12 rounded-lg bg-blue-50 flex items-center justify-center">
                                <span class="text-blue-500 material-icons">event</span>
                            </div>
                        </div>
                    </div>
                    <!-- The card 2-->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-600 mb-1">CV Actif</p>
                                <p class="text-3xl font-bold text-gray-800"> <%= cvsCount != null ? cvsCount : 0%></p>
                            </div>
                            <div class="w-12 h-12 rounded-lg bg-blue-50 flex items-center justify-center">
                                <span class="text-blue-500 material-icons">article</span>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Recent Applications & Upcoming Interviews-->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-lg font-bold text-gray-800">Candidatures Récentes</h2>
                            <a href="${pageContext.request.contextPath}/candidatues" class="text-sm text-primary hover:underline">Voir tout</a>
                        </div>
                        <div class="space-y-4">
                            <%
                                if(recentCandidatures != null && !recentCandidatures.isEmpty()) {
                                    for(Candidature c : recentCandidatures) {
                                        String statutClass = "";
                                        switch(c.getStatutCandidature()) {
                                            case "En attente": statutClass = "bg-yellow-100 text-yellow-700"; break;
                                            case "Acceptée" : statutClass = "bg-green-100 text-green-700"; break;
                                            case "Refusée" : statutClass = "bg-red-100 text-red-700"; break;
                                            default: statutClass = "bg-blue-100 text-blue-700";
                                        }
                            %>
                            <div class="flex items-center gap-4 bg-gray-50 rounded-lg">
                                <div class="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center">
                                    <span class="material-icons text-primary">business</span>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-semibold text-gray-800">Candidature #<%=c.getId()%></h3>
                                    <p class="text-sm text-gray-600">Annonce #<%=c.getAnnonceId()%></p>
                                </div>
                                <span class="px-3 py-1 <%= statutClass%> rounded-full text-xs font-medium"><%=c.getStatutCandidature()%></span>
                            </div>
                            <%} }else {%>
                            <p class="text-center text-gray-500 py-8">Aucune candidature récente</p>
                            <% } %>
                        </div>
                    </div>
                    <!-------LES ENTRETIENS-------->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-lg font-bold text-gray-800">Prochains Entretiens</h2>
                            <a href="${pageContext.request.contextPath}/entretiens" class="text-sm text-primary hover:underline">Voir tout</a>
                        </div>
                        <div class="space-y-4">
                            <%
                            if(upcomingEntretiens != null && !upcomingEntretiens.isEmpty()) {
                                for(Entretien e : upcomingEntretiens){
                            %>
                            <div class="flex items-start gap-4 p-4 bg-gray-50 rounded-lg">
                                <div class="w-12 h-12 rounded-lg bg-green-50 flex items-center justify-center flex-shrink-0">
                                    <span class="material-icons text-green-500">event</span>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-semibold text-gray-800">Entretien #<%=e.getId()%></h3>
                                    <p class="text-sm text-gray-600 mb-2">Candidature #<%=e.getCandidatureId()%></p>
                                    <div class="flex items-center gap-2 text-xs text-gray-500">
                                        <span class="material-icons text-xs">calender_today</span>
                                        <span><%= sdf.format(e.getDateHeure())%></span>
                                        <span class="material-icons text-xs ml-2">schedule</span>
                                        <span><%= timeFormat.format(e.getDateHeure())%></span>
                                    </div>
                                </div>
                            </div>
                            <% } } else {%>
                            <p class="text-center text-gray-500 py-8">Aucun entretien à venir</p>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>