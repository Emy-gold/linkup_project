<%--
  Created by IntelliJ IDEA.
  User: Pro
  Date: 2/5/2026
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidatures Reçues - Linkup Recruteur</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#3ea721",
                        "primary-dark": "#2e8018",
                        "background-light": "#f8fafc",
                        "surface-light": "#ffffff",
                    },
                    fontFamily: {
                        sans: ["Inter", "sans-serif"],
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-background-light text-slata-800 font-sans min-h-screen flex">
    <!--SideBar -->
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="currentPage" value="candidatues"/>
    </jsp:include>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col">
        <!-- Header -->
        <jsp:include page="layout/header.jsp">
            <jsp:param name="pageTitle" value="Candidatures Reçues"/>
        </jsp:include>

        <!-- Content -->
        <main class="flex-1 overflow-y-auto px-8 py-8">
            <!-- Filtres -->
            <div class="mb-8 flex gap-4">
                <select class="px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none bg-surface-light">
                    <option>Tous les statuts</option>
                    <option>En attente</option>
                    <option>Acceptée</option>
                    <option>Rejetée</option>
                </select>
                <input type="text" placeholder="Rechercher..." class="px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none bg-surface-light flex-1">
            </div>


            <!-- Candidatures Table -->
            <div class="bg-surface-light border border-slate-200 rounded-lg overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-slate-50 border-b border-slate-200">
                        <tr>
                            <th class="px-6 py-4 text-left font-semibold text-slate-700">Candidat</th>
                            <th class="px-6 py-4 text-left font-semibold text-slate-700">Poste</th>
                            <th class="px-6 py-4 text-left font-semibold text-slate-700">Date</th>
                            <th class="px-6 py-4 text-left font-semibold text-slate-700">Statut</th>
                            <th class="px-6 py-4 text-left font-semibold text-slate-700">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200">
                        <c:choose>
                            <c:when test="${not empty candidatures}">
                                <c:forEach var="cand" items="${candidatures}">
                                    <tr class="hover:bg-slate-50 transition-colors">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm">
                                                        ${cand.nomCandidat.charAt(0)}
                                                </div>
                                                <div>
                                                    <p class="font-medium text-slate-900">${cand.nomCandidat}</p>
                                                    <p class="text-xs text-slate-600">${cand.emailCandidat}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-slate-600">${cand.poste}</td>
                                        <td class="px-6 py-4 text-slate-600">${cand.date}</td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${cand.statut == 'En attente'}">
                                                    <span class="px-3 py-1 bg-yellow-100 text-yellow-700 text-xs font-semibold rounded-full">En attente</span>
                                                </c:when>
                                                <c:when test="${cand.statut == 'Acceptée'}">
                                                    <span class="px-3 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">Acceptée</span>
                                                </c:when>
                                                <c:when test="${cand.statut == 'Rejetée'}">
                                                    <span class="px-3 py-1 bg-red-100 text-red-700 text-xs font-semibold rounded-full">Rejetée</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex gap-2">
                                                <button onclick="viewCandidat(${cand.id})" class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <c:if test="${cand.statut == 'En attente'}">
                                                    <button onclick="acceptCandidature(${cand.id})" class="p-2 text-green-600 hover:bg-green-50 rounded-lg transition-colors">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                    <button onclick="rejectCandidature(${cand.id})" class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center">
                                        <i class="fas fa-inbox text-5xl text-slate-300 mb-3 block"></i>
                                        <p class="text-slate-600 font-medium">Aucune candidature reçue</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>




        </main>
        <!-- Footer -->
        <jsp:include page="layout/footer.jsp"/>
    </div>



<%--    <script>--%>
<%--        function viewCandidat(candidId) {--%>
<%--            window.location.href = '${pageContext.request.contextPath}/recruteur/candidat/' + candidId;--%>
<%--        }--%>

<%--        function acceptCandidature(candidatId) {--%>
<%--            if (confirm('Accepter cette candidature?')) {--%>
<%--                window.location.href = '${pageContext.request.contextPath}/recruteur/candidatures/accept?id=' + candidatId;--%>
<%--            }--%>
<%--        }--%>

<%--        function rejectCandidature(candidatId) {--%>
<%--            if (confirm('Rejeter cette candidature?')) {--%>
<%--                window.location.href = '${pageContext.request.contextPath}/recruteur/candidatures/reject?id=' + candidatId;--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>

</body>
</html>
