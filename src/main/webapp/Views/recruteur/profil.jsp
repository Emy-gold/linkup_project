<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Linkup Recruteur</title>
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
    <jsp:param name="currentPage" value="profil"/>
</jsp:include>

<!-- Main Content -->
<div class="flex-1 flex flex-col">
    <!-- Header -->
    <jsp:include page="layout/header.jsp">
        <jsp:param name="pageTitle" value="Mon Profil"/>
    </jsp:include>

    <!-- Content -->
    <main class="flex-1 overflow-y-auto px-8 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Profile Card -->
            <div class="bg-surface-light border border-slate-200 rounded-lg p-8">
                <div class="text-center mb-6">
                    <div class="w-24 h-24 rounded-full bg-primary text-white flex items-center justify-center font-bold text-3xl mx-auto mb-4">
                        ${user.nom.charAt(0)}${user.prenom.charAt(0)}
                    </div>
                    <h2 class="text-2xl font-bold text-slate-900"></h2>
                    <p class="text-slate-600 mt-1"></p>
                </div>

                <div class="space-y-4 border-t border-slate-200 pt-6">
                    <div>
                        <p class="text-xs text-slate-600 font-medium uppercase">Email</p>
                        <p class="text-slate-900 mt-1">${user.email}</p>
                    </div>
                    <div>
                        <p class="text-xs text-slate-600 font-medium uppercase">Téléphone</p>
                        <p class="text-slate-900 mt-1">060000</p>
                    </div>
                    <div>
                        <p class="text-xs text-slate-600 font-medium uppercase">Localisation</p>
                        <p class="text-slate-900 mt-1">tng</p>
                    </div>
                    <div>
                        <p class="text-xs text-slate-600 font-medium uppercase">Inscrit depuis</p>
                        <p class="text-slate-900 mt-1">${user.date}</p>
                    </div>
                </div>

                <button onclick="editProfile()" class="w-full mt-6 px-4 py-2 bg-primary hover:bg-primary-dark text-white font-medium rounded-lg transition-colors">
                    <i class="fas fa-edit mr-2"></i> Modifier le Profil
                </button>
            </div>

            <!-- Form Content -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Informations Personnelles -->
                <div class="bg-surface-light border border-slate-200 rounded-lg p-6">
                    <h3 class="text-lg font-bold text-slate-900 mb-6">Informations Personnelles</h3>
                    <form class="space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Nom</label>
                                <input type="text" value="${user.nom}" class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Prénom</label>
                                <input type="text" value="${user.prenom}" class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Email</label>
                            <input type="email" value="${user.email}" class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Téléphone</label>
                                <input type="tel" value="${user.telephone}" class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Entreprise</label>
                                <input type="text" value="${recruteur.nomEntreprise}" class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                            </div>
                        </div>

                        <button type="submit" class="px-6 py-2 bg-primary hover:bg-primary-dark text-white font-medium rounded-lg transition-colors">
                            <i class="fas fa-save mr-2"></i> Enregistrer les modifications
                        </button>
                    </form>
                </div>

                <!-- Sécurité -->
                <div class="bg-surface-light border border-slate-200 rounded-lg p-6">
                    <h3 class="text-lg font-bold text-slate-900 mb-6">Sécurité</h3>
                    <div class="space-y-4">
                        <div>
                            <button onclick="changePassword()" class="px-6 py-2 border border-slate-300 text-slate-700 font-medium rounded-lg hover:bg-slate-50 transition-colors">
                                <i class="fas fa-lock mr-2"></i> Changer le mot de passe
                            </button>
                        </div>
                        <div>
                            <p class="text-sm text-slate-600">Dernière modification: ${user.lastPasswordChange}</p>
                        </div>
                    </div>
                </div>

                <!-- Préférences -->
                <div class="bg-surface-light border border-slate-200 rounded-lg p-6">
                    <h3 class="text-lg font-bold text-slate-900 mb-6">Préférences</h3>
                    <form class="space-y-4">
                        <div class="flex items-center justify-between">
                            <label class="text-sm font-medium text-slate-700">Notifications par email</label>
                            <input type="checkbox" checked class="w-4 h-4 text-primary rounded">
                        </div>
                        <div class="flex items-center justify-between">
                            <label class="text-sm font-medium text-slate-700">Alertes candidatures</label>
                            <input type="checkbox" checked class="w-4 h-4 text-primary rounded">
                        </div>
                        <div class="flex items-center justify-between">
                            <label class="text-sm font-medium text-slate-700">Récommandations</label>
                            <input type="checkbox" class="w-4 h-4 text-primary rounded">
                        </div>

                        <button type="submit" class="w-full px-4 py-2 bg-primary hover:bg-primary-dark text-white font-medium rounded-lg transition-colors mt-6">
                            <i class="fas fa-save mr-2"></i> Enregistrer les préférences
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="layout/footer.jsp"/>
</div>

<script>
    function editProfile() {
        alert('Fonctionnalité en développement');
    }

    function changePassword() {
        alert('Fonctionnalité en développement');
    }
</script>
</body>

</html>
