<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Linkup Recruteur</title>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMq8r7sS1s5M5c5L5z5J5Z5g5Z5g5Z5g5Z5g5" crossorigin="anonymous">
</head>

<!-- Sidebar -->
<aside class="w-56 bg-surface-light border-r border-slate-200 min-h-screen sticky top-0 flex flex-col shadow-lg">
    <!-- Logo -->
    <div class="p-6 border-b border-slate-200">
        <div class="flex items-center space-x-2">
            <img src="${pageContext.request.contextPath}/assets/logo.png" class="h-12 w-auto" alt="Linkup">
            <span class="text-xl font-bold text-primary"></span>
        </div>
    </div>

    <!-- Menu Items -->
    <nav class="flex-1 p-4 space-y-2">
        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/recruteur/dashboard"
           class="nav-item flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-700 hover:bg-slate-100 transition-colors font-medium ${currentPage == 'dashboard' ? 'bg-primary text-white hover:bg-primary-dark' : ''}">
            <i class="fas fa-home w-5"></i>
            <span>Dashboard</span>
        </a>

        <!-- Mes Annonces -->
        <a href="${pageContext.request.contextPath}/recruteur/annonces"
           class="nav-item flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-700 hover:bg-slate-100 transition-colors font-medium ${currentPage == 'annonces' ? 'bg-primary text-white hover:bg-primary-dark' : ''}">
            <i class="fas fa-bullhorn text-blue-600 text-xl"></i>
            <span>Mes Annonces</span>
        </a>

        <!-- Candidatures reçues -->
        <a href="${pageContext.request.contextPath}/recruteur/candidatures"
           class="nav-item flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-700 hover:bg-slate-100 transition-colors font-medium ${currentPage == 'candidatures' ? 'bg-primary text-white hover:bg-primary-dark' : ''}">
            <i class="fas fa-inbox w-5"></i>
            <span>Candidatures reçues</span>
        </a>

        <!-- Mes Candidats -->
        <a href="${pageContext.request.contextPath}/recruteur/candidats"
           class="nav-item flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-700 hover:bg-slate-100 transition-colors font-medium ${currentPage == 'candidats' ? 'bg-primary text-white hover:bg-primary-dark' : ''}">
            <i class="fas fa-users w-5"></i>
            <span>Mes Candidats</span>
        </a>

        <!-- Mon Profil -->
        <a href="${pageContext.request.contextPath}/recruteur/profil"
           class="nav-item flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-700 hover:bg-slate-100 transition-colors font-medium ${currentPage == 'profil' ? 'bg-primary text-white hover:bg-primary-dark' : ''}">
            <i class="fas fa-user-circle w-5"></i>
            <span>Mon Profil</span>
        </a>
    </nav>

    <!-- Logout -->
    <div class="p-4 border-t border-slate-200">
        <a href="${pageContext.request.contextPath}/Logout"
           class="flex items-center space-x-3 px-4 py-3 rounded-lg text-red-600 hover:bg-red-50 transition-colors font-medium">
            <i class="fas fa-sign-out-alt w-5"></i>
            <span>Déconnexion</span>
        </a>
    </div>
</aside>
