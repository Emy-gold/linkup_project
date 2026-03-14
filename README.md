gantt
    title Planification Projet SmartFit (Full-Stack, DevOps, IA)
    dateFormat  YYYY-MM-DD
    axisFormat  %d %b
    
    section 1. Conception & Modélisation
    Choix du sujet & Validation       :done,    des1, 2026-03-14, 3d
    Spécifications & Maquettes UI     :active,  des2, 2026-03-17, 7d
    Diagrammes UML (Cas d'util., Classes):        des3, 2026-03-24, 7d
    Architecture Base de données      :         des4, 2026-03-31, 4d

    section 2. Formation (Contrainte)
    Formation Spring Boot (3 sem.)    :crit,    form1, 2026-03-14, 21d

    section 3. Développement Frontend (Angular)
    Setup Projet Angular & Tailwind   :         front1, 2026-03-24, 4d
    Dev: Authentification UI & Landing:         front2, 2026-03-28, 7d
    Dev: Dashboards (Admin, Club)     :         front3, 2026-04-04, 10d
    Dev: Espace Coach & Client        :         front4, 2026-04-14, 10d
    Intégration API (Mocks puis Réel) :         front5, 2026-04-24, 14d

    section 4. Développement Backend (Spring)
    Setup Spring Boot & Sécurité JWT  :         back1, after form1, 7d
    Dev: API CRUD (Users, Clubs)      :         back2, 2026-04-11, 10d
    Dev: API Réservations & Planning  :         back3, 2026-04-21, 10d
    Liaison API Spring avec API IA    :         back4, 2026-05-01, 7d

    section 5. Module IA (Python)
    Exploration & Choix Modèle (LLM/ML):        ia1, 2026-03-20, 10d
    Dev: Script Python (Génération/Reco):       ia2, 2026-03-30, 14d
    Création API Flask/FastAPI        :         ia3, 2026-04-13, 7d
    Tests d'intégration IA            :         ia4, 2026-04-20, 7d

    section 6. DevOps & Cloud
    Setup Git, GitHub & Notion        :done,    dev1, 2026-03-14, 3d
    Création Dockerfiles (Front,Back,IA):       dev2, 2026-05-08, 7d
    Orchestration Docker Compose      :         dev3, 2026-05-15, 5d
    Pipeline CI/CD (GitHub Actions)   :         dev4, 2026-05-20, 7d
    Configuration AWS EC2             :         dev5, 2026-05-27, 5d
    Déploiement Cloud Final           :crit,    dev6, 2026-06-01, 5d

    section 7. Finalisation & Livrables
    Tests Globaux & Débogage          :         fin1, 2026-06-06, 7d
    Rédaction Documentation Technique :         fin2, 2026-06-10, 5d
    Préparation Présentation / Démo   :         fin3, 2026-06-15, 5d
    Livraison Finale                  :milestone, fin4, 2026-06-20, 0d
