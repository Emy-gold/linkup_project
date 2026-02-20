<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="Models.Diplome" %>
            <%@ page import="Models.Universite" %>
                <%@ page import="Models.utilisateur" %>

                    <% Universite universite=(Universite) request.getAttribute("universite"); List<Diplome>
                        diplomesEnAttente = (List<Diplome>)
                            request.getAttribute("diplomesEnAttente");
                            List<Diplome> diplomesHistorique = (List<Diplome>)
                                    request.getAttribute("diplomesHistorique");

                                    // Récupérer l'utilisateur en session
                                    utilisateur user = (utilisateur) session.getAttribute("user");

                                    // Sécurité: Redirection si les objets requis sont absents
                                    if (user == null) {
                                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                                    return;
                                    }
                                    if (universite == null) {
                                    response.sendRedirect(request.getContextPath() + "/universite-complete-profile");
                                    return;
                                    }

                                    // Statistiques pour les compteurs
                                    int pendingCount = (diplomesEnAttente != null) ? diplomesEnAttente.size() : 0;
                                    int historyCount = (diplomesHistorique != null) ? diplomesHistorique.size() : 0;
                                    int totalCount = pendingCount + historyCount;
                                    %>

                                    <!DOCTYPE html>
                                    <html lang="fr">

                                    <head>
                                        <meta charset="UTF-8">
                                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                        <title>Tableau de Bord - <%= universite.getNomUniversite() %>
                                        </title>
                                        <link
                                            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                                            rel="stylesheet">
                                        <style>
                                            :root {
                                                --primary-color: #1e4d3b;
                                                --secondary-color: #2a6b52;
                                                --accent-color: #e8f5e9;
                                                --text-dark: #2c3e50;
                                                --text-light: #95a5a6;
                                                --white: #ffffff;
                                                --background: #f4f7f6;
                                                --custom-green: #348E1C;
                                                --shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                                                --border-radius: 12px;
                                                --danger-color: #e74c3c;
                                                --danger-bg: #fde8e7;
                                                --success-color: #27ae60;
                                                --success-bg: #eafaf1;
                                            }

                                            * {
                                                margin: 0;
                                                padding: 0;
                                                box-sizing: border-box;
                                                font-family: 'Inter', sans-serif;
                                            }

                                            body {
                                                background-color: var(--background);
                                                display: flex;
                                                min-height: 100vh;
                                                color: var(--text-dark);
                                            }

                                            /* Sidebar */
                                            .sidebar {
                                                width: 260px;
                                                background-color: var(--white);
                                                padding: 2rem;
                                                display: flex;
                                                flex-direction: column;
                                                position: fixed;
                                                height: 100vh;
                                                z-index: 100;
                                                border-right: 1px solid rgba(0, 0, 0, 0.05);
                                                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.02);
                                            }

                                            .logo {
                                                display: flex;
                                                justify-content: center;
                                                align-items: center;
                                                margin-bottom: 3rem;
                                                padding: 1rem 0;
                                            }

                                            .logo img {
                                                max-width: 100%;
                                                height: auto;
                                                display: block;
                                            }

                                            .nav-link {
                                                display: flex;
                                                align-items: center;
                                                padding: 1rem;
                                                color: var(--text-light);
                                                text-decoration: none;
                                                border-radius: 8px;
                                                margin-bottom: 0.5rem;
                                                transition: all 0.3s;
                                                font-weight: 500;
                                            }

                                            .nav-link:hover {
                                                background-color: rgba(0, 0, 0, 0.03);
                                                color: var(--text-dark);
                                            }

                                            .nav-link.active {
                                                background-color: var(--accent-color);
                                                color: var(--custom-green);
                                            }

                                            .nav-link svg {
                                                margin-right: 12px;
                                            }

                                            .logout-btn {
                                                margin-top: auto;
                                                background-color: transparent;
                                                color: var(--custom-green);
                                                border: 1px solid var(--custom-green);
                                                padding: 0.8rem 1rem;
                                                border-radius: 8px;
                                                cursor: pointer;
                                                display: flex;
                                                align-items: center;
                                                justify-content: flex-start;
                                                text-decoration: none;
                                                transition: all 0.3s;
                                                font-weight: 500;
                                                gap: 10px;
                                            }

                                            .logout-btn:hover {
                                                background-color: var(--accent-color);
                                            }

                                            .logout-btn svg {
                                                stroke: var(--custom-green);
                                            }

                                            /* Main Content area */
                                            .main-container {
                                                flex: 1;
                                                margin-left: 260px;
                                                display: flex;
                                                flex-direction: column;
                                            }

                                            /* Top Bar */
                                            .top-navbar {
                                                display: flex;
                                                justify-content: space-between;
                                                align-items: center;
                                                background: var(--white);
                                                padding: 1rem 2rem;
                                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                                                border-bottom: 1px solid rgba(0, 0, 0, 0.03);
                                                position: sticky;
                                                top: 0;
                                                z-index: 90;
                                            }

                                            .navbar-title {
                                                display: flex;
                                                align-items: center;
                                                gap: 10px;
                                                font-weight: 600;
                                                font-size: 1.1rem;
                                            }

                                            .navbar-title svg {
                                                color: var(--custom-green);
                                            }

                                            .user-profile {
                                                display: flex;
                                                align-items: center;
                                                gap: 15px;
                                            }

                                            .user-info {
                                                text-align: right;
                                            }

                                            .user-name {
                                                display: block;
                                                font-weight: 600;
                                                font-size: 0.95rem;
                                            }

                                            .user-role {
                                                display: block;
                                                color: var(--text-light);
                                                font-size: 0.8rem;
                                            }

                                            .avatar {
                                                width: 42px;
                                                height: 42px;
                                                background-color: #f0f0f0;
                                                border-radius: 50%;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                font-weight: bold;
                                                font-size: 1rem;
                                                border: 2px solid var(--white);
                                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                            }

                                            .user-profile-link {
                                                text-decoration: none;
                                                color: inherit;
                                                display: flex;
                                                align-items: center;
                                                padding: 5px 10px;
                                                border-radius: 8px;
                                                transition: background-color 0.2s;
                                            }

                                            .user-profile-link:hover {
                                                background-color: var(--accent-color);
                                            }

                                            /* Page Content */
                                            .page-content {
                                                padding: 2.5rem;
                                                display: flex;
                                                flex-direction: column;
                                                gap: 2.5rem;
                                            }

                                            /* Stats Section */
                                            .stats-row {
                                                display: grid;
                                                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                                                gap: 1.5rem;
                                            }

                                            .stat-box {
                                                background: var(--white);
                                                border-radius: var(--border-radius);
                                                padding: 1.5rem;
                                                box-shadow: var(--shadow);
                                                border: 1px solid rgba(0, 0, 0, 0.05);
                                                display: flex;
                                                align-items: center;
                                                gap: 1.2rem;
                                            }

                                            .stat-circle {
                                                width: 48px;
                                                height: 48px;
                                                border-radius: 12px;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                font-size: 1.4rem;
                                            }

                                            .stat-circle.orange {
                                                background-color: #fff3e0;
                                                color: #f39c12;
                                            }

                                            .stat-circle.green {
                                                background-color: var(--accent-color);
                                                color: var(--custom-green);
                                            }

                                            .stat-circle.blue {
                                                background-color: #e3f2fd;
                                                color: #3498db;
                                            }

                                            .stat-details .value {
                                                font-size: 1.6rem;
                                                font-weight: 700;
                                                display: block;
                                            }

                                            .stat-details .label {
                                                font-size: 0.85rem;
                                                color: var(--text-light);
                                                text-transform: uppercase;
                                                letter-spacing: 0.5px;
                                            }

                                            /* Tables and Grid */
                                            .content-grid {
                                                display: grid;
                                                grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
                                                gap: 2rem;
                                            }

                                            .section-card {
                                                display: flex;
                                                flex-direction: column;
                                                gap: 1rem;
                                            }

                                            .section-card h3 {
                                                display: flex;
                                                align-items: center;
                                                gap: 10px;
                                                font-size: 1.1rem;
                                            }

                                            .data-table-wrapper {
                                                background: var(--white);
                                                border-radius: var(--border-radius);
                                                box-shadow: var(--shadow);
                                                overflow: hidden;
                                                border: 1px solid rgba(0, 0, 0, 0.05);
                                            }

                                            table {
                                                width: 100%;
                                                border-collapse: collapse;
                                            }

                                            th {
                                                padding: 1rem 1.5rem;
                                                text-align: left;
                                                font-size: 0.8rem;
                                                font-weight: 600;
                                                color: var(--text-light);
                                                text-transform: uppercase;
                                                background: #fcfcfc;
                                                border-bottom: 1px solid #eee;
                                            }

                                            td {
                                                padding: 1.2rem 1.5rem;
                                                border-bottom: 1px solid #f5f5f5;
                                                font-size: 0.95rem;
                                                vertical-align: middle;
                                            }

                                            tr:last-child td {
                                                border-bottom: none;
                                            }

                                            tr:hover {
                                                background-color: #fafafa;
                                            }

                                            /* Badges & Actions */
                                            .badge {
                                                display: inline-flex;
                                                align-items: center;
                                                padding: 4px 12px;
                                                border-radius: 20px;
                                                font-size: 0.8rem;
                                                font-weight: 600;
                                                gap: 6px;
                                            }

                                            .badge-success {
                                                background-color: var(--success-bg);
                                                color: var(--success-color);
                                            }

                                            .badge-danger {
                                                background-color: var(--danger-bg);
                                                color: var(--danger-color);
                                            }

                                            .btn-small {
                                                border: none;
                                                padding: 8px 14px;
                                                border-radius: 8px;
                                                cursor: pointer;
                                                font-size: 0.85rem;
                                                font-weight: 600;
                                                transition: all 0.2s;
                                                display: inline-flex;
                                                align-items: center;
                                                gap: 6px;
                                            }

                                            .btn-approve {
                                                background-color: var(--accent-color);
                                                color: var(--custom-green);
                                            }

                                            .btn-approve:hover {
                                                background-color: var(--custom-green);
                                                color: var(--white);
                                            }

                                            .btn-deny {
                                                background-color: #fff1f0;
                                                color: #cf1322;
                                            }

                                            .btn-deny:hover {
                                                background-color: #cf1322;
                                                color: var(--white);
                                            }

                                            .no-data {
                                                padding: 3rem;
                                                text-align: center;
                                                color: var(--text-light);
                                                font-style: italic;
                                            }

                                            .alert-box {
                                                background-color: var(--danger-bg);
                                                color: var(--danger-color);
                                                padding: 1rem 1.5rem;
                                                border-radius: 10px;
                                                margin-bottom: 1.5rem;
                                                display: flex;
                                                align-items: center;
                                                gap: 12px;
                                                border: 1px solid rgba(231, 76, 60, 0.15);
                                            }

                                            /* Modal Styles */
                                            .modal-overlay {
                                                display: none;
                                                position: fixed;
                                                top: 0;
                                                left: 0;
                                                width: 100%;
                                                height: 100%;
                                                background: rgba(0, 0, 0, 0.7);
                                                backdrop-filter: blur(5px);
                                                z-index: 1000;
                                                justify-content: center;
                                                align-items: center;
                                                padding: 20px;
                                            }

                                            .modal-content {
                                                background: var(--white);
                                                width: 100%;
                                                max-width: 900px;
                                                height: 85vh;
                                                border-radius: var(--border-radius);
                                                position: relative;
                                                display: flex;
                                                flex-direction: column;
                                                overflow: hidden;
                                                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
                                            }

                                            .modal-header {
                                                padding: 1.2rem 1.5rem;
                                                border-bottom: 1px solid #eee;
                                                display: flex;
                                                justify-content: space-between;
                                                align-items: center;
                                            }

                                            .modal-header h3 {
                                                font-size: 1.1rem;
                                                color: var(--text-dark);
                                            }

                                            .close-modal {
                                                background: none;
                                                border: none;
                                                font-size: 1.8rem;
                                                cursor: pointer;
                                                color: var(--text-light);
                                                transition: color 0.2s;
                                            }

                                            .close-modal:hover {
                                                color: var(--danger-color);
                                            }

                                            .document-viewer {
                                                flex: 1;
                                                width: 100%;
                                                height: 100%;
                                                border: none;
                                            }

                                            .viewer-img {
                                                width: 100%;
                                                height: 100%;
                                                object-fit: contain;
                                                background: #f0f0f0;
                                            }

                                            .btn-view {
                                                padding: 6px 12px;
                                                background: #f0f7ff;
                                                color: #007bff;
                                                border: 1px solid #007bff20;
                                                border-radius: 6px;
                                                font-size: 0.85rem;
                                                display: inline-flex;
                                                align-items: center;
                                                gap: 5px;
                                                text-decoration: none;
                                                transition: all 0.2s;
                                                cursor: pointer;
                                            }

                                            .btn-view:hover {
                                                background: #007bff;
                                                color: white;
                                            }
                                        </style>
                                    </head>

                                    <body>
                                        <!-- Sidebar Navigation -->
                                        <div class="sidebar">
                                            <div class="logo">
                                                <img src="<%= request.getContextPath() %>/assets/logo.png" alt="LinkUp">
                                            </div>
                                            <nav>
                                                <a href="#" class="nav-link active">
                                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                                        <line x1="3" y1="9" x2="21" y2="9"></line>
                                                        <line x1="9" y1="21" x2="9" y2="9"></line>
                                                    </svg>
                                                    Tableau de Bord
                                                </a>
                                            </nav>
                                            <a href="<%= request.getContextPath() %>/Logout" class="logout-btn">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                                    <polyline points="16 17 21 12 16 7"></polyline>
                                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                                </svg>
                                                Déconnexion
                                            </a>
                                        </div>

                                        <div class="main-container">
                                            <!-- Top Horizontal Navbar -->
                                            <header class="top-navbar">
                                                <div class="navbar-title">
                                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                                                        stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path d="M3 21h18"></path>
                                                        <path d="M5 21V7l8-4 8 4v14"></path>
                                                        <path d="M17 21v-8.5a1.5 1.5 0 0 0-3 0V21"></path>
                                                        <path d="M9 21v-2"></path>
                                                    </svg>
                                                    <%= universite.getNomUniversite() %> (ID: <%=
                                                            universite.getIdUtilisateur() %>)
                                                </div>
                                                <a href="<%= request.getContextPath() %>/agent-profile"
                                                    class="user-profile-link">
                                                    <div class="user-profile">
                                                        <div class="user-info">
                                                            <span class="user-name">
                                                                <%= user.getPrenom() %>
                                                                    <%= user.getNom() %>
                                                            </span>
                                                            <span class="user-role">Administrateur Universitaire</span>
                                                        </div>
                                                        <div class="avatar">
                                                            <%= user.getInitiales() %>
                                                        </div>
                                                    </div>
                                                </a>
                                            </header>

                                            <!-- Main Fluid Content -->
                                            <main class="page-content">
                                                <% String error=(String) request.getAttribute("error"); %>
                                                    <% if (error !=null) { %>
                                                        <div class="alert-box">
                                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <circle cx="12" cy="12" r="10"></circle>
                                                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                                            </svg>
                                                            <%= error %>
                                                        </div>
                                                        <% } %>

                                                            <!-- Statistics Grid -->
                                                            <section class="stats-row">
                                                                <div class="stat-box">
                                                                    <div class="stat-circle orange">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24"
                                                                            fill="none" stroke="currentColor"
                                                                            stroke-width="2" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <circle cx="12" cy="12" r="10"></circle>
                                                                            <polyline points="12 6 12 12 16 14">
                                                                            </polyline>
                                                                        </svg>
                                                                    </div>
                                                                    <div class="stat-details">
                                                                        <span class="value">
                                                                            <%= pendingCount %>
                                                                        </span>
                                                                        <span class="label">En Attente</span>
                                                                    </div>
                                                                </div>
                                                                <div class="stat-box">
                                                                    <div class="stat-circle green">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24"
                                                                            fill="none" stroke="currentColor"
                                                                            stroke-width="2" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <polyline points="20 6 9 17 4 12">
                                                                            </polyline>
                                                                        </svg>
                                                                    </div>
                                                                    <div class="stat-details">
                                                                        <span class="value">
                                                                            <%= historyCount %>
                                                                        </span>
                                                                        <span class="label">Validés/Rejetés</span>
                                                                    </div>
                                                                </div>
                                                                <div class="stat-box">
                                                                    <div class="stat-circle blue">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24"
                                                                            fill="none" stroke="currentColor"
                                                                            stroke-width="2" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <path
                                                                                d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z">
                                                                            </path>
                                                                            <polyline points="14 2 14 8 20 8">
                                                                            </polyline>
                                                                            <line x1="16" y1="13" x2="8" y2="13"></line>
                                                                            <line x1="16" y1="17" x2="8" y2="17"></line>
                                                                        </svg>
                                                                    </div>
                                                                    <div class="stat-details">
                                                                        <span class="value">
                                                                            <%= totalCount %>
                                                                        </span>
                                                                        <span class="label">Total Reçus</span>
                                                                    </div>
                                                                </div>
                                                            </section>

                                                            <!-- Data Tables -->
                                                            <div class="content-grid">
                                                                <!-- Pending Validation Requests -->
                                                                <section class="section-card">
                                                                    <h3>
                                                                        <svg width="20" height="20" viewBox="0 0 24 24"
                                                                            fill="none" stroke="#f39c12"
                                                                            stroke-width="2.5" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <circle cx="12" cy="12" r="10"></circle>
                                                                            <line x1="12" y1="8" x2="12" y2="12"></line>
                                                                            <line x1="12" y1="16" x2="12.01" y2="16">
                                                                            </line>
                                                                        </svg>
                                                                        Diplômes à vérifier
                                                                    </h3>
                                                                    <div class="data-table-wrapper">
                                                                        <% if (diplomesEnAttente !=null &&
                                                                            !diplomesEnAttente.isEmpty()) { %>
                                                                            <table>
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Libellé</th>
                                                                                        <th>Candidat</th>
                                                                                        <th>Justificatif</th>
                                                                                        <th>Actions</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (Diplome d :
                                                                                        diplomesEnAttente) { %>
                                                                                        <tr>
                                                                                            <td><strong>
                                                                                                    <%= d.getLibelle()
                                                                                                        %>
                                                                                                </strong></td>
                                                                                            <td>ID #<%=
                                                                                                    d.getId_candidat()
                                                                                                    %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <button type="button"
                                                                                                    class="btn-view"
                                                                                                    onclick="viewDocument('<%= request.getContextPath() %>/<%= d.getDocument_justificatif() %>', '<%= d.getLibelle() %>')">
                                                                                                    <svg width="14"
                                                                                                        height="14"
                                                                                                        viewBox="0 0 24 24"
                                                                                                        fill="none"
                                                                                                        stroke="currentColor"
                                                                                                        stroke-width="2"
                                                                                                        stroke-linecap="round"
                                                                                                        stroke-linejoin="round">
                                                                                                        <path
                                                                                                            d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z">
                                                                                                        </path>
                                                                                                        <circle cx="12"
                                                                                                            cy="12"
                                                                                                            r="3">
                                                                                                        </circle>
                                                                                                    </svg>
                                                                                                    Voir le diplôme
                                                                                                </button>
                                                                                            </td>
                                                                                            <td
                                                                                                style="white-space: nowrap;">
                                                                                                <form
                                                                                                    action="<%= request.getContextPath() %>/universite-dashboard"
                                                                                                    method="post"
                                                                                                    style="display:inline;">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="valider">
                                                                                                    <input type="hidden"
                                                                                                        name="id_diplome"
                                                                                                        value="<%= d.getId_diplome() %>">
                                                                                                    <input type="hidden"
                                                                                                        name="id_universite"
                                                                                                        value="<%= universite.getId_universite() %>">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn-small btn-approve"
                                                                                                        onclick="return confirm('Confirmer la validation ?')">Valider</button>
                                                                                                </form>
                                                                                                <form
                                                                                                    action="<%= request.getContextPath() %>/universite-dashboard"
                                                                                                    method="post"
                                                                                                    style="display:inline; margin-left: 5px;">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="rejeter">
                                                                                                    <input type="hidden"
                                                                                                        name="id_diplome"
                                                                                                        value="<%= d.getId_diplome() %>">
                                                                                                    <input type="hidden"
                                                                                                        name="id_universite"
                                                                                                        value="<%= universite.getId_universite() %>">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn-small btn-deny"
                                                                                                        onclick="return confirm('Confirmer le rejet ?')">Rejeter</button>
                                                                                                </form>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                            <% } else { %>
                                                                                <div class="no-data">Aucune demande en
                                                                                    attente.</div>
                                                                                <% } %>
                                                                    </div>
                                                                </section>

                                                                <!-- Processed History -->
                                                                <section class="section-card">
                                                                    <h3>
                                                                        <svg width="20" height="20" viewBox="0 0 24 24"
                                                                            fill="none" stroke="var(--text-light)"
                                                                            stroke-width="2.5" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <path
                                                                                d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                            </path>
                                                                        </svg>
                                                                        Traités récemment
                                                                    </h3>
                                                                    <div class="data-table-wrapper">
                                                                        <% if (diplomesHistorique !=null &&
                                                                            !diplomesHistorique.isEmpty()) { %>
                                                                            <table>
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Diplôme</th>
                                                                                        <th>Date Traitement</th>
                                                                                        <th>Statut</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (Diplome d :
                                                                                        diplomesHistorique) { String
                                                                                        status=d.getStatut_validation()
                                                                                        !=null ?
                                                                                        d.getStatut_validation().toUpperCase()
                                                                                        : "" ; boolean isOk="VALIDE"
                                                                                        .equals(status) || "VALIDÉ"
                                                                                        .equals(status); String
                                                                                        badgeClass=isOk
                                                                                        ? "badge-success"
                                                                                        : "badge-danger" ; String
                                                                                        symbol=isOk ? "✓" : "✕" ; %>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <div
                                                                                                    style="font-weight: 600;">
                                                                                                    <%= d.getLibelle()
                                                                                                        %>
                                                                                                </div>
                                                                                                <div
                                                                                                    style="display: flex; align-items: center; gap: 10px; margin-top: 5px;">
                                                                                                    <span
                                                                                                        style="font-size: 0.8rem; color: #999;">Candidat
                                                                                                        #<%= d.getId_candidat()
                                                                                                            %></span>
                                                                                                    <button
                                                                                                        type="button"
                                                                                                        class="btn-view"
                                                                                                        style="padding: 2px 8px; font-size: 0.75rem;"
                                                                                                        onclick="viewDocument('<%= request.getContextPath() %>/<%= d.getDocument_justificatif() %>', '<%= d.getLibelle() %>')">
                                                                                                        <svg width="12"
                                                                                                            height="12"
                                                                                                            viewBox="0 0 24 24"
                                                                                                            fill="none"
                                                                                                            stroke="currentColor"
                                                                                                            stroke-width="2"
                                                                                                            stroke-linecap="round"
                                                                                                            stroke-linejoin="round">
                                                                                                            <path
                                                                                                                d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z">
                                                                                                            </path>
                                                                                                            <circle
                                                                                                                cx="12"
                                                                                                                cy="12"
                                                                                                                r="3">
                                                                                                            </circle>
                                                                                                        </svg>
                                                                                                        Voir
                                                                                                    </button>
                                                                                                </div>
                                                                                            </td>
                                                                                            <td><span
                                                                                                    style="font-size: 0.9rem;">
                                                                                                    <%= (d.getDate_traitement()
                                                                                                        !=null) ?
                                                                                                        d.getDate_traitement()
                                                                                                        : "-" %>
                                                                                                </span></td>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge <%= badgeClass %>">
                                                                                                    <%= symbol %>
                                                                                                        <%= d.getStatut_validation()
                                                                                                            %>
                                                                                                </span>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                            <% } else { %>
                                                                                <div class="no-data">Aucun historique
                                                                                    disponible.</div>
                                                                                <% } %>
                                                                    </div>
                                                                </section>
                                                            </div>
                                            </main>
                                        </div>

                                        <!-- Modal de Visualisation -->
                                        <div id="documentModal" class="modal-overlay">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h3 id="modalTitle">Justificatif de Diplôme</h3>
                                                    <button class="close-modal" onclick="closeModal()">&times;</button>
                                                </div>
                                                <div id="viewerContainer" style="flex: 1; overflow: hidden;">
                                                    <!-- L'iframe ou l'image sera injecté ici -->
                                                </div>
                                            </div>
                                        </div>

                                        <script>
                                            function viewDocument(url, title) {
                                                const modal = document.getElementById('documentModal');
                                                const container = document.getElementById('viewerContainer');
                                                const modalTitle = document.getElementById('modalTitle');

                                                modalTitle.textContent = "Justificatif : " + title;

                                                // Nettoyer le conteneur
                                                container.innerHTML = '';

                                                const fileExtension = url.split('.').pop().toLowerCase();

                                                if (fileExtension === 'pdf') {
                                                    const iframe = document.createElement('iframe');
                                                    iframe.src = url;
                                                    iframe.className = 'document-viewer';
                                                    container.appendChild(iframe);
                                                } else {
                                                    const img = document.createElement('img');
                                                    img.src = url;
                                                    img.className = 'viewer-img';
                                                    container.appendChild(img);
                                                }

                                                modal.style.display = 'flex';
                                            }

                                            function closeModal() {
                                                const modal = document.getElementById('documentModal');
                                                modal.style.display = 'none';
                                            }

                                            // Fermer le modal en cliquant en dehors
                                            window.onclick = function (event) {
                                                const modal = document.getElementById('documentModal');
                                                if (event.target == modal) {
                                                    closeModal();
                                                }
                                            }
                                        </script>
                                    </body>

                                    </html>