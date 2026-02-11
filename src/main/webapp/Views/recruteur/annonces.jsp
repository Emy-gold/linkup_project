<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mes Annonces - Linkup Recruteur</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
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
                <jsp:param name="currentPage" value="annonces" />
            </jsp:include>

            <!-- Main Content -->
            <div class="flex-1 flex flex-col">
                <!-- Header -->
                <jsp:include page="layout/header.jsp">
                    <jsp:param name="pageTitle" value="Mes Annonces" />
                </jsp:include>

                <!-- Content -->
                <main class="flex-1 overflow-y-auto px-8 py-8">
                    <div class="mb-8 flex justify-between items-center">
                        <h2 class="text-2xl font-bold text-slate-900">Mes Annonces</h2>
                        <button onclick="openCreateModal()"
                            class="px-6 py-2 bg-primary hover:bg-primary-dark text-white rounded-lg font-medium transition-colors flex items-center gap-2 shadow-sm">
                            <i class="fas fa-plus"></i> Nouvelle Annonce
                        </button>
                    </div>

                    <!-- Annonces Table -->
                    <div class="bg-surface-light border border-slate-200 rounded-xl shadow-sm overflow-hidden">
                        <table class="w-full text-left border-collapse">
                            <thead class="bg-slate-50 border-b border-slate-200">
                                <tr>
                                    <th class="px-6 py-4 text-sm font-semibold text-slate-700">Titre & Description</th>
                                    <th class="px-6 py-4 text-sm font-semibold text-slate-700">Type</th>
                                    <th class="px-6 py-4 text-sm font-semibold text-slate-700">Date Pub.</th>
                                    <th class="px-6 py-4 text-sm font-semibold text-slate-700">Statut</th>
                                    <th class="px-6 py-4 text-sm font-semibold text-slate-700 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-200">
                                <c:choose>
                                    <c:when test="${not empty annonces}">
                                        <c:forEach var="a" items="${annonces}">
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-6 py-4 max-w-md">
                                                    <div class="font-bold text-slate-900 truncate">
                                                        <c:out value="${a.titre}" />
                                                    </div>
                                                    <div class="text-xs text-slate-500 truncate mt-1">
                                                        <c:out value="${a.description}" />
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <span
                                                        class="px-2 py-1 bg-blue-50 text-blue-700 text-xs font-bold rounded shadow-sm border border-blue-100">
                                                        <c:out value="${a.typeContrat}" />
                                                    </span>
                                                </td>
                                                <td class="px-6 py-4 text-sm text-slate-600">
                                                    <c:out value="${a.datePublication}" />
                                                </td>
                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${a.statutAnnonce == 'PUBLIEE'}">
                                                            <span
                                                                class="px-3 py-1 bg-green-100 text-green-700 text-xs font-bold rounded-full">Publiée</span>
                                                        </c:when>
                                                        <c:when test="${a.statutAnnonce == 'EN_ATTENTE'}">
                                                            <span
                                                                class="px-3 py-1 bg-yellow-100 text-yellow-700 text-xs font-bold rounded-full">En
                                                                Attente</span>
                                                        </c:when>
                                                        <c:when test="${a.statutAnnonce == 'REJETEE'}">
                                                            <span
                                                                class="px-3 py-1 bg-red-100 text-red-700 text-xs font-bold rounded-full">Rejetée</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="px-3 py-1 bg-slate-100 text-slate-700 text-xs font-bold rounded-full">
                                                                <c:out value="${a.statutAnnonce}" />
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4 text-right space-x-3">
                                                    <button data-id="${a.id}" data-titre="<c:out value='${a.titre}' />"
                                                        data-desc="<c:out value='${a.description}' />"
                                                        data-type="${a.typeContrat}" data-statut="${a.statutAnnonce}"
                                                        onclick="fillEditModal(this.getAttribute('data-id'), this.getAttribute('data-titre'), this.getAttribute('data-desc'), this.getAttribute('data-type'), this.getAttribute('data-statut'))"
                                                        class="text-blue-600 hover:text-blue-800 transition-colors">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button onclick="deleteAnnonce('${a.id}')"
                                                        class="text-red-600 hover:text-red-800 transition-colors">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="px-6 py-12 text-center text-slate-400 italic">
                                                Aucune annonce à afficher.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>

            <!-- Modal Nouvelle Annonce -->
            <div id="createModal"
                class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center p-4 hidden z-50">
                <div class="bg-white rounded-2xl shadow-2xl max-w-2xl w-full overflow-hidden">
                    <div class="px-6 py-4 bg-slate-50 border-b flex justify-between items-center">
                        <h2 class="text-xl font-bold text-slate-900">Nouvelle Annonce</h2>
                        <button onclick="closeCreateModal()"
                            class="text-slate-400 hover:text-slate-600 transition-colors">✕</button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/recruteur/annonces/"
                        class="p-6 space-y-5">
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Titre du Poste</label>
                            <input type="text" name="titre" required placeholder="Ex: Développeur Fullstack"
                                class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-primary/10 focus:border-primary outline-none transition-all">
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-bold text-slate-700 mb-2">Type de Contrat</label>
                                <select name="typeContrat"
                                    class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-primary/10 focus:border-primary outline-none transition-all">
                                    <option value="CDI">CDI</option>
                                    <option value="CDD">CDD</option>
                                    <option value="Stage">Stage</option>
                                    <option value="Freelance">Freelance</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-bold text-slate-700 mb-2">Statut Initial</label>
                                <select name="statutAnnonce"
                                    class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-primary/10 focus:border-primary outline-none transition-all">
                                    <option value="EN_ATTENTE">En Attente</option>
                                    <option value="PUBLIEE">Publiée</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Description</label>
                            <textarea name="descriptionPoste" rows="4" required placeholder="Détails du poste..."
                                class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-primary/10 focus:border-primary outline-none transition-all"></textarea>
                        </div>
                        <div class="flex gap-4 pt-4">
                            <button type="submit"
                                class="flex-1 bg-primary hover:bg-primary-dark text-white font-bold py-3 rounded-xl shadow-lg transition-all">Créer
                                l'annonce</button>
                            <button type="button" onclick="closeCreateModal()"
                                class="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-600 font-bold py-3 rounded-xl transition-all">Annuler</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Modal Modifier -->
            <div id="editModal"
                class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center p-4 hidden z-50">
                <div class="bg-white rounded-2xl shadow-2xl max-w-2xl w-full overflow-hidden">
                    <div class="px-6 py-4 bg-slate-50 border-b flex justify-between items-center">
                        <h2 class="text-xl font-bold text-slate-900">Modifier l'Annonce</h2>
                        <button onclick="closeEditModal()"
                            class="text-slate-400 hover:text-slate-600 transition-colors">✕</button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/recruteur/annonces/update"
                        class="p-6 space-y-5">
                        <input type="hidden" name="idAnnonce" id="editId">
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Titre du Poste</label>
                            <input type="text" name="titre" id="editTitre" required
                                class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all">
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-bold text-slate-700 mb-2">Type de Contrat</label>
                                <select name="typeContrat" id="editType"
                                    class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all">
                                    <option value="CDI">CDI</option>
                                    <option value="CDD">CDD</option>
                                    <option value="Stage">Stage</option>
                                    <option value="Freelance">Freelance</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-bold text-slate-700 mb-2">Statut</label>
                                <select name="statutAnnonce" id="editStatut"
                                    class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all">
                                    <option value="EN_ATTENTE">En Attente</option>
                                    <option value="PUBLIEE">Publiée</option>
                                    <option value="REJETEE">Rejetée</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Description</label>
                            <textarea name="description" id="editDescription" rows="4" required
                                class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all"></textarea>
                        </div>
                        <div class="flex gap-4 pt-4">
                            <button type="submit"
                                class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 rounded-xl shadow-lg transition-all">Enregistrer</button>
                            <button type="button" onclick="closeEditModal()"
                                class="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-600 font-bold py-3 rounded-xl transition-all">Annuler</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function openCreateModal() {
                    document.getElementById('createModal').classList.remove('hidden');
                }

                function closeCreateModal() {
                    document.getElementById('createModal').classList.add('hidden');
                }

                function fillEditModal(id, titre, desc, type, statut) {
                    document.getElementById('editId').value = id;
                    document.getElementById('editTitre').value = titre;
                    document.getElementById('editDescription').value = desc;
                    document.getElementById('editType').value = type;
                    document.getElementById('editStatut').value = statut;

                    document.getElementById('editModal').classList.remove('hidden');
                }

                function closeEditModal() {
                    document.getElementById('editModal').classList.add('hidden');
                }

                function deleteAnnonce(id) {
                    if (confirm('Supprimer définitivement cette annonce ?')) {
                        window.location.href = '${pageContext.request.contextPath}/recruteur/annonces/delete?id=' + id;
                    }
                }

                window.onclick = function (event) {
                    const createM = document.getElementById('createModal');
                    const editM = document.getElementById('editModal');
                    if (event.target === createM) closeCreateModal();
                    if (event.target === editM) closeEditModal();
                }
            </script>
        </body>

        </html>