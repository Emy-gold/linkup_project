<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
</head>
<!-- Top Bar -->
<div class="bg-surface-light border-b border-slate-200 sticky top-0 z-40">
    <div class="px-8 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-slate-900">${param.pageTitle}</h1>
        <div class="flex items-center space-x-4">
            <span class="text-sm text-slate-600">
                <c:if test="${not empty user}">
                    <span class="font-medium text-xl">${user.nom} ${user.prenom}</span>
                </c:if>
                <c:if test="${empty user}">
                    Recruteur
                </c:if>
            </span>
            <div class="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm">
                ${user.initiales != null ? user.initiales : 'R'}
            </div>
        </div>
    </div>
</div>
