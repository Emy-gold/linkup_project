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

<body class="bg-background-light font-sans">

<!-- ===== Layout Wrapper ===== -->
<div class="flex min-h-screen">

    <!-- ===== Sidebar ===== -->
        <jsp:include page="layout/sidebar.jsp">
            <jsp:param name="currentPage" value="profil"/>
        </jsp:include>


    <!-- ===== Content Area ===== -->
    <div class="flex-1 flex flex-col">

        <!-- ===== Header ===== -->
        <header class="bg-white border-b border-gray-200 shadow-sm">
            <jsp:include page="layout/header.jsp">
                <jsp:param name="pageTitle" value="Mon Profil"/>
            </jsp:include>
        </header>


        <!-- ===== Page Content ===== -->
        <main class="flex-1 p-8 overflow-y-auto">

            <!-- Alerts -->
            <c:if test="${not empty success}">
                <div class="mb-6 p-4 rounded-lg border bg-green-50 text-green-700 border-green-200 flex items-center gap-3">
                    <i class="fas fa-check-circle"></i>
                    <span class="font-medium">${success}</span>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="mb-6 p-4 rounded-lg border bg-red-50 text-red-700 border-red-200 flex items-center gap-3">
                    <i class="fas fa-exclamation-circle"></i>
                    <span class="font-medium">${error}</span>
                </div>
            </c:if>


            <!-- ===== Grid Layout ===== -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <!-- ================================= -->
                <!-- Profile Card -->
                <!-- ================================= -->
                <div class="lg:col-span-1">

                    <div class="bg-white rounded-2xl shadow-md border border-gray-100 p-7 sticky top-6">

                        <!-- Avatar -->
                        <div class="text-center">
                            <div class="w-24 h-24 rounded-full bg-primary text-white flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                                ${user.prenom.substring(0,1)}${user.nom.substring(0,1)}
                            </div>

                            <h2 class="text-xl font-bold text-gray-800">
                                ${user.prenom} ${user.nom}
                            </h2>

                            <p class="text-sm text-gray-500 mt-1">
                                ${empty recruteur.nomEntreprise ? 'Entreprise non renseignée' : recruteur.nomEntreprise}
                            </p>
                        </div>


                        <!-- Info list -->
                        <div class="mt-6 pt-5 border-t space-y-3 text-sm text-gray-600">

                            <div class="flex items-center gap-3">
                                <i class="fas fa-envelope text-gray-400"></i>
                                ${user.email}
                            </div>

                            <c:if test="${not empty recruteur.secteurActivite}">
                                <div class="flex items-center gap-3">
                                    <i class="fas fa-building text-gray-400"></i>
                                        ${recruteur.secteurActivite}
                                </div>
                            </c:if>

                            <c:if test="${not empty recruteur.posteOccupe}">
                                <div class="flex items-center gap-3">
                                    <i class="fas fa-briefcase text-gray-400"></i>
                                        ${recruteur.posteOccupe}
                                </div>
                            </c:if>

                            <span class="inline-block mt-2 px-3 py-1 text-xs bg-green-100 text-green-700 rounded-full font-medium">
                                Profil Complet
                            </span>
                        </div>

                    </div>
                </div>



                <!-- ================================= -->
                <!-- Forms Column -->
                <!-- ================================= -->
                <div class="lg:col-span-2 space-y-4">
                    <!-- ===== Card Style Reusable ===== -->
                    <div class="bg-white rounded-2xl shadow-lg border border-gray-200 p-8">

                        <form method="POST" action="${pageContext.request.contextPath}/recruteur/profil" class="space-y-4">

                            <input type="hidden" name="actionRecruteur" value="modifyRecruteur">

                            <!-- Personal Info Section -->


                            <!-- Professional Info Section -->
                            <c:if test="${not empty recruteur}">
                                <div class=" border-gray-200 pt-4">
                                    <h3 class="text-xl font-bold mb-6 flex items-center gap-3 text-gray-900">
                                        <i class="fas fa-briefcase text-blue-600"></i>
                                        Informations Professionnelles
                                    </h3>

                                    <div class="grid md:grid-cols-2 gap-6">
                                        <div class="flex flex-col">
                                            <label for="nomEntreprise" class="block text-sm font-medium text-gray-700 mb-2">Entreprise *</label>
                                            <input type="text" id="nomEntreprise" name="nomEntreprise"
                                                   value="${recruteur.nomEntreprise}"
                                                   placeholder="Nom de l'entreprise" required
                                                   class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition duration-200 hover:border-gray-400">
                                        </div>

                                        <div class="flex flex-col">
                                            <label for="posteOccupe" class="block text-sm font-medium text-gray-700 mb-2">Poste</label>
                                            <input type="text" id="posteOccupe" name="posteOccupe"
                                                   value="${recruteur.posteOccupe}"
                                                   placeholder="Votre poste"
                                                   class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition duration-200 hover:border-gray-400">
                                        </div>
                                    </div>

                                    <div class="flex flex-col mt-6">
                                        <label for="descriptionEntreprise" class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                                        <textarea id="descriptionEntreprise" name="descriptionEntreprise" rows="4"
                                                  placeholder=""
                                                  class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition duration-200 hover:border-gray-400 resize-vertical">${recruteur.descriptionEntreprise}</textarea>
                                    </div>

                                    <div class="flex flex-col mt-6">
                                        <label for="secteurActivite" class="block text-sm font-medium text-gray-700 mb-2">Domaine *</label>
                                        <select id="secteurActivite" name="secteurActivite" required
                                                class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition duration-200 hover:border-gray-400 bg-white">
                                            <option value="">-- Sélectionner un domaine --</option>
                                            <option value="Informatique" ${recruteur.secteurActivite == 'Informatique' ? 'selected' : ''}>Informatique</option>
                                            <option value="Ventes" ${recruteur.secteurActivite == 'Ventes' ? 'selected' : ''}>Ventes</option>
                                            <option value="Marketing" ${recruteur.secteurActivite == 'Marketing' ? 'selected' : ''}>Marketing</option>
                                            <option value="RH" ${recruteur.secteurActivite == 'RH' ? 'selected' : ''}>Ressources Humaines</option>
                                            <option value="Finance" ${recruteur.secteurActivite == 'Finance' ? 'selected' : ''}>Finance</option>
                                            <option value="Design" ${recruteur.secteurActivite == 'Design' ? 'selected' : ''}>Design</option>
                                            <option value="Autre" ${recruteur.secteurActivite == 'Autre' ? 'selected' : ''}>Autre</option>
                                        </select>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Submit Button -->
                            <div class="flex gap-4 pt-4">
                                <button type="submit" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2.5 px-6 rounded-lg transition duration-200 shadow-md hover:shadow-lg active:scale-95">
                                    <i class="fas fa-save mr-2"></i>Enregistrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<!-- Footer -->
<jsp:include page="layout/footer.jsp"/>
</body>
</html>

