<%@ page import="Models.utilisateur" %>
<%@ page import="Controllers.candidat.EntretiensServlet.EntretienDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    utilisateur user = (utilisateur) session.getAttribute("user");

    // Validation d'utilisateur
    if(user == null || !"CANDIDAT".equals(user.getRole())){
        response.sendRedirect("../../login.jsp");
        return;
    }

    List<EntretienDetails> entretienDetails = (List<EntretienDetails>) request.getAttribute("entretienDetails");
    String currentFilter = (String) request.getAttribute("filter");

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd");
    SimpleDateFormat monthYearFormat = new SimpleDateFormat("MMM yyyy");

    int totalEntretiens = entretienDetails != null ? entretienDetails.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Entretiens - LinkUp</title>
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
                <a href="${pageContext.request.contextPath}/candidat/dashboard"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/candidat/annonces"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">work</span>
                    <span class="font-medium">Annonces</span>
                </a>
                <a href="${pageContext.request.contextPath}/candidat/candidatures"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">description</span>
                    <span class="font-medium">Mes Candidatures</span>
                </a>
                <a href="${pageContext.request.contextPath}/candidat/cv"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">article</span>
                    <span class="font-medium">Mon CV</span>
                </a>
                <a href="${pageContext.request.contextPath}/candidat/entretiens"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
                    <span class="material-icons">event</span>
                    <span class="font-medium">Entretiens</span>
                </a>
                <a href="${pageContext.request.contextPath}/candidat/profile"
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <span class="material-icons">person</span>
                    <span class="font-medium">Mon Profil</span>
                </a>
            </nav>
        </div>
        <div class="absolute bottom-0 w-64 p-6 border-t">
            <a href="${pageContext.request.contextPath}/logout"
               class="flex items-center gap-3 text-red-600 px-4 py-3 hover:bg-red-50 rounded-lg transition-colors">
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
                <h1 class="text-2xl font-bold text-gray-800">Mes Entretiens</h1>
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
            <!-- Success/Error Messages -->
            <% if(request.getParameter("success") != null) { %>
            <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg flex items-center gap-2">
                <span class="material-icons text-green-600">check_circle</span>
                <span>Opération effectuée avec succès !</span>
            </div>
            <% } %>

            <% if(request.getParameter("error") != null) { %>
            <div class="mb-6 bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg flex items-center gap-2">
                <span class="material-icons text-red-600">error</span>
                <span>Une erreur s'est produite. Veuillez réessayer.</span>
            </div>
            <% } %>

            <!-- Stats Card -->
            <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-600 mb-1">Total des entretiens</p>
                        <p class="text-3xl font-bold text-gray-800"><%= totalEntretiens %></p>
                    </div>
                    <div class="w-16 h-16 rounded-lg bg-primary/10 flex items-center justify-center">
                        <span class="material-icons text-primary text-4xl">event</span>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
                    <span class="material-icons text-primary">filter_list</span>
                    Filtrer les entretiens
                </h3>
                <div class="flex flex-wrap gap-3">
                    <a href="entretiens"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= (currentFilter == null || currentFilter.isEmpty()) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">list</span>
                                Tous
                            </span>
                    </a>
                    <a href="entretiens?filter=upcoming"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= "upcoming".equals(currentFilter) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">schedule</span>
                                À venir
                            </span>
                    </a>
                    <a href="entretiens?filter=past"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= "past".equals(currentFilter) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">history</span>
                                Passés
                            </span>
                    </a>
                    <a href="entretiens?filter=Planifié"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= "Planifié".equals(currentFilter) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">event_available</span>
                                Planifiés
                            </span>
                    </a>
                    <a href="entretiens?filter=Terminé"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= "Terminé".equals(currentFilter) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">check_circle</span>
                                Terminés
                            </span>
                    </a>
                    <a href="entretiens?filter=Annulé"
                       class="px-4 py-2 rounded-lg border-2 transition-all <%= "Annulé".equals(currentFilter) ? "bg-primary text-white border-primary" : "border-gray-300 text-gray-700 hover:border-primary hover:text-primary" %>">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm">cancel</span>
                                Annulés
                            </span>
                    </a>
                </div>
            </div>

            <!-- Entretiens List -->
            <%
                if(entretienDetails == null || entretienDetails.isEmpty()) {
            %>
            <!-- Empty State -->
            <div class="bg-white rounded-xl shadow-sm p-12 border border-gray-100 text-center">
                <div class="w-24 h-24 rounded-full bg-gray-100 flex items-center justify-center mx-auto mb-4">
                    <span class="material-icons text-gray-400" style="font-size: 48px;">event_busy</span>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Aucun entretien trouvé</h3>
                <p class="text-gray-600 mb-6">
                    <% if(currentFilter != null && !currentFilter.isEmpty()) { %>
                    Aucun entretien ne correspond à ce filtre.
                    <% } else { %>
                    Vous n'avez pas encore d'entretiens programmés.<br>
                    Continuez à postuler aux offres qui vous intéressent !
                    <% } %>
                </p>
                <a href="${pageContext.request.contextPath}/candidat/annonces"
                   class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors">
                    <span class="material-icons">search</span>
                    Voir les offres
                </a>
            </div>
            <%
            } else {
                Date now = new Date();
                for(EntretienDetails detail : entretienDetails) {
                    boolean isUpcoming = detail.getEntretien().getDateHeure().after(now);
                    String statutClass = "";
                    String statutIcon = "";
                    String borderColor = "";

                    switch(detail.getEntretien().getStatutEntretien()) {
                        case "Planifié":
                            statutClass = "bg-green-100 text-green-700";
                            statutIcon = "event_available";
                            borderColor = "border-l-green-500";
                            break;
                        case "Terminé":
                            statutClass = "bg-gray-100 text-gray-700";
                            statutIcon = "check_circle";
                            borderColor = "border-l-gray-400";
                            break;
                        case "Annulé":
                            statutClass = "bg-red-100 text-red-700";
                            statutIcon = "cancel";
                            borderColor = "border-l-red-500";
                            break;
                        default:
                            statutClass = "bg-blue-100 text-blue-700";
                            statutIcon = "info";
                            borderColor = "border-l-blue-500";
                    }
            %>
            <!-- Entretien Card -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 border-l-4 <%= borderColor %> mb-4 overflow-hidden hover:shadow-md transition-shadow">
                <div class="p-6">
                    <div class="flex gap-6">
                        <!-- Date/Time Box -->
                        <div class="flex-shrink-0">
                            <div class="w-24 h-24 rounded-lg bg-gradient-to-br from-primary to-primary-dark text-white flex flex-col items-center justify-center">
                                <div class="text-3xl font-bold"><%= dayFormat.format(detail.getEntretien().getDateHeure()) %></div>
                                <div class="text-xs uppercase"><%= monthYearFormat.format(detail.getEntretien().getDateHeure()) %></div>
                                <div class="text-sm mt-1 flex items-center gap-1">
                                    <span class="material-icons" style="font-size: 14px;">schedule</span>
                                    <%= timeFormat.format(detail.getEntretien().getDateHeure()) %>
                                </div>
                            </div>
                        </div>

                        <!-- Details -->
                        <div class="flex-1">
                            <div class="flex items-start justify-between mb-3">
                                <div>
                                    <h3 class="text-xl font-bold text-gray-800 mb-1">
                                        <% if(detail.getAnnonce() != null) { %>
                                        <%= detail.getAnnonce().getTitre() %>
                                        <% } else { %>
                                        Entretien #<%= detail.getEntretien().getId() %>
                                        <% } %>
                                    </h3>
                                    <% if(detail.getAnnonce() != null && detail.getAnnonce() != null) { %>
                                    <p class="text-gray-600 flex items-center gap-1">
                                        <span class="material-icons text-sm">business</span>
                                        <%= detail.getAnnonce() %>
                                    </p>
                                    <% } %>
                                </div>
                                <span class="px-4 py-2 <%= statutClass %> rounded-full text-sm font-medium flex items-center gap-1">
                                            <span class="material-icons text-sm"><%= statutIcon %></span>
                                            <%= detail.getEntretien().getStatutEntretien() %>
                                        </span>
                            </div>

                            <!-- Location -->
                            <div class="bg-gray-50 rounded-lg p-3 mb-3 flex items-center gap-2">
                                <span class="material-icons text-primary">place</span>
                                <span class="font-medium text-gray-700">Lieu:</span>
                                <span class="text-gray-600"><%= detail.getEntretien().getLieu() %></span>
                            </div>

                            <!-- Notes du recruteur -->
                            <% if(detail.getEntretien().getNotesRecruteur() != null && !detail.getEntretien().getNotesRecruteur().trim().isEmpty()) { %>
                            <div class="bg-yellow-50 border-l-4 border-yellow-500 rounded-lg p-3 mb-3">
                                <h4 class="font-semibold text-gray-800 mb-1 flex items-center gap-1">
                                    <span class="material-icons text-yellow-600 text-sm">sticky_note_2</span>
                                    Notes du recruteur:
                                </h4>
                                <p class="text-gray-700 text-sm"><%= detail.getEntretien().getNotesRecruteur() %></p>
                            </div>
                            <% } %>

                            <!-- Additional Info -->
                            <div class="flex items-center justify-between">
                                <div class="text-sm text-gray-500 flex items-center gap-1">
                                    <span class="material-icons text-sm">info</span>
                                    Candidature du <%= dateFormat.format(detail.getCandidature().getDateSoumission()) %>
                                </div>
                                <% if(isUpcoming && "Planifié".equals(detail.getEntretien().getStatutEntretien())) { %>
                                <button onclick="addToCalendar(<%= detail.getEntretien().getId() %>)"
                                        class="px-4 py-2 text-sm bg-primary/10 text-primary rounded-lg hover:bg-primary hover:text-white transition-colors flex items-center gap-1">
                                    <span class="material-icons text-sm">calendar_today</span>
                                    Ajouter au calendrier
                                </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </main>
</div>

<script>
    function addToCalendar(entretienId) {
        alert('Fonctionnalité à implémenter: Ajouter l\'entretien #' + entretienId + ' au calendrier');
        // TODO: Implement calendar integration (Google Calendar, iCal, etc.)
    }

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('[class*="bg-green-50"], [class*="bg-red-50"]');
        alerts.forEach(function(alert) {
            if(alert.textContent.includes('succès') || alert.textContent.includes('erreur')) {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            }
        });
    }, 5000);
</script>
</body>
</html>
