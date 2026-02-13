<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.utilisateur" %>
<%@ page import="Models.Cv" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
  utilisateur user = (utilisateur) session.getAttribute("user");
  if(user == null || !"CANDIDAT".equals(user.getRole())) {
    response.sendRedirect("../../login.jsp");
    return;
  }

  List<Cv> cvs = (List<Cv>) request.getAttribute("cvs");
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Mon CV - LinkUp</title>
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
<body class="bg-gray-50 font-sans">
<div class="flex h-screen">
  <!-- Sidebar -->
  <aside class="w-64 bg-white shadow-lg">
    <div class="p-6">
      <img src="${pageContext.request.contextPath}/assets/logo.png" class="h-12 w-auto mb-8" alt="LinkUp">
      <nav class="space-y-2">
        <a href="dashboard" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
          <span class="material-icons">dashboard</span><span class="font-medium">Dashboard</span>
        </a>
        <a href="annonces" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
          <span class="material-icons">work</span><span class="font-medium">Annonces</span>
        </a>
        <a href="candidatures" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
          <span class="material-icons">description</span><span class="font-medium">Mes Candidatures</span>
        </a>
        <a href="cv" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary text-white">
          <span class="material-icons">article</span><span class="font-medium">Mon CV</span>
        </a>
        <a href="entretiens" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
          <span class="material-icons">event</span><span class="font-medium">Entretiens</span>
        </a>
        <a href="profile" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
          <span class="material-icons">person</span><span class="font-medium">Mon Profil</span>
        </a>
      </nav>
    </div>
    <div class="absolute bottom-0 w-64 p-6 border-t">
      <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-3 rounded-lg text-red-600 hover:bg-red-50 transition-colors">
        <span class="material-icons">logout</span><span class="font-medium">Déconnexion</span>
      </a>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 overflow-y-auto">
    <header class="bg-white shadow-sm sticky top-0 z-10">
      <div class="flex items-center justify-between px-8 py-4">
        <h1 class="text-2xl font-bold text-gray-800">Mon CV</h1>
        <div class="flex items-center gap-3">
          <button onclick="document.getElementById('uploadModal').classList.remove('hidden')" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors flex items-center gap-2">
            <span class="material-icons">upload_file</span>
            <span>Télécharger un CV</span>
          </button>
          <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-bold">
            <%= user.getPrenom().substring(0,1) %><%= user.getNom().substring(0,1) %>
          </div>
        </div>
      </div>
    </header>

    <div class="p-8">
      <!-- Messages -->
      <% String success = request.getParameter("success"); String error = request.getParameter("error"); %>
      <% if("uploaded".equals(success)) { %>
      <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6">
        <p class="font-semibold">CV téléchargé avec succès!</p>
      </div>
      <% } else if("deleted".equals(success)) { %>
      <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6">
        <p class="font-semibold">CV supprimé avec succès!</p>
      </div>
      <% } else if("notpdf".equals(error)) { %>
      <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
        <p class="font-semibold">Erreur: Seulement les fichiers PDF sont acceptés!</p>
      </div>
      <% } else if(error != null) { %>
      <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
        <p class="font-semibold">Une erreur est survenue. Veuillez réessayer.</p>
      </div>
      <% } %>

      <!-- CV List -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
          if(cvs != null && !cvs.isEmpty()) {
            for(Cv c : cvs) {
        %>
        <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 hover:shadow-md transition-shadow">
          <div class="flex items-start justify-between mb-4">
            <div class="w-14 h-14 rounded-lg bg-red-50 flex items-center justify-center">
              <span class="material-icons text-red-500 text-2xl">picture_as_pdf</span>
            </div>
            <span class="text-xs text-gray-500">Mis à jour le<br><%= sdf.format(c.getDateMiseAJour()) %></span>
          </div>

          <h3 class="text-lg font-bold text-gray-800 mb-1"><%= c.getTitre() %></h3>
          <% if(c.getCompetences() != null && !c.getCompetences().isEmpty()) { %>
          <p class="text-sm text-gray-500 mb-4 line-clamp-2"><%= c.getCompetences() %></p>
          <% } %>

          <div class="flex gap-2">
            <a href="<%= request.getContextPath() + "/" + c.getCheminFichier() %>" target="_blank"
               class="flex-1 px-3 py-2 bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-100 transition-colors text-sm font-medium flex items-center justify-center gap-1">
              <span class="material-icons text-sm">visibility</span>
              <span>Voir</span>
            </a>
            <a href="<%= request.getContextPath() + "/" + c.getCheminFichier() %>" download
               class="flex-1 px-3 py-2 bg-green-50 text-green-600 rounded-lg hover:bg-green-100 transition-colors text-sm font-medium flex items-center justify-center gap-1">
              <span class="material-icons text-sm">download</span>
              <span>Télécharger</span>
            </a>
            <form action="cv" method="post" onsubmit="return confirm('Supprimer ce CV?')">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="cvId" value="<%= c.getId() %>">
              <button type="submit" class="px-3 py-2 bg-red-50 text-red-600 rounded-lg hover:bg-red-100 transition-colors">
                <span class="material-icons text-sm">delete</span>
              </button>
            </form>
          </div>
        </div>
        <% } } else { %>
        <div class="col-span-full text-center py-16">
          <span class="material-icons text-6xl text-gray-300 mb-4">description</span>
          <h3 class="text-xl font-semibold text-gray-600 mb-2">Aucun CV</h3>
          <p class="text-gray-500 mb-6">Téléchargez votre CV en format PDF</p>
          <button onclick="document.getElementById('uploadModal').classList.remove('hidden')" class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors">
            <span class="material-icons">upload_file</span>
            <span>Télécharger mon CV</span>
          </button>
        </div>
        <% } %>
      </div>
    </div>
  </main>
</div>

<!-- Upload CV Modal -->
<div id="uploadModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-xl shadow-xl p-8 max-w-md w-full mx-4">
    <div class="flex items-center justify-between mb-6">
      <h2 class="text-xl font-bold text-gray-800">Télécharger un CV</h2>
      <button onclick="document.getElementById('uploadModal').classList.add('hidden')" class="text-gray-400 hover:text-gray-600">
        <span class="material-icons">close</span>
      </button>
    </div>

    <form action="cv" method="post" enctype="multipart/form-data" class="space-y-4">
      <input type="hidden" name="action" value="upload">

      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-2">Titre du CV</label>
        <input type="text" name="titre" required placeholder="Ex: CV Développeur Full Stack"
               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
      </div>

      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-2">Fichier CV (PDF uniquement)</label>
        <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-primary transition-colors"
             ondragover="event.preventDefault()" ondrop="handleDrop(event)">
          <span class="material-icons text-4xl text-gray-400 mb-2">picture_as_pdf</span>
          <p class="text-sm text-gray-600 mb-2">Glissez votre PDF ici ou</p>
          <label for="cvFile" class="px-4 py-2 bg-primary text-white rounded-lg cursor-pointer hover:bg-primary-dark text-sm">
            Choisir un fichier
          </label>
          <input type="file" id="cvFile" name="cvFile" accept=".pdf" required class="hidden" onchange="showFileName(this)">
          <p id="fileName" class="text-sm text-gray-500 mt-2">Aucun fichier choisi</p>
          <p class="text-xs text-gray-400 mt-1">PDF uniquement (max 10MB)</p>
        </div>
      </div>

      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-2">Compétences clés (optionnel)</label>
        <textarea name="competences" rows="3" placeholder="Ex: Java, Spring Boot, React, MySQL..."
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent resize-none"></textarea>
      </div>

      <div class="flex gap-3 pt-2">
        <button type="submit" class="flex-1 px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors font-semibold flex items-center justify-center gap-2">
          <span class="material-icons">upload</span>
          <span>Télécharger</span>
        </button>
        <button type="button" onclick="document.getElementById('uploadModal').classList.add('hidden')"
                class="px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-semibold">
          Annuler
        </button>
      </div>
    </form>
  </div>
</div>

<script>
  function showFileName(input) {
    const fileName = input.files[0] ? input.files[0].name : "Aucun fichier choisi";
    document.getElementById('fileName').textContent = fileName;
  }

  function handleDrop(event) {
    event.preventDefault();
    const file = event.dataTransfer.files[0];
    if (file && file.type === "application/pdf") {
      const input = document.getElementById('cvFile');
      input.files = event.dataTransfer.files;
      document.getElementById('fileName').textContent = file.name;
    } else {
      alert("Seulement les fichiers PDF sont acceptés!");
    }
  }
</script>
</body>
</html>