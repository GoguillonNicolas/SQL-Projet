-- Nombre total d’étudiants, de formations et de modules
SELECT 
    (SELECT COUNT(*) FROM etudiant) as total_etudiants,
    (SELECT COUNT(*) FROM formation) as total_formations,
    (SELECT COUNT(*) FROM module) as total_modules;
-- Requete simple proposant une colonne avec count pour chaque donnée demandée

-- Moyenne générale des notes par formation
SELECT f.nom_formation, ROUND(AVG(ev.note), 2) as moyenne_generale
FROM formation f
JOIN module m ON f.id_formation = m.id_formation
JOIN evaluation ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation;
-- Select sur une formation et sa moyenne associée - AVG permettant de calculer cette moyenne,
-- et ROUND d'arrondir le résultat pour une meilleure lisibilité

-- Répartition des étudiants par statut (réussite / échec / en cours)
SELECT 
    statut, 
    COUNT(*) as nb_etudiants,
    STRING_AGG(nom || ' ' || prenom, ', ') as liste_noms,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM etudiant), 1) as pourcentage
FROM etudiant
GROUP BY statut;
-- Requete permettant de créer une ligne par statut
-- Pour chaque ligne, on utilise la fonction STRING_AGG pour lister les étudiants en une seule string
-- Pour une meilleure lisibilité de la répartition, on calcule le pourcentage de chaque

-- Moyenne des notes par formation et par module
SELECT f.nom_formation, m.nom_module, ROUND(AVG(ev.note), 2) as moyenne_module
FROM formation f
JOIN module m ON f.id_formation = m.id_formation
LEFT JOIN evaluation ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation, m.id_module, m.nom_module
ORDER BY f.nom_formation, moyenne_module DESC;
-- La requete liste les modules par formation et leurs moyenne
-- NB - je n'ai pas encore trouvé de solutions pour lister dans la même requete
-- les moyennes de modules et de formations

-- Nombre d’étudiants par formation et par année (basé sur la date d'inscription)
SELECT f.nom_formation, EXTRACT(YEAR FROM i.date_inscription) as annee, 
       COUNT(i.id_etudiant) as nb_inscriptions
FROM formation f
JOIN inscription i ON f.id_formation = i.id_formation
GROUP BY f.id_formation, f.nom_formation, annee
ORDER BY annee DESC, nb_inscriptions DESC;
-- On utilise EXTRACT sur la date d'inscription pour avoir chaque année pour une formation
-- Le group by permet de séparer par formation et par année le nombre d'inscriptions

-- Évolution du nombre d’inscriptions au fil du temps (par mois)
SELECT TO_CHAR(date_inscription, 'YYYY-MM') as mois, COUNT(*) as nb_inscriptions
FROM inscription
GROUP BY mois
ORDER BY mois;
-- Sur le même principe que la requête sur l'année, cette fois on utilise 
-- TO_CHAR pour avoir chaque mois (cela permet d'éviter les confusions entre 
-- le même mois mais d'une année différente)


-- Classer les étudiants par catégorie de résultat
SELECT e.nom, e.prenom, ROUND(AVG(ev.note), 2) as moyenne,
       CASE 
           WHEN AVG(ev.note) >= 16 THEN 'Très bien'
           WHEN AVG(ev.note) >= 12 THEN 'Bien'
           WHEN AVG(ev.note) >= 10 THEN 'Assez bien'
           ELSE 'Insuffisant'
       END as categorie
FROM etudiant e
JOIN evaluation ev ON e.id_etudiant = ev.id_etudiant
GROUP BY e.id_etudiant, e.nom, e.prenom;
-- On utilise un CASE pour traiter chaque niveau déterminé sur la moyenne

-- Identifier les formations dont la moyenne est inférieure à un seuil (ex: 10)
SELECT f.nom_formation, ROUND(AVG(ev.note), 2) as moyenne_formation
FROM formation f
JOIN module m ON f.id_formation = m.id_formation
JOIN evaluation ev ON m.id_module = ev.id_module
GROUP BY f.id_formation, f.nom_formation
HAVING AVG(ev.note) < 10;
-- On calcule a nouveau les moyennes des formations
-- La condition HAVING permet de vérifier les moyennes inférieures à 10 
-- et de ne garder que celles ci 


-- Modules “à risque” (taux d’échec élevé)
SELECT m.nom_module, ROUND(AVG(ev.note), 2) as moyenne_module
FROM module m
JOIN evaluation ev ON m.id_module = ev.id_module
GROUP BY m.id_module, m.nom_module
HAVING AVG(ev.note) < 10;
-- On calcule les moyennes des modules
-- Le HAVING renvoie uniquement les moyennes inférieures à 10 pour mettre en évidence 
-- Le risque d'échec global 