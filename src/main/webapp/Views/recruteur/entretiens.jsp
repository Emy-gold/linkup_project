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
<body class="bg-background-light text-slate-800 font-sans min-h-screen flex">
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


        <!-- Candidatures Table -->
        <div class="bg-surface-light border border-slate-200 rounded-lg overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Candidat</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Titre </th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Date/Heure</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Lieu</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Statut</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">

                    <c:choose>
                        <c:when test="${not empty entretiens}">
                            <c:forEach var="ent" items="${entretiens}">
                                <tr class="hover:bg-slate-50">

                                    <!-- CANDIDAT -->
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm">
                                                    ${ent.prenom.charAt(0)}${ent.nom.charAt(0)}
                                            </div>
                                            <div>
                                                <p class="font-medium text-slate-800">
                                                        ${ent.prenom} ${ent.nom}
                                                </p>
                                            </div>
                                        </div>
                                    </td>

                                    <td class="px-6 py-4 text-slate-600">
                                            ${ent.titreAnnonce}
                                    </td>

                                    <td class="px-6 py-4">
                                            ${ent.dateHeure}
                                    </td>

                                    <td class="px-6 py-4">
                                            ${ent.lieu}
                                    </td>

                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${ent.statutEntretien == 'Planifie'}">
                            <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs">
                                Planifié
                            </span>
                                            </c:when>
                                            <c:when test="${ent.statutEntretien == 'Termine'}">
                            <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs">
                                Terminé
                            </span>
                                            </c:when>
                                            <c:when test="${ent.statutEntretien == 'Annule'}">
                            <span class="px-3 py-1 bg-red-100 text-red-700 rounded-full text-xs">
                                Annulé
                            </span>
                                            </c:when>
                                        </c:choose>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center py-6 text-gray-500">
                                    Aucun entretien planifié
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





</body>
</html>
