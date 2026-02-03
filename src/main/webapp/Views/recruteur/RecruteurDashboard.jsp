<%--
  Created by IntelliJ IDEA.
  User: Pro
  Date: 1/6/2026
  Time: 12:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Linkup - Recruteur</title>
  <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
  <script>
    tailwind.config = {
      darkMode: "class",
      theme: {
        extend: {
          colors: {
            primary: "#3ea721",
            "primary-dark": "#2e8018",
            "background-light": "#f8fafc",
            "background-dark": "#0f172a",
            "surface-light": "#ffffff",
            "surface-dark": "#1e293b",
          },
          fontFamily: {
            sans: ["Inter", "sans-serif"],
          },
          borderRadius: {
            DEFAULT: "0.5rem",
          },
        },
      },
    };
  </script>
</head>
<body class="bg-background-light text-slate-800 font-sans min-h-screen flex flex-col transition-colors duration-300">
<nav class="sticky top-0 z-50 backdrop-blur-md bg-surface-light/80 border-b border-slate-200">
  <div class="max-w-8xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center h-16">
      <div class="flex-shrink-0 flex items-center">
        <img
                src="${pageContext.request.contextPath}/assets/logo.png"
                class="h-16 w-auto"
                alt="linkup">
      </div>

      <div class="flex items-center space-x-4">
        <a href="RecruteurDashboard.jsp" class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors pointer cursor-pointer">
          <img src="${pageContext.request.contextPath}/assets/recrut.png" class="h-12 w-auto m-1" alt="linkup">
        </a>
        <a href="${pageContext.request.contextPath}/Logout" class="inline-flex items-center justify-center px-5 py-2 border-transparent text-sm font-medium rounded-full text-white bg-red-600 hover:bg-red-700 transition-colors shadow-sm hover:shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 cursor-pointer">Logout</a>
      </div>
    </div>
  </div>
</nav>

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

</body>
</html>
