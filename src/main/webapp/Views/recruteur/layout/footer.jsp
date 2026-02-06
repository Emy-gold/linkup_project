<%--
  Created by IntelliJ IDEA.
  User: Pro
  Date: 2/5/2026
  Time: 5:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<!-- Footer -->
<footer class="bg-surface-light border-t border-slate-200 py-4">
    <div class="max-w-8xl mx-auto px-8 text-center text-sm text-slate-600">
        <p>&copy; 2024 Linkup. Tous les droits réservés.</p>
    </div>
</footer>
</html>




<main class="flex-grow relative px-4 py-8">
    <div class="absolute top-0 left-0 w-full h-full overflow-hidden -z-10 pointer-events-none">
        <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-primary/5 w-[80%] h-[80%] rounded-full blur-3xl"></div>
    </div>

    <!-- Conteneur Max Width pour centrer le contenu -->
    <div class="max-w-7xl mx-auto w-full space-y-8">

        <!-- En-tête -->
        <div class="flex justify-between items-end">
            <div>
                <h1 class="text-3xl font-bold text-slate-900">Tableau de Bord</h1>
                <p class="text-slate-500 mt-1">Bienvenue, <%--<c:out value="${recruteurName}"/>--%>Founti</p>
            </div>
            <button class="bg-primary hover:bg-primary-dark text-white px-6 py-2.5 rounded-lg shadow transition-colors flex items-center gap-2">
                <span class="material-icons text-sm">add</span> Publier une Annonce
            </button>
        </div>

        <!-- (Grid System Tailwind) -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Card 1 -->
            <div class="bg-surface-light rounded-xl shadow-sm border border-slate-100 p-6 flex items-center gap-4">
                <div class="p-3 bg-blue-100 text-blue-600 rounded-lg">
                    <span class="material-icons">work</span>
                </div>
                <div>
                    <p class="text-sm font-medium text-slate-500">Offres Actives</p>
                    <p class="text-2xl font-bold text-slate-800"><%--<c:out value="${totalOffres}"/>--%>2</p>
                </div>
            </div>
            <!-- Card 2 -->
            <div class="bg-surface-light rounded-xl shadow-sm border border-slate-100 p-6 flex items-center gap-4">
                <div class="p-3 bg-green-100 text-green-600 rounded-lg">
                    <span class="material-icons">people</span>
                </div>
                <div>
                    <p class="text-sm font-medium text-slate-500">Candidats</p>
                    <p class="text-2xl font-bold text-slate-800"><%--<c:out value="${totalCandidats}"/>--%>3</p>
                </div>
            </div>
            <!-- Card 3 -->
            <div class="bg-surface-light rounded-xl shadow-sm border border-slate-100 p-6 flex items-center gap-4">
                <div class="p-3 bg-purple-100 text-purple-600 rounded-lg">
                    <span class="material-icons">mark_email_read</span>
                </div>
                <div>
                    <p class="text-sm font-medium text-slate-500">Candidatures</p>
                    <p class="text-2xl font-bold text-slate-800"><%--<c:out value="${totalCandidatures}"/>--%>5</p>
                </div>
            </div>
        </div>


    </div>
</main>



