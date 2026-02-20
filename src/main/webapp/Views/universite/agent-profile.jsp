<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="Models.Universite" %>
        <%@ page import="Models.utilisateur" %>
            <% Universite universite=(Universite) request.getAttribute("universite"); utilisateur user=(utilisateur)
                request.getAttribute("user"); if (user==null) { response.sendRedirect(request.getContextPath()
                + "/login.jsp" ); return; } %>
                <!DOCTYPE html>
                <html lang="fr">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Mon Profil - LinkUp</title>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
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
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: 'Inter', sans-serif;
                        }

                        body {
                            background-color: var(--background);
                            color: var(--text-dark);
                            display: flex;
                            min-height: 100vh;
                        }

                        /* Sidebar simple pour rester cohérent */
                        .sidebar {
                            width: 260px;
                            background-color: var(--white);
                            padding: 2rem;
                            display: flex;
                            flex-direction: column;
                            position: fixed;
                            height: 100vh;
                            border-right: 1px solid rgba(0, 0, 0, 0.05);
                        }

                        .logo {
                            display: flex;
                            justify-content: center;
                            margin-bottom: 3rem;
                        }

                        .logo img {
                            max-width: 150px;
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

                        .nav-link:hover,
                        .nav-link.active {
                            background-color: var(--accent-color);
                            color: var(--custom-green);
                        }

                        .main-content {
                            flex: 1;
                            margin-left: 260px;
                            padding: 2.5rem;
                        }

                        .header {
                            margin-bottom: 2rem;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .profile-container {
                            max-width: 800px;
                            background: var(--white);
                            border-radius: var(--border-radius);
                            box-shadow: var(--shadow);
                            padding: 2rem;
                        }

                        .profile-header {
                            display: flex;
                            align-items: center;
                            gap: 2rem;
                            margin-bottom: 2rem;
                            padding-bottom: 2rem;
                            border-bottom: 1px solid #eee;
                        }

                        .profile-avatar {
                            width: 100px;
                            height: 100px;
                            background: var(--accent-color);
                            color: var(--custom-green);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 2.5rem;
                            font-weight: 700;
                            border: 4px solid var(--white);
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                        }

                        .profile-title h1 {
                            font-size: 1.8rem;
                            margin-bottom: 0.5rem;
                        }

                        .profile-title span {
                            color: var(--text-light);
                            font-size: 1rem;
                        }

                        .info-grid {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 2rem;
                        }

                        .info-group {
                            margin-bottom: 1.5rem;
                        }

                        .info-label {
                            display: block;
                            font-size: 0.85rem;
                            color: var(--text-light);
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            margin-bottom: 0.5rem;
                        }

                        .info-value {
                            font-size: 1.1rem;
                            font-weight: 500;
                            color: var(--text-dark);
                        }

                        .section-title {
                            grid-column: 1 / -1;
                            font-size: 1.2rem;
                            font-weight: 600;
                            margin-top: 1rem;
                            margin-bottom: 1rem;
                            color: var(--custom-green);
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .back-btn {
                            display: inline-flex;
                            align-items: center;
                            gap: 8px;
                            color: var(--text-light);
                            text-decoration: none;
                            margin-bottom: 1.5rem;
                            transition: color 0.2s;
                        }

                        .back-btn:hover {
                            color: var(--custom-green);
                        }
                    </style>
                </head>

                <body>
                    <div class="sidebar">
                        <div class="logo">
                            <img src="<%= request.getContextPath() %>/assets/logo.png" alt="LinkUp">
                        </div>
                        <nav>
                            <a href="<%= request.getContextPath() %>/universite-dashboard" class="nav-link">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                    <line x1="3" y1="9" x2="21" y2="9"></line>
                                    <line x1="9" y1="21" x2="9" y2="9"></line>
                                </svg>
                                Tableau de Bord
                            </a>
                            <a href="#" class="nav-link active">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                                Mon Profil
                            </a>
                        </nav>
                    </div>

                    <main class="main-content">
                        <div class="header">
                            <a href="<%= request.getContextPath() %>/universite-dashboard" class="back-btn">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="19" y1="12" x2="5" y2="12"></line>
                                    <polyline points="12 19 5 12 12 5"></polyline>
                                </svg>
                                Retour au tableau de bord
                            </a>
                        </div>

                        <div class="profile-container">
                            <div class="profile-header">
                                <div class="profile-avatar">
                                    <%= user.getInitiales() %>
                                </div>
                                <div class="profile-title">
                                    <h1>
                                        <%= user.getPrenom() %>
                                            <%= user.getNom() %>
                                    </h1>
                                    <span>Agent Universitaire</span>
                                </div>
                            </div>

                            <div class="info-grid">
                                <h2 class="section-title">Informations Personnelles</h2>

                                <div class="info-group">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">
                                        <%= user.getEmail() %>
                                    </span>
                                </div>

                                <div class="info-group">
                                    <span class="info-label">Date d'inscription</span>
                                    <span class="info-value">
                                        <%= user.getDate() %>
                                    </span>
                                </div>

                                <div class="info-group">
                                    <span class="info-label">Statut du compte</span>
                                    <span class="info-value">
                                        <%= user.getStatutCompte() %>
                                    </span>
                                </div>

                                <% if (universite !=null) { %>
                                    <h2 class="section-title">Informations de l'Université</h2>

                                    <div class="info-group">
                                        <span class="info-label">Nom de l'Université</span>
                                        <span class="info-value">
                                            <%= universite.getNomUniversite() %>
                                        </span>
                                    </div>

                                    <div class="info-group">
                                        <span class="info-label">Email de contact</span>
                                        <span class="info-value">
                                            <%= universite.getEmailContact() %>
                                        </span>
                                    </div>

                                    <div class="info-group">
                                        <span class="info-label">Téléphone</span>
                                        <span class="info-value">
                                            <%= universite.getTelephone() %>
                                        </span>
                                    </div>

                                    <div class="info-group" style="grid-column: 1 / -1;">
                                        <span class="info-label">Adresse</span>
                                        <span class="info-value">
                                            <%= universite.getAdresse() %>
                                        </span>
                                    </div>
                                    <% } %>
                            </div>
                        </div>
                    </main>
                </body>

                </html>