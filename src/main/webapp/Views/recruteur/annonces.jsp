<%--
  Created by IntelliJ IDEA.
  User: Pro
  Date: 2/5/2026
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Annonces - Linkup Recruteur</title>
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
<!-- Sidebar -->
<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="currentPage" value="annonces"/>
</jsp:include>

<!-- Main Content -->
<div class="flex-1 flex flex-col">
    <!-- Header -->
    <jsp:include page="layout/header.jsp">
        <jsp:param name="pageTitle" value="Mes Annonces"/>
    </jsp:include>

    <!-- Content -->
    <main class="flex-1 overflow-y-auto px-8 py-8">
        <!-- Button Créer Annonce -->
        <div class="mb-8">
            <a href="#" onclick="openModal()" class="px-6 py-3 bg-primary hover:bg-primary-dark text-white rounded-lg font-medium transition-colors flex items-center gap-2 w-fit">
                <i class="fas fa-plus"></i> Créer une Nouvelle Annonce
            </a>
        </div>

        <!-- Annonces List -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:choose>
                <c:when test="${not empty annonces}">
                    <c:forEach var="annonce" items="${annonces}">
                        <!-- Annonce Card -->
                        <div class="bg-surface-light border border-slate-200 rounded-lg p-6 hover:shadow-md transition-shadow flex flex-col h-full">
                            <!-- Header -->
                            <div class="mb-4">
                                <h3 class="text-lg font-bold text-slate-900">${annonce.titre}</h3>
                            </div>

                            <!-- Tags -->
                            <div class="flex flex-wrap gap-2 mb-4">
                                    <span class="px-3 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">
                                            ${annonce.typeContrat}
                                    </span>
                                <span class="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-semibold rounded-full">
                                        ${annonce.localisation}
                                </span>
                            </div>

                            <!-- Description -->
                            <p class="text-sm text-slate-700 mb-4 flex-grow line-clamp-3">
                                    ${annonce.description}
                            </p>

                            <!-- Stats -->
                            <div class="grid grid-cols-2 gap-4 mb-4 pb-4 border-b border-slate-200">
                                <div>
                                    <p class="text-xs text-slate-600">Candidatures</p>
                                    <p class="text-lg font-bold text-slate-900">${annonce.candidatures}</p>
                                </div>
                                <div>
                                    <p class="text-xs text-slate-600">Vues</p>
                                    <p class="text-lg font-bold text-slate-900">${annonce.vues}</p>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="flex gap-2">
                                <button onclick="editAnnonce(${annonce.id})" class="flex-1 px-3 py-2 text-sm font-medium text-blue-700 bg-blue-50 hover:bg-blue-100 rounded-lg transition-colors">
                                    <i class="fas fa-edit mr-1"></i> Modifier
                                </button>
                                <button onclick="deleteAnnonce(${annonce.id})" class="flex-1 px-3 py-2 text-sm font-medium text-red-700 bg-red-50 hover:bg-red-100 rounded-lg transition-colors">
                                    <i class="fas fa-trash mr-1"></i> Supprimer
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="col-span-full flex flex-col items-center justify-center py-16 bg-surface-light border border-slate-200 rounded-lg">
                        <i class="fas fa-file-alt text-5xl text-slate-300 mb-4"></i>
                        <h3 class="text-xl font-bold text-slate-900 mb-2">Aucune annonce publiée</h3>
                        <p class="text-slate-600 mb-6">Commencez par créer votre première annonce</p>
                        <a href="#" onclick="openModal()" class="px-6 py-2 bg-primary text-white rounded-lg font-medium hover:bg-primary-dark transition-colors flex items-center gap-2">
                            <i class="fas fa-plus"></i> Créer une Annonce
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Footer -->
</div>

<!-- Modal Créer Annonce -->
<div id="createModal" class="fixed inset-0 bg-black/50 flex items-center justify-center p-4 hidden z-50">
    <div class="bg-surface-light rounded-lg shadow-xl max-w-2xl w-full max-h-screen overflow-y-auto">
        <div class="sticky top-0 bg-surface-light border-b border-slate-200 px-6 py-4 flex justify-between items-center">
            <h2 class="text-xl font-bold text-slate-900">Créer une Nouvelle Annonce</h2>
            <button onclick="closeModal()" class="text-slate-400 hover:text-slate-600">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>

        <form method="POST" action="${pageContext.request.contextPath}/recruteur/annonces" class="p-6 space-y-4">
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-2">Titre du Poste *</label>
                <input type="text" name="titre" required placeholder="Ex: Développeur Java Senior"
                       class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Type de Contrat *</label>
                    <select name="typeContrat" required
                            class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                        <option value="">Sélectionner</option>
                        <option value="CDI">CDI</option>
                        <option value="CDD">CDD</option>
                        <option value="Stage">Stage</option>
                        <option value="Freelance">Freelance</option>
                    </select>
                </div>

                <!-- Statut de l'Annonce -->
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Statut de l'Annonce *</label>
                    <select name="statutAnnonce" required
                            class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                        <option value="">Sélectionner</option>
                        <option value="En_Cours">En Cours</option>
                        <option value="Anule">Anulée</option>
                        <option value="Cloturee">Clôturée</option>
                    </select>
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700 mb-2">Description du Poste *</label>
                <textarea name="descriptionPoste" rows="5" required placeholder="Décrivez les responsabilités et compétences requises..."
                          class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none"></textarea>
            </div>

            <div class="flex gap-3 pt-4 border-t border-slate-200">
                <button type="submit" class="flex-1 px-4 py-2 bg-primary text-white font-medium rounded-lg hover:bg-primary-dark transition-colors">
                    <i class="fas fa-save mr-2"></i> Publier l'Annonce
                </button>
                <button type="button" onclick="closeModal()" class="flex-1 px-4 py-2 bg-slate-200 text-slate-700 font-medium rounded-lg hover:bg-slate-300 transition-colors">
                    Annuler
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal() {
        document.getElementById('createModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('createModal').classList.add('hidden');
    }

    function editAnnonce(annonceId) {
        window.location.href = '${pageContext.request.contextPath}/recruteur/annonces/edit?id=' + annonceId;
    }

    function deleteAnnonce(annonceId) {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette annonce?')) {
            window.location.href = '${pageContext.request.contextPath}/recruteur/annonces/delete?id=' + annonceId;
        }
    }

    // Fermer le modal en cliquant en dehors
    window.onclick = function(event) {
        const modal = document.getElementById('createModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>
</body>
</html>
