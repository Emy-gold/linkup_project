<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Compléter le Profil - Linkup</title>
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

        <body
            class="bg-gradient-to-br from-background-light to-blue-50 text-slate-800 font-sans min-h-screen flex items-center justify-center py-8">
            <div class="w-full max-w-2xl">
                <!-- Card Principal -->
                <div class="bg-surface-light rounded-lg shadow-lg p-8 md:p-12">
                    <!-- Header -->
                    <div class="text-center mb-8">
                        <div class="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-user-edit text-primary text-2xl"></i>
                        </div>
                        <h1 class="text-3xl font-bold text-slate-900 mb-2">Compléter votre Profil</h1>
                        <p class="text-slate-600">Remplissez les informations pour accéder à votre tableau de bord</p>
                    </div>

                    <!-- Afficher les erreurs -->
                    <c:if test="${not empty error}">
                        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start">
                            <i class="fas fa-exclamation-circle text-red-600 mt-0.5 mr-3"></i>
                            <div>
                                <h3 class="text-sm font-medium text-red-800">${error}</h3>
                            </div>
                        </div>
                    </c:if>

                    <!-- Afficher le succès -->
                    <c:if test="${not empty success}">
                        <div class="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg flex items-start">
                            <i class="fas fa-check-circle text-green-600 mt-0.5 mr-3"></i>
                            <div>
                                <h3 class="text-sm font-medium text-green-800">${success}</h3>
                            </div>
                        </div>
                    </c:if>

                    <!-- Formulaire -->
                    <form method="POST" action="${pageContext.request.contextPath}/recruteur/complete-profile"
                        class="space-y-6">

                        <!-- Section 2: Informations Professionnelles -->
                        <div>
                            <h2 class="text-lg font-bold text-slate-900 mb-4 pb-4 border-b border-slate-200">
                                <i class="fas fa-briefcase text-primary mr-2"></i>Informations Professionnelles
                            </h2>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                                <!-- Entreprise -->
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Nom de l'Entreprise
                                        *</label>
                                    <input type="text" name="nomEntreprise" value="${recruteur.nomEntreprise}" required
                                        placeholder="Ex: Tech Solutions Inc."
                                        class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                                </div>

                                <!-- Domaine -->
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Domaine *</label>
                                    <select name="secteurActivite" required
                                        class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">
                                        <option value="">Sélectionner un domaine</option>
                                        <option value="Informatique" ${recruteur.secteurActivite=='Informatique'
                                            ? 'selected' : '' }>Informatique</option>
                                        <option value="Ventes" ${recruteur.secteurActivite=='Ventes' ? 'selected' : ''
                                            }>Ventes</option>
                                        <option value="Marketing" ${recruteur.secteurActivite=='Marketing' ? 'selected'
                                            : '' }>Marketing</option>
                                        <option value="RH" ${recruteur.secteurActivite=='RH' ? 'selected' : '' }>
                                            Ressources Humaines</option>
                                        <option value="Finance" ${recruteur.secteurActivite=='Finance' ? 'selected' : ''
                                            }>Finance</option>
                                        <option value="Design" ${recruteur.secteurActivite=='Design' ? 'selected' : ''
                                            }>Design</option>
                                        <option value="Autre" ${recruteur.secteurActivite=='Autre' ? 'selected' : '' }>
                                            Autre</option>
                                    </select>
                                </div>

                                <!-- POSTE (FIX IMPORTANT) -->
                                <div>
                                    <label class="block text-sm font-medium mb-2">Poste *</label>
                                    <input type="text" name="posteOccupe" placeholder="Ex: Responsable RH" required
                                        class="w-full px-4 py-2 border rounded-lg outline-none">
                                </div>
                            </div>

                            <!-- Description -->
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Description de l'Entreprise
                                    *</label>
                                <textarea name="descriptionEntreprise" rows="4" required
                                    placeholder="Décrivez votre entreprise, vos activités, vos valeurs..."
                                    class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none">${recruteur.descriptionEntreprise}</textarea>
                                <p class="text-xs text-slate-500 mt-1">Minimum 10 caractères</p>
                            </div>

                        </div>

                        <!-- Boutons -->
                        <div class="flex gap-3 pt-6 border-t border-slate-200">
                            <button type="submit"
                                class="flex-1 px-6 py-3 bg-primary hover:bg-primary-dark text-white font-semibold rounded-lg transition-colors flex items-center justify-center gap-2">
                                <i class="fas fa-check"></i> Compléter et Accéder
                            </button>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="flex-1 px-6 py-3 bg-slate-200 hover:bg-slate-300 text-slate-700 font-semibold rounded-lg transition-colors flex items-center justify-center gap-2">
                                <i class="fas fa-sign-out-alt"></i> Déconnexion
                            </a>
                        </div>

                        <!-- Info -->
                        <div class="p-4 bg-blue-50 border border-blue-200 rounded-lg">
                            <p class="text-sm text-blue-800">
                                <i class="fas fa-info-circle mr-2"></i>
                                Tous les champs marqués avec * sont obligatoires pour continuer.
                            </p>
                        </div>
                    </form>
                </div>

                <!-- Footer -->

            </div>
        </body>

        </html>