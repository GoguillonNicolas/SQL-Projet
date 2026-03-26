-- Nettoyage des données existantes
DELETE FROM evaluation;
DELETE FROM inscription;
DELETE FROM module;
DELETE FROM formation;
DELETE FROM intervenant;
DELETE FROM etudiant;

-- 1. Insertion des Formations
INSERT INTO formation (nom_formation, duree_totale) VALUES 
('Développeur Web', 400),
('Data Scientist', 500),
('Intelligence Artificielle', 600); -- Formation sans étudiants (pour test)

-- 2. Insertion des Intervenants
INSERT INTO intervenant (nom, prenom, email) VALUES 
('Cabrel', 'Francis', 'francis.cabrel@ecole.fr'),
('Presley', 'Elvis', 'elvis.presley@gmail.com');

-- 3. Insertion des Modules
INSERT INTO module (nom_module, duree, id_formation, id_intervenant) VALUES 
('HTML/CSS', 100,
    (SELECT id_formation FROM formation WHERE nom_formation = 'Développeur Web'), 
    (SELECT id_intervenant FROM intervenant WHERE email = 'francis.cabrel@ecole.fr')),
('SQL', 150,
    (SELECT id_formation FROM formation WHERE nom_formation = 'Développeur Web'), 
    (SELECT id_intervenant FROM intervenant WHERE email = 'francis.cabrel@ecole.fr')),
('Python', 200,
    (SELECT id_formation FROM formation WHERE nom_formation = 'Data Scientist'), 
    (SELECT id_intervenant FROM intervenant WHERE email = 'elvis.presley@gmail.com')),
('Algo Avancée', 150,
    (SELECT id_formation FROM formation WHERE nom_formation = 'Data Scientist'), 
    NULL), 
('Ethique & IA', 50,
    (SELECT id_formation FROM formation WHERE nom_formation = 'Intelligence Artificielle'), 
    NULL);

-- 4. Insertion des Étudiants
INSERT INTO etudiant (nom, prenom, email, statut) VALUES 
('Dupont', 'Charlie', 'charlie.dupont@etu.fr', 'réussite'),
('Lefebvre', 'David', 'david.lefebvre@etu.fr', 'en cours'),
('Mercier', 'Eve', 'eve.mercier@etu.fr', 'échec'),
('Zola', 'Emile', 'emile.zola@etu.fr', 'en cours');

-- 5. Inscriptions (Étudiant <-> Formation) avec dates variées
INSERT INTO inscription (id_etudiant, id_formation, date_inscription) VALUES 
((SELECT id_etudiant FROM etudiant WHERE email = 'charlie.dupont@etu.fr'), 
 (SELECT id_formation FROM formation WHERE nom_formation = 'Développeur Web'), '2023-09-01'),
((SELECT id_etudiant FROM etudiant WHERE email = 'david.lefebvre@etu.fr'), 
 (SELECT id_formation FROM formation WHERE nom_formation = 'Data Scientist'), '2023-10-15'),
((SELECT id_etudiant FROM etudiant WHERE email = 'eve.mercier@etu.fr'), 
 (SELECT id_formation FROM formation WHERE nom_formation = 'Développeur Web'), '2023-12-01'),
((SELECT id_etudiant FROM etudiant WHERE email = 'emile.zola@etu.fr'), 
 (SELECT id_formation FROM formation WHERE nom_formation = 'Développeur Web'), '2024-01-10');

-- 6. Évaluations (Étudiant <-> Module) avec notes variées
INSERT INTO evaluation (id_etudiant, id_module, note, date_evaluation) VALUES 
((SELECT id_etudiant FROM etudiant WHERE email = 'charlie.dupont@etu.fr'), 
 (SELECT id_module FROM module WHERE nom_module = 'HTML/CSS'), 18.5, '2023-10-20'),
((SELECT id_etudiant FROM etudiant WHERE email = 'charlie.dupont@etu.fr'), 
 (SELECT id_module FROM module WHERE nom_module = 'SQL'), 17.0, '2023-11-15'),
((SELECT id_etudiant FROM etudiant WHERE email = 'david.lefebvre@etu.fr'), 
 (SELECT id_module FROM module WHERE nom_module = 'Python'), 08.5, '2023-12-10'),
((SELECT id_etudiant FROM etudiant WHERE email = 'eve.mercier@etu.fr'), 
 (SELECT id_module FROM module WHERE nom_module = 'HTML/CSS'), 05.0, '2024-01-15');
