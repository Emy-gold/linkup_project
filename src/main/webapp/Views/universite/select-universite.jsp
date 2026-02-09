<%@ page import="Models.Universite" %>
    <%@ page import="Models.utilisateur" %>
        <%@ page import="java.util.List" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <% utilisateur user=(utilisateur) session.getAttribute("user"); if (user==null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<Universite>
                    universites = (List<Universite>) request.getAttribute("universites");
                        int nbUniversites = (universites != null) ? universites.size() : 0;
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta charset="UTF-8">
                            <title>LinkUp - Sélectionner une université</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                                rel="stylesheet">
                            <style>
                                :root {
                                    --primary-color: #1e4d3b;
                                    /* Reverted to original Deep Green */
                                    --secondary-color: #2a6b52;
                                    --accent-color: #e8f5e9;
                                    /* Light green background */
                                    --text-dark: #2c3e50;
                                    /* Original Dark Blue-Grey */
                                    --text-light: #95a5a6;
                                    --white: #ffffff;
                                    --background: #f4f7f6;
                                    --custom-green: #348E1C;
                                    /* USER REQUESTED GREEN */
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
                                    display: flex;
                                    min-height: 100vh;
                                }

                                /* Sidebar - WHITE BACKGROUND requested */
                                .sidebar {
                                    width: 260px;
                                    background-color: var(--white);
                                    color: var(--text-dark);
                                    padding: 2rem;
                                    display: flex;
                                    flex-direction: column;
                                    position: fixed;
                                    height: 100vh;
                                    z-index: 100;
                                    border-right: 1px solid rgba(0, 0, 0, 0.05);
                                    /* Separator */
                                    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.02);
                                }

                                .logo {
                                    /* Flex layout to center logo */
                                    display: flex;
                                    justify-content: center;
                                    align-items: center;
                                    margin-bottom: 3rem;
                                    padding: 1rem 0;
                                    /* Add some padding but let image decide height */
                                    /* Removed fixed min-height constraints to allow natural sizing */
                                }

                                .logo img {
                                    /* Ensure logo fits within sidebar width but has NO height restriction */
                                    max-width: 100%;
                                    height: auto;
                                    /* REMOVED max-height and object-fit to allow full natural height */
                                    display: block;
                                    /* Eliminate inline spacing issues */

                                    /* ADDED FILTER: Since sidebar is white, if logo is white (wl.png), we need to invert it to make it visible (black/dark) */
                                    /* If the logo is already dark, this might make it white (invisible), but 'wl' suggests White Logo */
                                    filter: invert(1);
                                }

                                .nav-link {
                                    display: flex;
                                    align-items: center;
                                    padding: 1rem;
                                    color: var(--text-light);
                                    /* Grey text for inactive */
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

                                /* Active link uses the Custom Green */
                                .nav-link.active {
                                    background-color: var(--accent-color);
                                    color: var(--custom-green);
                                    /* CUSTOM GREEN */
                                }

                                .nav-link i {
                                    margin-right: 10px;
                                }

                                /* Logout Button - Requested Changes: Green text, transparent bg, green border */
                                .logout-btn {
                                    margin-top: auto;
                                    background-color: transparent;
                                    /* "fond transparent" */
                                    color: var(--custom-green);
                                    /* "déconnexion en vert" */
                                    border: 1px solid var(--custom-green);
                                    /* "les bordures en vert" */
                                    padding: 0.8rem 1rem;
                                    border-radius: 8px;
                                    cursor: pointer;
                                    display: flex;
                                    align-items: center;
                                    justify-content: flex-start;
                                    /* Align left like nav-link */
                                    text-decoration: none;
                                    transition: all 0.3s;
                                    font-weight: 500;
                                    gap: 10px;
                                    /* Space between icon and text */
                                }

                                .logout-btn:hover {
                                    background-color: var(--accent-color);
                                    /* Light green tint on hover */
                                    /* Keep border and text green */
                                    color: var(--custom-green);
                                    border-color: var(--custom-green);
                                }

                                .logout-btn svg {
                                    transition: stroke 0.3s;
                                    stroke: var(--custom-green);
                                    /* Ensure icon is green too */
                                }

                                .logout-btn:hover svg {
                                    /* Keep icon green */
                                }

                                /* Main Content */
                                .main-content {
                                    flex: 1;
                                    margin-left: 260px;
                                    display: flex;
                                    flex-direction: column;
                                }

                                .content-padding {
                                    padding: 2rem;
                                    display: flex;
                                    flex-direction: column;
                                    gap: 2rem;
                                }

                                /* Top Navbar - Profile Only - Glued to Sidebar */
                                .top-navbar {
                                    display: flex;
                                    justify-content: space-between;
                                    /* Space between Stats and Profile */
                                    align-items: center;
                                    background: var(--white);
                                    padding: 1rem 2rem;
                                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                                    border-bottom: 1px solid rgba(0, 0, 0, 0.03);
                                }

                                .navbar-stats {
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                    font-weight: 600;
                                    color: var(--custom-green);
                                    /* CUSTOM GREEN */
                                    background-color: var(--accent-color);
                                    padding: 8px 16px;
                                    border-radius: 20px;
                                    font-size: 0.95rem;
                                }

                                .navbar-stats svg {
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
                                    color: var(--text-dark);
                                    font-weight: 600;
                                    font-size: 0.95rem;
                                }

                                .user-role {
                                    display: block;
                                    color: var(--text-light);
                                    font-size: 0.8rem;
                                }

                                .avatar {
                                    width: 45px;
                                    height: 45px;
                                    background-color: #ddd;
                                    border-radius: 50%;
                                    overflow: hidden;
                                    border: 2px solid var(--white);
                                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-weight: bold;
                                    color: #555;
                                    font-size: 1.2rem;
                                }

                                /* Grid */
                                h1 {
                                    color: var(--text-dark);
                                    margin-bottom: 0.5rem;
                                    font-weight: 600;
                                }

                                .grid-container {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                                    gap: 2rem;
                                    margin-top: 1rem;
                                }

                                .card {
                                    background: var(--white);
                                    border-radius: var(--border-radius);
                                    padding: 2rem;
                                    box-shadow: var(--shadow);
                                    transition: transform 0.3s, box-shadow 0.3s;
                                    border: 1px solid rgba(0, 0, 0, 0.05);
                                    display: flex;
                                    flex-direction: column;
                                }

                                .card:hover {
                                    transform: translateY(-5px);
                                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                                }

                                .card-icon-top {
                                    width: 50px;
                                    height: 50px;
                                    background-color: var(--accent-color);
                                    color: var(--custom-green);
                                    /* CUSTOM GREEN */
                                    border-radius: 10px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    margin-bottom: 1.5rem;
                                    font-size: 1.5rem;
                                }

                                .card-title {
                                    font-size: 1.25rem;
                                    font-weight: 600;
                                    color: var(--text-dark);
                                    margin-bottom: 1rem;
                                }

                                .card-info-item {
                                    display: flex;
                                    align-items: flex-start;
                                    gap: 10px;
                                    margin-bottom: 10px;
                                    color: var(--text-dark);
                                    font-size: 0.9rem;
                                }

                                .card-info-icon {
                                    color: var(--secondary-color);
                                    /* Kept secondary for subtle icons */
                                    width: 20px;
                                    display: flex;
                                    justify-content: center;
                                    margin-top: 2px;
                                }

                                .btn {
                                    display: inline-block;
                                    background-color: var(--custom-green);
                                    /* CUSTOM GREEN for primary button */
                                    color: var(--white);
                                    padding: 0.8rem 1.5rem;
                                    border-radius: 6px;
                                    text-decoration: none;
                                    font-weight: 500;
                                    text-align: center;
                                    transition: background 0.3s, transform 0.2s;
                                    margin-top: auto;
                                }

                                .btn:hover {
                                    background-color: var(--secondary-color);
                                    transform: translateY(-1px);
                                }

                                .empty-state {
                                    grid-column: 1 / -1;
                                    text-align: center;
                                    padding: 4rem;
                                    background: var(--white);
                                    border-radius: var(--border-radius);
                                    color: var(--text-light);
                                }
                            </style>
                        </head>

                        <body>

                            <!-- Sidebar -->
                            <div class="sidebar">
                                <div class="logo">
                                    <img src="<%= request.getContextPath() %>/assets/wl.png" alt="LinkUp">
                                </div>
                                <nav>
                                    <a href="#" class="nav-link active">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                            stroke-linejoin="round" style="margin-right: 10px;">
                                            <rect x="3" y="3" width="7" height="7"></rect>
                                            <rect x="14" y="3" width="7" height="7"></rect>
                                            <rect x="14" y="14" width="7" height="7"></rect>
                                            <rect x="3" y="14" width="7" height="7"></rect>
                                        </svg>
                                        Universités
                                    </a>
                                </nav>
                                <a href="<%= request.getContextPath() %>/Logout" class="logout-btn">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                        <polyline points="16 17 21 12 16 7"></polyline>
                                        <line x1="21" y1="12" x2="9" y2="12"></line>
                                    </svg>
                                    Déconnexion
                                </a>
                            </div>

                            <!-- Main Content -->
                            <div class="main-content">

                                <!-- Top Navbar -->
                                <div class="top-navbar">
                                    <div class="navbar-stats">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M3 21h18"></path>
                                            <path d="M5 21V7l8-4 8 4v14"></path>
                                            <path d="M17 21v-8.5a1.5 1.5 0 0 0-3 0V21"></path>
                                            <path d="M9 21v-2"></path>
                                        </svg>
                                        <span>
                                            <%= nbUniversites %> Universités
                                        </span>
                                    </div>

                                    <div class="user-profile">
                                        <div class="user-info">
                                            <span class="user-name">
                                                <%= user.getPrenom() %>
                                                    <%= user.getNom() %>
                                            </span>
                                            <span class="user-role">Agent Universitaire</span>
                                        </div>
                                        <div class="avatar">
                                            <%= user.getInitiales() %>
                                        </div>
                                    </div>
                                </div>

                                <div class="content-padding">

                                    <div>
                                        <h1>Vos Universités</h1>

                                        <div class="grid-container">
                                            <% if (universites !=null && !universites.isEmpty()) { for (Universite
                                                universite : universites) { %>
                                                <div class="card">
                                                    <div class="card-icon-top">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-width="2"
                                                            stroke-linecap="round" stroke-linejoin="round">
                                                            <path d="M3 21h18"></path>
                                                            <path d="M5 21V7l8-4 8 4v14"></path>
                                                            <path d="M17 21v-8.5a1.5 1.5 0 0 0-3 0V21"></path>
                                                            <path d="M9 21v-2"></path>
                                                        </svg>
                                                    </div>

                                                    <div class="card-title">
                                                        <%= universite.getNomUniversite() %>
                                                    </div>

                                                    <div class="card-info-item">
                                                        <div class="card-info-icon">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
                                                                </path>
                                                                <circle cx="12" cy="7" r="4"></circle>
                                                            </svg>
                                                        </div>
                                                        <div>
                                                            <strong>Agent:</strong>
                                                            <%= universite.getPrenom() %>
                                                                <%= universite.getNom() %>
                                                        </div>
                                                    </div>

                                                    <div class="card-info-item">
                                                        <div class="card-info-icon">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path
                                                                    d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                                                                </path>
                                                                <polyline points="22,6 12,13 2,6"></polyline>
                                                            </svg>
                                                        </div>
                                                        <div>
                                                            <%= universite.getEmailContact() %>
                                                        </div>
                                                    </div>

                                                    <div class="card-info-item">
                                                        <div class="card-info-icon">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path
                                                                    d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                        <div>
                                                            <%= universite.getTelephone() %>
                                                        </div>
                                                    </div>

                                                    <div
                                                        style="margin-bottom: 20px; font-size: 0.85rem; color: #666; padding-left: 30px;">
                                                        <%= universite.getAdresse() !=null ? universite.getAdresse()
                                                            : "Adresse non spécifiée" %>
                                                    </div>

                                                    <a href="<%= request.getContextPath() %>/universite-dashboard?id_universite=<%= universite.getId_universite() %>"
                                                        class="btn">
                                                        Gérer
                                                    </a>
                                                </div>
                                                <% } } else { %>
                                                    <div class="empty-state">
                                                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none"
                                                            stroke="#ccc" stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round" style="margin-bottom: 20px;">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <line x1="12" y1="8" x2="12" y2="12"></line>
                                                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                                        </svg>
                                                        <h3>Aucune université disponible</h3>
                                                        <p>Vous n'êtes associé à aucune université pour le moment.</p>
                                                    </div>
                                                    <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </body>

                        </html>