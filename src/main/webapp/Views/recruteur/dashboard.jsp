<%-- Created by IntelliJ IDEA. User: Pro Date: 1/6/2026 Time: 12:48 PM To change this template use File | Settings |
  File Templates. --%>
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>


      <!DOCTYPE html>
      <html lang="fr">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Linkup Recruteur</title>
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

      <body class="bg-background-light text-slate-800 font-sans min-h-screen flex transition-colors duration-300">
        <!-- Sidebar -->
        <jsp:include page="layout/sidebar.jsp">
          <jsp:param name="currentPage" value="dashboard" />
        </jsp:include>

        <!-- Main Content -->
        <div class="flex-1 flex flex-col">
          <!-- Header -->
          <jsp:include page="layout/header.jsp">
            <jsp:param name="pageTitle" value="Dashboard" />
          </jsp:include>

          <!-- Content -->
          <main class="flex-1 overflow-y-auto px-8 py-8">
            <div class="space-y-8">
              <!-- Welcome Section -->
              <div class="bg-gradient-to-r from-primary to-primary-dark rounded-lg shadow-md p-8 text-white">
                <h2 class="text-3xl font-bold mb-2">Bienvenue, Recruteur!</h2>
                <p class="text-white text-2xl ">Gérez vos annonces et candidats efficacement</p>
              </div>

              <!-- Stats Grid -->
              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Stat Card 1: Annonces -->
                <div
                  class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow">
                  <div class="flex items-center justify-between">
                    <div>
                      <p class="text-sm text-slate-600 font-medium">Annonces Publiées</p>
                      <p class="text-3xl font-bold text-slate-900 mt-2">${adsCount != null ? adsCount : 0}</p>
                    </div>
                    <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                      <i class="fas fa-bullhorn text-green-600 text-xl"></i>
                    </div>
                  </div>
                </div>

                <!-- Stat Card 2: Candidatures -->
                <div
                  class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow">
                  <div class="flex items-center justify-between">
                    <div>
                      <p class="text-sm text-slate-600 font-medium">Candidatures Reçues</p>
                      <p class="text-3xl font-bold text-slate-900 mt-2">${appsCount != null ? appsCount : 0}</p>
                    </div>
                    <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                      <i class="fas fa-inbox text-green-600 text-xl"></i>
                    </div>
                  </div>
                </div>

                <!-- Stat Card 3: Candidats -->
                <div
                  class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow">
                  <div class="flex items-center justify-between">
                    <div>
                      <p class="text-sm text-slate-600 font-medium">Entretiens Sauvegardés</p>
                      <p class="text-3xl font-bold text-slate-900 mt-2">${entsCount !=null ? entsCount : 0}</p>
                    </div>
                    <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                      <i class="fas fa-calendar-check text-purple-600 text-xl"></i>
                    </div>
                  </div>
                </div>

                <!-- Stat Card 4: Taux Acceptation -->
                <div
                  class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow">
                  <div class="flex items-center justify-between">
                    <div>
                      <p class="text-sm text-slate-600 font-medium">Taux d'Acceptation</p>
                      <p class="text-3xl font-bold text-slate-900 mt-2">${acceptanceRate != null ? acceptanceRate : 0}%
                      </p>
                    </div>
                    <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
                      <i class="fas fa-chart-pie text-orange-600 text-xl"></i>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Quick Actions -->
              <div class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm">
                <h3 class="text-lg font-bold text-slate-900 mb-4">Actions Rapides</h3>
                <div class="flex flex-wrap gap-3">
                  <a href="${pageContext.request.contextPath}/recruteur/annonces"
                    class="px-6 py-2 bg-primary hover:bg-primary-dark text-white rounded-lg font-medium transition-colors flex items-center gap-2">
                    <i class="fas fa-plus"></i> Créer une Annonce
                  </a>
                  <a href="${pageContext.request.contextPath}/recruteur/candidatures"
                    class="px-6 py-2 border border-primary text-primary hover:bg-primary/5 rounded-lg font-medium transition-colors flex items-center gap-2">
                    <i class="fas fa-inbox"></i> Voir les Candidatures
                  </a>
                  <a href="${pageContext.request.contextPath}/recruteur/entretiens"
                    class="px-6 py-2 border border-primary text-primary hover:bg-primary/5 rounded-lg font-medium transition-colors flex items-center gap-2">
                    <i class="fas fa-calendar-check w-5"></i> Voir les Entretiens
                  </a>
                </div>
              </div>

              <!-- Recent Activity -->
              <div class="bg-surface-light border border-slate-200 rounded-lg p-6 shadow-sm">
                <h3 class="text-lg font-bold text-slate-900 mb-4">Activité Récente</h3>
                <div class="space-y-4">
                  <c:choose>
                    <c:when test="${not empty recentActivity}">
                      <c:forEach var="activity" items="${recentActivity}" varStatus="loop">
                        <c:if test="${loop.index < 5}">
                          <div class="flex items-start gap-4 pb-4 border-b border-slate-100">
                            <div
                              class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                              <i class="fas fa-comment text-primary"></i>
                            </div>
                            <div class="flex-1 min-w-0">
                              <p class="font-medium text-slate-900">${activity.titre}</p>
                              <p class="text-sm text-slate-600 mt-1">${activity.description}</p>
                              <p class="text-xs text-slate-500 mt-2">${activity.date}</p>
                            </div>
                          </div>
                        </c:if>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <div class="text-center py-8">
                        <i class="fas fa-inbox text-4xl text-slate-300 mb-3 block"></i>
                        <p class="text-slate-600">Aucune activité récente</p>
                      </div>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

            </div>
          </main>




        </div>
      </body>

      </html>