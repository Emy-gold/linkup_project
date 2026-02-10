<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Annonce" %>
<%@ page import="Models.Cv" %>
<%@ page import="java.util.List" %>
<%
    utilisateur user = (utilisateur) session.getAttribute("user");
    if(user == null || !"CANDIDAT".equals(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }

    Annonce currentAnnonce = (Annonce) request.getAttribute("annonce");
    List<Cv> cvs = (List<Cv>) request.getAttribute("cvs");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Postuler - LinkUp</title>
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
                    fontFamily: { sans: ["Inter", "sans-serif"] },
                },
            },
        };
    </script>
</head>
<body class="bg-gray-50 font-sans min-h-screen py-8 px-4">
<div class="max-w-4xl mx-auto">
    <!-- Back Button -->
    <button onclick="history.back()" class="flex items-center gap-2 text-gray-600 hover:text-gray-800 mb-6">
        <span class="material-icons">arrow_back</span>
        <span>Retour aux annonces</span>
    </button>

    <% if(currentAnnonce != null) { %>
    <!-- Job Details Card -->
    <div class="bg-white rounded-xl shadow-sm p-8 mb-6 border border-gray-100">
        <div class="flex gap-4">
            <div class="w-20 h-20 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                <span class="material-icons text-primary text-4xl">business</span>
            </div>
            <div>
                <h1 class="text-2xl font-bold text-gray-800 mb-2"><%= currentAnnonce.getTitre() %></h1>
                <div class="flex flex-wrap gap-2 mb-3">
                    <span class="px-3 py-1 bg-primary/10 text-primary rounded-full text-sm font-medium"><%= currentAnnonce.getTypeContrat() %></span>
                </div>
                <p class="text-gray-600 text-sm"><%= currentAnnonce.getDescriptionPoste() %></p>
            </div>
        </div>
    </div>

    <!-- Application Form -->
    <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
        <h2 class="text-xl font-bold text-gray-800 mb-6">Postuler à cette offre</h2>

        <% if(cvs != null && !cvs.isEmpty()) { %>
        <form action="postuler" method="post" class="space-y-6">
            <input type="hidden" name="annonceId" value="<%= currentAnnonce.getId() %>">
            <input type="hidden" name="candidatId" value="<%= user.getIdUtilisateur() %>">

            <!-- CV Selection -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                        <span class="flex items-center gap-2">
                            <span class="material-icons text-sm text-primary">picture_as_pdf</span>
                            Choisir votre CV
                        </span>
                </label>
                <select name="cvId" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="">-- Sélectionner un CV --</option>
                    <% for(Cv c : cvs) { %>
                    <option value="<%= c.getId() %>"><%= c.getTitre() %></option>
                    <% } %>
                </select>
            </div>

            <!-- Cover Letter -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                        <span class="flex items-center gap-2">
                            <span class="material-icons text-sm text-primary">description</span>
                            Lettre de motivation
                        </span>
                </label>
                <textarea name="lettreMotivation" rows="8" required
                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent resize-none"
                          placeholder="Expliquez pourquoi vous êtes le candidat idéal pour ce poste..."></textarea>
            </div>

            <!-- Consent -->
            <div class="flex items-start gap-3">
                <input type="checkbox" id="consent" required class="mt-1 rounded border-gray-300 text-primary focus:ring-primary">
                <label for="consent" class="text-sm text-gray-600">
                    J'accepte que mes informations soient transmises à l'entreprise et confirme l'exactitude des informations fournies.
                </label>
            </div>

            <!-- Buttons -->
            <div class="flex gap-4 pt-2">
                <button type="submit" class="flex-1 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-semibold flex items-center justify-center gap-2">
                    <span class="material-icons">send</span>
                    <span>Envoyer ma candidature</span>
                </button>
                <button type="button" onclick="history.back()" class="px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-semibold">
                    Annuler
                </button>
            </div>
        </form>

        <% } else { %>
        <!-- No CV Warning -->
        <div class="text-center py-10">
            <span class="material-icons text-6xl text-gray-300 mb-4">picture_as_pdf</span>
            <h3 class="text-xl font-semibold text-gray-700 mb-2">Aucun CV disponible</h3>
            <p class="text-gray-500 mb-6">Vous devez d'abord télécharger votre CV en PDF avant de postuler.</p>
            <a href="cv" class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-semibold">
                <span class="material-icons">upload_file</span>
                <span>Télécharger mon CV</span>
            </a>
        </div>
        <% } %>
    </div>

    <% } else { %>
    <!-- Annonce not found -->
    <div class="bg-red-50 border border-red-200 rounded-xl p-8 text-center">
        <span class="material-icons text-6xl text-red-400 mb-4">error</span>
        <h2 class="text-2xl font-bold text-red-800 mb-2">Annonce introuvable</h2>
        <p class="text-red-600 mb-6">L'annonce que vous recherchez n'existe pas ou a été supprimée.</p>
        <a href="annonces" class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors">
            <span class="material-icons">arrow_back</span>
            <span>Retour aux annonces</span>
        </a>
    </div>
    <% } %>
</div>
</body>
</html>