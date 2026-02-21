-- SCRIPT DE REMPLISSAGE DE TEST POUR LINKUP DB (Compatible MariaDB)
-- Basé sur la structure fournie

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `entretien`;
TRUNCATE TABLE `candidature`;
TRUNCATE TABLE `experience`;
TRUNCATE TABLE `cv`;
TRUNCATE TABLE `diplome`;
TRUNCATE TABLE `annonce`;
TRUNCATE TABLE `admin`;
TRUNCATE TABLE `candidat`;
TRUNCATE TABLE `recruteur`;
TRUNCATE TABLE `universite`;
TRUNCATE TABLE `utilisateur`;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Insertion des UTILISATEURS
-- Utilisation de 'password' pour la colonne password et 'date_inscription'
INSERT INTO `utilisateur` (`id_utilisateur`, `email`, `password`, `nom`, `prenom`, `role`, `date_inscription`, `statut_compte`) VALUES 
(1, 'admin@linkup.com', 'password', 'Kharraz', 'Admin', 'ADMIN', CURDATE(), 'ACTIF'),
(2, 'lucas.candidat@email.com', 'password', 'Martin', 'Lucas', 'CANDIDAT', CURDATE(), 'ACTIF'),
(3, 'marie.candidat@email.com', 'password', 'Dupont', 'Marie', 'CANDIDAT', CURDATE(), 'ACTIF'),
(4, 'recruteur1@tech.com', 'password', 'Benali', 'Amine', 'RECRUTEUR', CURDATE(), 'ACTIF'),
(5, 'sarah.recruteur@eco.com', 'password', 'Green', 'Sarah', 'RECRUTEUR', CURDATE(), 'EN_ATTENTE'),
(6, 'thomas.agent@univ-paris.fr', 'password', 'Lefebvre', 'Thomas', 'AGENT_UNIV', CURDATE(), 'EN_ATTENTE'),
(7, 'zineb.agent@univ-casa.ma', 'password', 'Alami', 'Zineb', 'AGENT_UNIV', CURDATE(), 'ACTIF');

-- 2. Insertion dans les tables liées (Profils)
INSERT INTO `admin` (`id_admin`) VALUES (1);

INSERT INTO `candidat` (`id_candidat`, `titre_profil`, `disponibilite`) VALUES 
(2, 'Développeur Java Junior', 'Immédiate'),
(3, 'UX Designer', 'Sous 2 semaines');

INSERT INTO `recruteur` (`id_recruteur`, `nom_entreprise`, `secteur_activite`, `description_entreprise`, `poste_occupe`) VALUES 
(4, 'DevTech Solutions', 'Développement Logiciel', 'Leader du cloud en Europe', 'DRH'),
(5, 'EcoLogic SAS', 'Gestion des déchets', 'Expertise en recyclage durable', 'Responsable Recrutement');

INSERT INTO `universite` (`id_universite`, `nom_universite`, `adresse`, `telephone`, `email_contact`) VALUES 
(6, 'Université de Paris-Cité', '75006 Boulevard Saint-Michel, Paris', '+33 1 40 46 22 11', 'contact@u-paris.fr'),
(7, 'Université Hassan II', 'Casablanca, Maroc', '+212 5 22 23 04 09', 'contact@univh2c.ma');

-- 3. Insertion des ANNONCES
INSERT INTO `annonce` (`id_recruteur`, `titre`, `description`, `type_contrat`, `statut_annonce`, `date_publication`) VALUES 
(4, 'Développeur Java Fullstack', 'Nous recherchons un expert Jakarta EE pour refondre notre module Admin.', 'CDI', 'PUBLIEE', '2026-02-01'),
(4, 'Chef de Projet Agile', 'Gestion d''équipes offshore et pilotage de sprints.', 'CDI', 'EN_ATTENTE', '2026-02-10'),
(5, 'Ingénieur Environnement', 'Analyse du cycle de vie des produits de recyclage.', 'FREELANCE', 'EN_ATTENTE', '2026-02-10');

-- 4. Insertion de quelques DIPLOMES pour les tests de visualisation
INSERT INTO `diplome` (`id_candidat`, `id_universite`, `libelle`, `document_justificatif`, `statut_validation`) VALUES 
(2, 6, 'Master Informatique', 'diplome_lucas.pdf', 'VALIDE'),
(3, 7, 'Master Design Digital', 'diplome_marie.pdf', 'EN_ATTENTE');
