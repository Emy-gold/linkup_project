<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>Admin Dashboard - Linkup</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
            <script>
                tailwind.config = {
                    theme: {
                        extend: {
                            colors: {
                                verdant: '#2E7D32',
                                'verdant-light': '#4CAF50',
                                'verdant-dark': '#1B5E20',
                            }
                        }
                    }
                }
            </script>
            <style>
                @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap');

                :root {
                    --verdant: #2E7D32;
                    --verdant-light: #4CAF50;
                    --verdant-dark: #1B5E20;
                    --cream: #F5F5DC;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background-color: #f8fafc;
                }

                .sidebar-bg {
                    background: #ffffff;
                }

                .active-tab {
                    background-color: #f0fdf4;
                    /* bg-emerald-50 */
                    border-left: 4px solid #059669;
                    /* border-emerald-600 */
                    color: #065f46;
                    /* text-emerald-900 or similar */
                }

                .sticky-sidebar {
                    position: sticky;
                    top: 0;
                    height: 100vh;
                }

                /* Toast Animation */
                @keyframes slideInRight {
                    from {
                        transform: translateX(100%);
                        opacity: 0;
                    }

                    to {
                        transform: translateX(0);
                        opacity: 1;
                    }
                }

                @keyframes fadeOut {
                    from {
                        opacity: 1;
                    }

                    to {
                        opacity: 0;
                    }
                }

                .toast-animation {
                    animation: slideInRight 0.5s ease forwards;
                }

                .toast-fadeout {
                    animation: fadeOut 0.8s ease forwards;
                }

                /* Tooltip for icon info */
                .tooltip-trigger:hover .tooltip-content {
                    display: block;
                }

                .tooltip-content {
                    display: none;
                }

                /* Modal Styles */
                .modal-toggle:checked+.modal-overlay {
                    display: flex;
                }

                .modal-overlay {
                    display: none;
                }
            </style>
        </head>

        <body class="bg-gray-50 min-h-screen">
            <div class="flex">
                <!-- Sidebar -->
                <aside class="w-64 bg-white border-r border-gray-200 text-gray-900 flex flex-col sticky-sidebar z-50">
                    <div class="p-8 flex items-center justify-center border-b border-gray-100">
                        <img src="${pageContext.request.contextPath}/assets/logo.png" class="h-16 w-auto" alt="linkup">
                    </div>

                    <nav class="flex-grow py-6 px-4 space-y-2">
                        <a href="${pageContext.request.contextPath}/admin/dashboard?tab=dashboard"
                            class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all hover:bg-gray-50 ${activeTab == 'dashboard' ? 'active-tab' : 'text-gray-600'}">
                            <span
                                class="material-icons ${activeTab == 'dashboard' ? 'text-emerald-600' : 'opacity-50'}">dashboard</span>
                            <span class="font-medium">Dashboard</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard?tab=users"
                            class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all hover:bg-gray-50 ${activeTab == 'users' ? 'active-tab' : 'text-gray-600'}">
                            <span
                                class="material-icons ${activeTab == 'users' ? 'text-emerald-600' : 'opacity-50'}">people</span>
                            <span class="font-medium">Gestion Utilisateurs</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard?tab=entities"
                            class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all hover:bg-gray-50 ${activeTab == 'entities' ? 'active-tab' : 'text-gray-600'}">
                            <span
                                class="material-icons ${activeTab == 'entities' ? 'text-emerald-600' : 'opacity-50'}">domain</span>
                            <span class="font-medium">Gestion Structures</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard?tab=annonces"
                            class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all hover:bg-gray-50 ${activeTab == 'annonces' ? 'active-tab' : 'text-gray-600'}">
                            <span
                                class="material-icons ${activeTab == 'annonces' ? 'text-emerald-600' : 'opacity-50'}">campaign</span>
                            <span class="font-medium">Modération Annonces</span>
                        </a>

                    </nav>

                    <div class="p-6 border-t border-gray-100 mt-auto">
                        <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center justify-center gap-3 px-4 py-2 rounded-lg border border-red-600 text-red-600 hover:bg-red-600 hover:text-white transition-all font-bold">
                            <span class="material-icons text-sm">logout</span>
                            <span>Déconnexion</span>
                        </a>
                    </div>
                </aside>

                <!-- Main Content -->
                <main class="flex-grow p-10 overflow-y-auto">

                    <!-- HEADER IN CONTENT -->
                    <div class="flex justify-between items-center mb-10 pb-6 border-b border-verdant/20">
                        <div>
                            <h1 class="text-3xl font-bold text-verdant flex items-center gap-3">
                                <span class="material-icons text-4xl">admin_panel_settings</span>
                                <c:choose>
                                    <c:when test="${activeTab == 'dashboard'}">Dashboard Global</c:when>
                                    <c:when test="${activeTab == 'users'}">Gestion des Utilisateurs</c:when>
                                    <c:when test="${activeTab == 'entities'}">Gestion des Structures</c:when>
                                    <c:when test="${activeTab == 'annonces'}">Modération des Annonces</c:when>

                                </c:choose>
                            </h1>

                        </div>
                        <div class="flex items-center gap-4">
                            <img src="${pageContext.request.contextPath}/assets/admin.png" class="h-12 w-auto"
                                alt="Admin">
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${activeTab == 'dashboard'}">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
                                <!-- Card 1: Total Utilisateurs -->
                                <div
                                    class="bg-white p-6 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md hover:scale-[1.02] transition-all group">
                                    <div
                                        class="w-12 h-12 bg-blue-50 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-blue-600 transition-colors">
                                        <i class="fas fa-users text-xl text-blue-600 group-hover:text-white"></i>
                                    </div>
                                    <h4 class="text-slate-400 font-bold text-xs uppercase tracking-wider mb-1">Total des
                                        Utilisateurs</h4>
                                    <p class="text-3xl font-black text-slate-800">${totalUsers}</p>
                                </div>

                                <!-- Card 2: Total Entreprises -->
                                <div
                                    class="bg-white p-6 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md hover:scale-[1.02] transition-all group">
                                    <div
                                        class="w-12 h-12 bg-emerald-50 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-emerald-600 transition-colors">
                                        <i class="fas fa-building text-xl text-emerald-600 group-hover:text-white"></i>
                                    </div>
                                    <h4 class="text-slate-400 font-bold text-xs uppercase tracking-wider mb-1">Total des
                                        Entreprises</h4>
                                    <p class="text-3xl font-black text-slate-800">${totalCompanies}</p>
                                </div>

                                <!-- Card 3: Total Universités -->
                                <div
                                    class="bg-white p-6 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md hover:scale-[1.02] transition-all group">
                                    <div
                                        class="w-12 h-12 bg-indigo-50 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-indigo-600 transition-colors">
                                        <i
                                            class="fas fa-graduation-cap text-xl text-indigo-600 group-hover:text-white"></i>
                                    </div>
                                    <h4 class="text-slate-400 font-bold text-xs uppercase tracking-wider mb-1">Total des
                                        Universités</h4>
                                    <p class="text-3xl font-black text-slate-800">${totalUniversities}</p>
                                </div>

                                <!-- Card 4: Total Annonces -->
                                <div
                                    class="bg-white p-6 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md hover:scale-[1.02] transition-all group">
                                    <div
                                        class="w-12 h-12 bg-amber-50 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-amber-600 transition-colors">
                                        <i class="fas fa-briefcase text-xl text-amber-600 group-hover:text-white"></i>
                                    </div>
                                    <h4 class="text-slate-400 font-bold text-xs uppercase tracking-wider mb-1">Total des
                                        Annonces</h4>
                                    <p class="text-3xl font-black text-slate-800">${totalAnnonces}</p>
                                </div>
                            </div>

                        </c:when>

                        <c:when test="${activeTab == 'users'}">
                            <!-- Filters and Search -->
                            <div
                                class="bg-white p-6 rounded-3xl shadow-md mb-8 flex flex-col md:flex-row gap-4 items-center justify-between border border-verdant/5">
                                <div class="flex flex-1 gap-4 w-full">
                                    <div class="relative flex-1">
                                        <span
                                            class="material-icons absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                        <input type="text" id="userSearch" placeholder="Rechercher par nom ou email..."
                                            class="w-full pl-12 pr-4 py-3 bg-slate-50 border-none rounded-2xl focus:ring-2 focus:ring-verdant transition-all">
                                    </div>
                                    <div class="relative">
                                        <span
                                            class="material-icons absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">filter_list</span>
                                        <select id="roleFilter"
                                            class="pl-12 pr-8 py-3 bg-slate-50 border-none rounded-2xl focus:ring-2 focus:ring-verdant transition-all appearance-none cursor-pointer">
                                            <option value="ALL">Tous les rôles</option>
                                            <option value="CANDIDAT">Candidats</option>
                                            <option value="RECRUTEUR">Recruteurs</option>
                                            <option value="AGENT_UNIV">Universités</option>
                                            <option value="ADMIN">Admins</option>
                                        </select>
                                    </div>
                                </div>

                            </div>

                            <div class="bg-white rounded-3xl shadow-xl overflow-hidden border border-slate-100">
                                <table class="w-full text-left" id="usersTable">
                                    <thead
                                        class="bg-slate-50 text-slate-400 text-xs font-black uppercase tracking-widest">
                                        <tr>
                                            <th class="px-8 py-5">Utilisateur</th>
                                            <th class="px-8 py-5">Rôle</th>
                                            <th class="px-8 py-5">Statut</th>
                                            <th class="px-8 py-5">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100 italic font-medium">
                                        <c:forEach var="u" items="${users}">
                                            <tr class="user-row hover:bg-slate-50/50 transition-all"
                                                data-role="${u.role}" data-search="${u.nom} ${u.prenom} ${u.email}">
                                                <td class="px-8 py-6 font-bold text-slate-800">${u.nom} ${u.prenom}
                                                </td>
                                                <td class="px-8 py-6">
                                                    <span class="px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-tighter shadow-sm
                                                        ${u.role == 'ADMIN' ? 'bg-purple-600 text-white' : 
                                                          u.role == 'RECRUTEUR' ? 'bg-blue-600 text-white' : 
                                                          'bg-verdant text-white'}">
                                                        ${u.role}
                                                    </span>
                                                </td>
                                                <td
                                                    class="px-8 py-6 font-black text-xs ${u.statutCompte == 'ACTIF' ? 'text-emerald-500' : 'text-rose-500'}">
                                                    ${u.statutCompte}
                                                </td>
                                                <td class="px-8 py-6 text-center">
                                                    <c:if test="${u.role != 'ADMIN'}">
                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/dashboard"
                                                            method="POST">
                                                            <input type="hidden" name="id" value="${u.idUtilisateur}">
                                                            <input type="hidden" name="tab" value="users">
                                                            <c:choose>
                                                                <c:when test="${u.statutCompte == 'ACTIF'}">
                                                                    <input type="hidden" name="action" value="suspend">
                                                                    <button type="submit"
                                                                        class="text-rose-600 hover:bg-rose-600 hover:text-white px-4 py-2 rounded-xl text-xs font-bold border border-rose-200 transition-all shadow-sm">Suspendre</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input type="hidden" name="action" value="activate">
                                                                    <button type="submit"
                                                                        class="text-emerald-600 hover:bg-emerald-600 hover:text-white px-4 py-2 rounded-xl text-xs font-bold border border-emerald-200 transition-all shadow-sm">Activer</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>

                        <c:when test="${activeTab == 'entities'}">
                            <div class="bg-white rounded-3xl shadow-xl overflow-hidden border border-slate-100">
                                <table class="w-full text-left">
                                    <thead
                                        class="bg-slate-50 text-slate-400 text-xs font-black uppercase tracking-widest">
                                        <tr>
                                            <th class="px-8 py-5">Structure</th>
                                            <th class="px-8 py-5">Type</th>
                                            <th class="px-8 py-5 text-center">Statut</th>
                                            <th class="px-8 py-5 text-center">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100 font-medium">
                                        <c:forEach var="e" items="${allEntities}">
                                            <tr class="hover:bg-slate-50/50 transition-all">
                                                <td class="px-8 py-6">
                                                    <div class="flex flex-col">
                                                        <span
                                                            class="font-bold text-slate-800 text-lg leading-tight">${e.nomEntite}</span>
                                                        <span class="text-xs text-slate-400 flex items-center gap-1">
                                                            <span class="material-icons text-xs">email</span> ${e.email}
                                                        </span>
                                                    </div>
                                                </td>
                                                <td class="px-8 py-6">
                                                    <span
                                                        class="px-3 py-1 bg-verdant/5 text-verdant-dark rounded-md text-[10px] font-black uppercase tracking-widest border border-verdant/10">
                                                        ${e.role == 'RECRUTEUR' ? 'Recruteur' : 'Université'}
                                                    </span>
                                                </td>
                                                <td class="px-8 py-6 text-center">
                                                    <c:choose>
                                                        <c:when test="${e.statutCompte == 'ACTIF'}">
                                                            <span
                                                                class="px-3 py-1 bg-emerald-100 text-emerald-700 rounded-full text-[10px] font-black uppercase tracking-widest">Actif</span>
                                                        </c:when>
                                                        <c:when test="${e.statutCompte == 'BLOQUÉ'}">
                                                            <span
                                                                class="px-3 py-1 bg-rose-100 text-rose-700 rounded-full text-[10px] font-black uppercase tracking-widest">Bloqué</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="px-3 py-1 bg-amber-100 text-amber-700 rounded-full text-[10px] font-black uppercase tracking-widest">En
                                                                Attente</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-8 py-6">
                                                    <div class="flex items-center justify-center gap-2">
                                                        <!-- Detail Action -->
                                                        <label for="modal-detail-${e.idUtilisateur}"
                                                            class="p-2 bg-slate-100 text-slate-400 hover:text-verdant hover:bg-verdant/10 rounded-xl transition-all cursor-pointer group"
                                                            title="Détails">
                                                            <span
                                                                class="material-icons text-xl group-hover:scale-110 transition-transform">visibility</span>
                                                        </label>

                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/dashboard"
                                                            method="POST" class="m-0 flex gap-2">
                                                            <input type="hidden" name="id" value="${e.idUtilisateur}">
                                                            <input type="hidden" name="tab" value="entities">

                                                            <c:choose>
                                                                <c:when test="${e.statutCompte == 'EN_ATTENTE'}">
                                                                    <button type="submit" name="action"
                                                                        value="activate_entity"
                                                                        class="p-2 bg-emerald-50 text-emerald-600 hover:bg-emerald-600 hover:text-white rounded-xl transition-all flex items-center gap-1 px-3"
                                                                        title="Valider">
                                                                        <span
                                                                            class="material-icons text-xl">check</span>
                                                                        <span
                                                                            class="text-[10px] font-black uppercase">Valider</span>
                                                                    </button>
                                                                    <button type="submit" name="action" value="reject"
                                                                        class="p-2 bg-rose-50 text-rose-600 hover:bg-rose-600 hover:text-white rounded-xl transition-all"
                                                                        title="Rejeter">
                                                                        <span
                                                                            class="material-icons text-xl">close</span>
                                                                    </button>
                                                                </c:when>

                                                                <c:when test="${e.statutCompte == 'ACTIF'}">
                                                                    <label for="modal-confirm-block-${e.idUtilisateur}"
                                                                        class="p-2 bg-amber-50 text-amber-600 hover:bg-amber-600 hover:text-white rounded-xl transition-all flex items-center gap-1 px-3 cursor-pointer group"
                                                                        title="Bloquer">
                                                                        <span
                                                                            class="material-icons text-xl group-hover:animate-bounce">block</span>
                                                                        <span
                                                                            class="text-[10px] font-black uppercase">Bloquer</span>
                                                                    </label>
                                                                </c:when>

                                                                <c:when test="${e.statutCompte == 'BLOQUÉ'}">
                                                                    <button type="submit" name="action"
                                                                        value="activate_entity"
                                                                        class="p-2 bg-indigo-50 text-indigo-600 hover:bg-indigo-600 hover:text-white rounded-xl transition-all flex items-center gap-1 px-3"
                                                                        title="Réactiver">
                                                                        <span
                                                                            class="material-icons text-xl">restart_alt</span>
                                                                        <span
                                                                            class="text-[10px] font-black uppercase">Réactiver</span>
                                                                    </button>
                                                                </c:when>
                                                            </c:choose>
                                                        </form>
                                                    </div>

                                                    <!-- Detail Modal -->
                                                    <input type="checkbox" id="modal-detail-${e.idUtilisateur}"
                                                        class="modal-toggle hidden">
                                                    <div
                                                        class="modal-overlay fixed inset-0 z-[110] bg-slate-900/60 backdrop-blur-sm items-center justify-center p-4">
                                                        <div
                                                            class="bg-white max-w-lg w-full rounded-3xl shadow-2xl overflow-hidden text-left">
                                                            <div
                                                                class="bg-verdant p-8 text-white flex justify-between items-center">
                                                                <div>
                                                                    <h3 class="text-2xl font-black">${e.nomEntite}</h3>
                                                                    <span
                                                                        class="text-white/70 font-bold uppercase text-[10px] tracking-widest">${e.role}</span>
                                                                </div>
                                                                <label for="modal-detail-${e.idUtilisateur}"
                                                                    class="cursor-pointer hover:rotate-90 transition-transform">
                                                                    <span class="material-icons text-3xl">close</span>
                                                                </label>
                                                            </div>
                                                            <div class="p-8 space-y-6">
                                                                <div class="grid grid-cols-2 gap-4">
                                                                    <div>
                                                                        <p
                                                                            class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">
                                                                            Responsable</p>
                                                                        <p class="text-slate-800 font-bold">${e.nom}
                                                                            ${e.prenom}</p>
                                                                    </div>
                                                                    <div>
                                                                        <p
                                                                            class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">
                                                                            Email</p>
                                                                        <p class="text-slate-800 font-bold">${e.email}
                                                                        </p>
                                                                    </div>
                                                                </div>

                                                                <div class="pt-6 border-t border-slate-100">
                                                                    <c:choose>
                                                                        <c:when test="${e.role == 'RECRUTEUR'}">
                                                                            <p
                                                                                class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2">
                                                                                Secteur d'activité</p>
                                                                            <p class="text-slate-600 leading-relaxed">
                                                                                ${e.secteurActivite}</p>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <p
                                                                                class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2">
                                                                                Localisation</p>
                                                                            <div
                                                                                class="flex items-start gap-2 text-slate-600">
                                                                                <span
                                                                                    class="material-icons text-sm mt-1">location_on</span>
                                                                                <p class="leading-relaxed">${e.adresse}
                                                                                </p>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>

                                                                <div
                                                                    class="pt-6 border-t border-slate-100 flex items-center justify-between">
                                                                    <div class="flex items-center gap-2">
                                                                        <span
                                                                            class="material-icons text-slate-400">calendar_today</span>
                                                                        <span
                                                                            class="text-xs text-slate-500 italic">Inscrit
                                                                            le ${e.date}</span>
                                                                    </div>
                                                                    <div class="flex items-center gap-2">
                                                                        <span
                                                                            class="material-icons text-slate-400">phone</span>
                                                                        <span
                                                                            class="text-slate-800 font-bold">${e.telephone
                                                                            != null ? e.telephone : 'Non
                                                                            renseigné'}</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Block Confirmation Modal -->
                                                    <input type="checkbox" id="modal-confirm-block-${e.idUtilisateur}"
                                                        class="modal-toggle hidden">
                                                    <div
                                                        class="modal-overlay fixed inset-0 z-[120] bg-slate-900/60 backdrop-blur-sm items-center justify-center p-4">
                                                        <div
                                                            class="bg-white max-w-sm w-full rounded-2xl shadow-2xl p-8 text-center">
                                                            <div
                                                                class="w-16 h-16 bg-rose-50 text-rose-600 rounded-full flex items-center justify-center mx-auto mb-4">
                                                                <span class="material-icons text-3xl">warning</span>
                                                            </div>
                                                            <h3 class="text-xl font-bold mb-2 text-slate-800">Bloquer la
                                                                structure ?</h3>
                                                            <p class="text-slate-500 text-sm mb-8">
                                                                Cette action est réversible, mais si c'est un recruteur,
                                                                <strong>toutes ses annonces seront immédiatement
                                                                    retirées</strong> de la visibilité des candidats.
                                                            </p>
                                                            <div class="flex gap-4">
                                                                <label for="modal-confirm-block-${e.idUtilisateur}"
                                                                    class="flex-1 px-4 py-3 rounded-xl border border-slate-200 font-bold text-sm cursor-pointer hover:bg-slate-50 text-slate-600">Annuler</label>
                                                                <form
                                                                    action="${pageContext.request.contextPath}/admin/dashboard"
                                                                    method="POST" class="flex-1">
                                                                    <input type="hidden" name="id"
                                                                        value="${e.idUtilisateur}">
                                                                    <input type="hidden" name="action"
                                                                        value="block_entity">
                                                                    <input type="hidden" name="tab" value="entities">
                                                                    <button type="submit"
                                                                        class="w-full bg-rose-600 text-white px-4 py-3 rounded-xl font-bold text-sm hover:bg-rose-700 shadow-lg shadow-rose-600/20 transition-all">Bloquer</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${empty allEntities}">
                                <div
                                    class="py-20 text-center bg-white rounded-3xl border-2 border-dashed border-verdant/20 italic text-slate-400">
                                    Aucune entité n'a été trouvée dans le système.
                                </div>
                            </c:if>
                        </c:when>

                        <c:when test="${activeTab == 'annonces'}">
                            <div class="bg-white rounded-2xl shadow-xl overflow-hidden border border-verdant/10">
                                <div class="overflow-x-auto">
                                    <table class="w-full text-left">
                                        <thead>
                                            <tr
                                                class="bg-verdant text-white uppercase text-xs font-bold tracking-widest">
                                                <th class="px-6 py-5">Titre</th>
                                                <th class="px-6 py-5">Recruteur</th>
                                                <th class="px-6 py-5">Date Publication</th>
                                                <th class="px-6 py-5">Statut</th>
                                                <th class="px-6 py-5 text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-verdant/10">
                                            <c:forEach var="a" items="${allAnnonces}">
                                                <tr class="hover:bg-verdant/5 transition-colors">
                                                    <td class="px-6 py-6 font-bold text-slate-800">
                                                        ${a.titre}</td>
                                                    <td class="px-6 py-6 text-slate-500 font-medium">
                                                        <span class="flex items-center gap-2">
                                                            <span
                                                                class="material-icons text-sm opacity-50">business</span>
                                                            ${a.entreprise}
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-6 italic text-sm text-slate-400">
                                                        ${a.date_publication}
                                                    </td>
                                                    <td class="px-6 py-6">
                                                        <c:choose>
                                                            <c:when test="${a.statut_annonce == 'PUBLIEE'}">
                                                                <span
                                                                    class="px-3 py-1 bg-emerald-100 text-emerald-700 rounded-full text-[10px] font-black uppercase tracking-widest shadow-sm">Publiée</span>
                                                            </c:when>
                                                            <c:when test="${a.statut_annonce == 'BLOQUÉE'}">
                                                                <span
                                                                    class="px-3 py-1 bg-slate-900 text-rose-100 rounded-full text-[10px] font-black uppercase tracking-widest shadow-lg flex items-center gap-1 w-fit">
                                                                    <span
                                                                        class="material-icons text-[12px]">block</span>
                                                                    Bloquée
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="px-3 py-1 bg-amber-100 text-amber-700 rounded-full text-[10px] font-black uppercase tracking-widest">En
                                                                    Attente</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="px-6 py-6 whitespace-nowrap text-right">
                                                        <div class="flex justify-end items-center gap-3">
                                                            <!-- Visibility Icon (Détails) -->
                                                            <label for="modal-${a.id}"
                                                                class="p-2 bg-slate-50 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-xl transition-all cursor-pointer border border-slate-100 group"
                                                                title="Voir les détails">
                                                                <span
                                                                    class="material-icons text-xl group-hover:scale-110 transition-transform">visibility</span>
                                                            </label>

                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/dashboard"
                                                                method="POST" class="m-0">
                                                                <input type="hidden" name="id" value="${a.id}">
                                                                <input type="hidden" name="tab" value="annonces">

                                                                <c:choose>
                                                                    <c:when test="${a.statut_annonce != 'BLOQUÉE'}">
                                                                        <input type="hidden" name="action"
                                                                            value="block_ad">
                                                                        <button type="submit"
                                                                            class="inline-flex items-center gap-2 w-fit whitespace-nowrap px-3 py-1.5 text-xs font-bold border border-red-600 text-red-600 hover:bg-red-600 hover:text-white rounded-xl transition-all group"
                                                                            title="Bloquer l'annonce">
                                                                            <i
                                                                                class="fas fa-ban group-hover:rotate-12 transition-transform"></i>
                                                                            <span>Bloquer</span>
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="hidden" name="action"
                                                                            value="unblock_ad">
                                                                        <button type="submit"
                                                                            class="inline-flex items-center gap-2 w-fit whitespace-nowrap px-3 py-1.5 text-xs font-bold border border-emerald-600 text-emerald-600 hover:bg-emerald-600 hover:text-white rounded-xl transition-all group"
                                                                            title="Débloquer l'annonce">
                                                                            <i class="fas fa-shield-alt"></i>
                                                                            <span>Débloquer</span>
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </form>
                                                        </div>

                                                        <!-- PURE CSS MODAL -->
                                                        <input type="checkbox" id="modal-${a.id}"
                                                            class="modal-toggle hidden">
                                                        <div
                                                            class="modal-overlay fixed inset-0 z-[100] bg-slate-900/60 backdrop-blur-sm items-center justify-center p-4">
                                                            <div
                                                                class="bg-white max-w-2xl w-full rounded-3xl shadow-2xl overflow-hidden relative text-left">
                                                                <div class="bg-verdant p-8 text-white relative">
                                                                    <label for="modal-${a.id}"
                                                                        class="absolute top-6 right-6 cursor-pointer hover:rotate-90 transition-transform">
                                                                        <span
                                                                            class="material-icons text-3xl">close</span>
                                                                    </label>
                                                                    <h2 class="text-3xl font-black mb-2">${a.titre}</h2>
                                                                    <p
                                                                        class="text-white/80 font-bold uppercase tracking-widest text-sm flex items-center gap-2">
                                                                        <span
                                                                            class="material-icons text-sm">business</span>
                                                                        ${a.entreprise}
                                                                    </p>
                                                                </div>
                                                                <div class="p-10">
                                                                    <div class="mb-6 flex gap-3">
                                                                        <span
                                                                            class="px-4 py-2 bg-verdant/10 text-verdant rounded-xl text-xs font-black uppercase">${a.type_contrat}</span>
                                                                        <span
                                                                            class="px-4 py-2 bg-slate-100 text-slate-500 rounded-xl text-xs font-bold">${a.date_publication}</span>
                                                                    </div>
                                                                    <h4
                                                                        class="text-slate-900 font-black uppercase text-xs tracking-widest mb-4 border-b pb-2">
                                                                        Description du Poste</h4>
                                                                    <div
                                                                        class="text-slate-600 leading-relaxed whitespace-pre-line text-sm max-h-60 overflow-y-auto pr-4">
                                                                        ${a.description}
                                                                    </div>
                                                                </div>
                                                                <div class="bg-slate-50 p-6 flex justify-end">
                                                                    <label for="modal-${a.id}"
                                                                        class="bg-verdant text-white px-8 py-3 rounded-2xl font-black text-sm cursor-pointer hover:bg-verdant-dark shadow-xl transition-all">Fermer</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:when>

                    </c:choose>

                    <!-- Toast Success Notification -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div id="toast-container" class="fixed top-10 right-10 z-[200] toast-animation">
                            <div class="bg-verdant text-white px-8 py-4 rounded-2xl shadow-2xl flex items-center gap-4">
                                <span class="material-icons">check_circle</span>
                                <span class="font-bold">${sessionScope.successMessage}</span>
                            </div>
                        </div>
                        <script>
                            setTimeout(() => {
                                const toast = document.getElementById('toast-container');
                                if (toast) {
                                    toast.classList.add('toast-fadeout');
                                    setTimeout(() => toast.style.display = 'none', 800);
                                }
                            }, 3000);
                        </script>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                </main>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const searchInput = document.getElementById('userSearch');
                    const roleFilter = document.getElementById('roleFilter');
                    const rows = document.querySelectorAll('.user-row');

                    function filterUsers() {
                        const query = (searchInput ? searchInput.value.toLowerCase() : "");
                        const role = (roleFilter ? roleFilter.value : "ALL");

                        rows.forEach(row => {
                            let textMatch = false;
                            // Search in all td cells of the row
                            const cells = row.querySelectorAll('td');
                            cells.forEach(td => {
                                if (td.textContent.toLowerCase().includes(query)) {
                                    textMatch = true;
                                }
                            });

                            const roleMatch = (role === 'ALL' || row.dataset.role === role);

                            if (textMatch && roleMatch) {
                                row.classList.remove('hidden');
                                // If using tailwind, we might need display block if hidden class is used
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    }

                    if (searchInput) searchInput.addEventListener('keyup', filterUsers);
                    if (roleFilter) roleFilter.addEventListener('change', filterUsers);
                });
            </script>
        </body>

        </html>