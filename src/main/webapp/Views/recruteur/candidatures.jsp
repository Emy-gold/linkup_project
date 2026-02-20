<%--
  Created by IntelliJ IDEA.
  User: Pro
  Date: 2/5/2026
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidatures Reçues - Linkup Recruteur</title>
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
<!--SideBar -->
<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="currentPage" value="candidatues"/>
</jsp:include>

<!-- Main Content -->
<div class="flex-1 flex flex-col">
    <!-- Header -->
    <jsp:include page="layout/header.jsp">
        <jsp:param name="pageTitle" value="Candidatures Reçues"/>
    </jsp:include>

    <!-- Content -->
    <main class="flex-1 overflow-y-auto px-8 py-8">
        <!-- Filtres -->
        <div class="mb-8 flex gap-4">
            <form method="get" action="${pageContext.request.contextPath}/recruteur/candidatures">
                <select name="statut"
                        onchange="this.form.submit()"
                        class="px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-primary bg-surface-light">

                    <option value="">Tous</option>

                    <option value="En_attente"
                    ${param.statut == 'En_attente' ? 'selected' : ''}>
                        En attente
                    </option>

                    <option value="Acceptee"
                    ${param.statut == 'Acceptee' ? 'selected' : ''}>
                        Acceptée
                    </option>

                    <option value="Rejetee"
                    ${param.statut == 'Rejetee' ? 'selected' : ''}>
                        Rejetée
                    </option>
                </select>
            </form>
        </div>

        <!-- Candidatures Table -->
        <div class="bg-surface-light border border-slate-200 rounded-lg overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Candidat</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Poste</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Date</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Statut</th>
                        <th class="px-6 py-4 text-left font-semibold text-slate-700">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">

                    <c:choose>
                        <c:when test="${not empty candidatures}">
                            <c:forEach var="cand" items="${candidatures}">

                                <tr class="hover:bg-slate-50 transition-colors" id="row-${cand.id}">

                                    <!-- CANDIDAT -->
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm">
                                                    ${cand.prenom.charAt(0)}${cand.nom.charAt(0)}
                                            </div>
                                            <div>
                                                <p class="font-medium text-slate-800">
                                                        ${cand.prenom} ${cand.nom}
                                                </p>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- POSTE -->
                                    <td class="px-6 py-4 text-slate-600">
                                            ${cand.posteOccupe}
                                    </td>

                                    <!-- DATE -->
                                    <td class="px-6 py-4 text-slate-600">
                                            ${cand.dateSoumission}
                                    </td>

                                    <!-- STATUT -->
                                    <td class="px-6 py-4" id="statut-${cand.id}">
                                        <c:choose>
                                            <c:when test="${cand.statutCandidature == 'En_attente'}">
                                                        <span class="px-3 py-1 bg-yellow-100 text-yellow-700 text-xs font-semibold rounded-full">
                                                            En attente
                                                        </span>
                                            </c:when>
                                            <c:when test="${cand.statutCandidature == 'Acceptee'}">
                                                        <span class="px-3 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">
                                                            Acceptée
                                                        </span>
                                            </c:when>
                                            <c:when test="${cand.statutCandidature == 'Rejetee'}">
                                                        <span class="px-3 py-1 bg-red-100 text-red-700 text-xs font-semibold rounded-full">
                                                            Rejetée
                                                        </span>
                                            </c:when>
                                        </c:choose>
                                    </td>

                                    <!-- ACTIONS -->
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-2" id="actions-${cand.id}">

                                            <!-- Voir CV -->
                                            <button onclick="openPdfModal('${pageContext.request.contextPath}/${cand.cheminCv}')"
                                                    class="inline-flex items-center justify-center p-2.5 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors duration-200 hover:shadow-sm"
                                                    title="Voir CV">
                                                <i class="fas fa-file-pdf text-lg"></i>
                                            </button>

                                            <!-- Boutons seulement si En attente -->
                                            <c:if test="${cand.statutCandidature == 'En_attente'}">

                                                <!-- ACCEPTER -->
                                                <button onclick="updateStatut(${cand.id}, 'Acceptee')"
                                                        class="inline-flex items-center justify-center p-2.5 text-green-600 hover:bg-green-50 rounded-lg transition-colors duration-200 hover:shadow-sm hover:scale-110"
                                                        title="Accepter la candidature">
                                                    <i class="fas fa-check text-lg"></i>
                                                </button>

                                                <!-- REJETER -->
                                                <button onclick="updateStatut(${cand.id}, 'Rejetee')"
                                                        class="inline-flex items-center justify-center p-2.5 text-red-600 hover:bg-red-50 rounded-lg transition-colors duration-200 hover:shadow-sm hover:scale-110"
                                                        title="Rejeter la candidature">
                                                    <i class="fas fa-times text-lg"></i>
                                                </button>

                                            </c:if>

                                        </div>
                                    </td>
                                </tr>

                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="px-6 py-12 text-center">
                                    <i class="fas fa-inbox text-5xl text-slate-300 mb-3 block"></i>
                                    <p class="text-slate-600 font-medium">
                                        Aucune candidature reçue
                                    </p>
                                </td>
                            </tr>
                        </c:otherwise>

                    </c:choose>

                    </tbody>
                </table>
            </div>
        </div>

    </main>
        <!-- Footer -->
        <jsp:include page="layout/footer.jsp"/>
    </div>


<!-- Modal PDF -->
<div id="pdfModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] flex flex-col">
        <!-- Header Modal -->
        <div class="flex items-center justify-between p-6 border-b border-slate-200">
            <h2 class="text-xl font-bold text-slate-900">Visualiser CV</h2>
            <button onclick="closePdfModal()" class="text-slate-500 hover:text-slate-700 transition-colors">
                <i class="fas fa-times text-2xl"></i>
            </button>
        </div>

        <!-- PDF Container -->
        <div class="flex-1 overflow-auto">
            <iframe id="pdfViewer" src="" class="w-full h-full border-0"></iframe>
        </div>

        <!-- Footer Modal -->
        <div class="flex items-center justify-end gap-3 p-6 border-t border-slate-200">
            <a id="pdfDownloadBtn" href="#" download class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                <i class="fas fa-download mr-2"></i>Télécharger
            </a>
            <button onclick="closePdfModal()" class="px-4 py-2 bg-slate-200 text-slate-800 rounded-lg hover:bg-slate-300 transition-colors">
                Fermer
            </button>
        </div>
    </div>
</div>


    <script>
        // ============================================
        // Fonctions pour gérer le modal PDF
        // ============================================
        function openPdfModal(pdfPath) {
            const modal = document.getElementById('pdfModal');
            const viewer = document.getElementById('pdfViewer');
            const downloadBtn = document.getElementById('pdfDownloadBtn');

            viewer.src = pdfPath;
            downloadBtn.href = pdfPath;
            modal.classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }

        function closePdfModal() {
            const modal = document.getElementById('pdfModal');
            modal.classList.add('hidden');
            document.body.style.overflow = 'auto';
        }

        // Fermer le modal en cliquant en dehors
        document.getElementById('pdfModal')?.addEventListener('click', function(e) {
            if (e.target === this) {
                closePdfModal();
            }
        });

        // ============================================
        // Fonction pour mettre à jour le statut
        // ============================================
        function updateStatut(candidatureId, nouveauStatut) {
            // Confirmation avant action
            const confirmText = nouveauStatut === 'Acceptee'
                ? 'Voulez-vous accepter cette candidature ?'
                : 'Voulez-vous rejeter cette candidature ?';

            if (!confirm(confirmText)) {
                return;
            }

            // Envoi AJAX
            fetch('${pageContext.request.contextPath}/recruteur/candidatures', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'action': 'updateStatut',
                    'id': candidatureId,
                    'statut': nouveauStatut
                })
            })
                .then(response => {
                    if (response.ok) {
                        // Mise à jour du DOM sans rechargement
                        updateStatutInDOM(candidatureId, nouveauStatut);
                        showNotification(`Candidature ${nouveauStatut}`, 'success');
                    } else {
                        showNotification('Erreur lors de la mise à jour', 'error');
                    }
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    showNotification('Erreur réseau', 'error');
                });
        }

        // Mettre à jour le statut dans le DOM
        function updateStatutInDOM(candidatureId, nouveauStatut) {
            const statutCell = document.getElementById(`statut-${candidatureId}`);
            const actionsCell = document.getElementById(`actions-${candidatureId}`);

            if (!statutCell) return;

            // Déterminer les couleurs selon le statut
            let bgColor = '';
            let textColor = '';
            let displayText = '';

            if (nouveauStatut === 'Acceptee') {
                bgColor = 'bg-green-100';
                textColor = 'text-green-700';
                displayText = 'Acceptée';
            } else if (nouveauStatut === 'Rejetee') {
                bgColor = 'bg-red-100';
                textColor = 'text-red-700';
                displayText = 'Rejetee';
            }

            // Mettre à jour le statut
            statutCell.innerHTML = `<span class="px-3 py-1 ${bgColor} ${textColor} text-xs font-semibold rounded-full">${displayText}</span>`;

            // Supprimer les boutons d'action
            if (actionsCell) {
                // Garder seulement le bouton PDF
                const pdfButton = actionsCell.querySelector('button:first-child');
                actionsCell.innerHTML = '';
                if (pdfButton) {
                    actionsCell.appendChild(pdfButton);
                }
            }
        }

        // ============================================
        // Notification Toast
        // ============================================
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `fixed bottom-4 right-4 px-6 py-3 rounded-lg text-white font-semibold z-50 transition-all duration-300 ${
            type == 'success' ? 'bg-green-600' : type == 'error' ? 'bg-red-600' : 'bg-blue-600'
        }`;
            notification.textContent = message;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.classList.add('opacity-0', 'translate-y-2');
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }
    </script>

</body>
</html>
