<%--
  Created by IntelliJ IDEA.
  User: ToshiBa
  Date: 2/3/2026
  Time: 9:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
        <aside class="w-64 bg-white shadow-lg">
            <div class="p-6">
                <img src="../../assets/logo.png" class="h-12 w-auto mb-8" alt="LinkUp">
                <nav>
                    <a>
                        <span>dashboard</span>
                        <span>Dashboard</span>
                    </a>
                    <a>
                        <span>work</span>
                        <span>Annonces</span>
                    </a>
                    <a>
                        <span>description</span>
                        <span>Mes Candidatures</span>
                    </a>
                    <a>
                        <span>article</span>
                        <span>Mon Cv</span>
                    </a>
                    <a>
                        <span>event</span>
                        <span>Entretiens</span>
                    </a>
                    <a>
                        <span>person</span>
                        <span>Mon Profil</span>
                    </a>
                </nav>
            </div>
            <div>
                <a>
                    <span>logout</span>
                    <span>Déconnexion</span>
                </a>
            </div>
        </aside>

    </div>
</body>
</html>
