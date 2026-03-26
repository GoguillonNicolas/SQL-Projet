-- Lister les étudiants inscrits à une formation donnée
SELECT e.nom, e.prenom, e.email
FROM etudiant e
JOIN inscription i ON e.id_etudiant = i.id_etudiant
JOIN formation f ON i.id_formation = f.id_formation
WHERE f.nom_formation = 'Développeur Web';

-- Afficher le parcours d’un étudiant
SELECT e.prenom, e.nom, f.nom_formation, m.nom_module
FROM etudiant e
JOIN inscription i ON e.id_etudiant = i.id_etudiant
JOIN formation f ON i.id_formation = f.id_formation
JOIN module m ON f.id_formation = m.id_formation
WHERE e.email = 'charlie.dupont@etu.fr';

-- Identifier les étudiants n’ayant pas encore de note dans un module
SELECT e.nom, e.prenom, m.nom_module
FROM etudiant e
JOIN inscription i ON e.id_etudiant = i.id_etudiant
JOIN module m ON i.id_formation = m.id_formation
LEFT JOIN evaluation ev ON e.id_etudiant = ev.id_etudiant AND m.id_module = ev.id_module
WHERE ev.note IS NULL;

-- Afficher les étudiants en situation d’échec ou de réussite
SELECT e.nom, e.prenom, ROUND(AVG(ev.note), 2) as moyenne,
       CASE WHEN AVG(ev.note) >= 10 THEN 'Réussite' ELSE 'Échec' END as resultat
FROM etudiant e
JOIN evaluation ev ON e.id_etudiant = ev.id_etudiant
GROUP BY e.id_etudiant, e.nom, e.prenom;

-- Lister les modules composant une formation (ex: 'Développeur Web')
SELECT m.nom_module
FROM module m
JOIN formation f ON m.id_formation = f.id_formation
WHERE f.nom_formation = 'Développeur Web';


-- Identifier les modules avec le plus grand nombre d’inscrits
SELECT m.nom_module, COUNT(i.id_etudiant) as nb_inscrits
FROM module m
JOIN inscription i ON m.id_formation = i.id_formation
GROUP BY m.id_module, m.nom_module
ORDER BY nb_inscrits DESC;

-- Afficher les formations n’ayant aucun étudiant inscrit
SELECT f.nom_formation
FROM formation f
LEFT JOIN inscription i ON f.id_formation = i.id_formation
WHERE i.id_etudiant IS NULL;

-- Comparer la durée totale prévue d’une formation avec la durée réellement prévue
SELECT f.nom_formation, f.duree_totale as duree_prevue_formation, 
       SUM(m.duree) as total_heures_modules
FROM formation f
JOIN module m ON f.id_formation = m.id_formation
GROUP BY f.id_formation, f.nom_formation, f.duree_totale;

-- Lister les modules animés par un intervenant
SELECT i.prenom, i.nom, m.nom_module
FROM intervenant i
JOIN module m ON i.id_intervenant = m.id_intervenant
WHERE i.email = 'francis.cabrel@ecole.fr';

-- Identifier les intervenants ayant le plus de modules
SELECT i.nom, i.prenom, COUNT(m.id_module) as nb_modules
FROM intervenant i
LEFT JOIN module m ON i.id_intervenant = m.id_intervenant
GROUP BY i.id_intervenant, i.nom, i.prenom
ORDER BY nb_modules DESC;

-- Repérer les modules sans intervenant affecté
SELECT nom_module
FROM module
WHERE id_intervenant IS NULL;
