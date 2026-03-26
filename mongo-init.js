// Initialisation de la base NoSQL (MongoDB) pour le projet SQL
// Crée les collections et insère des données de test (logs, commentaires, évaluations libres)

db = db.getSiblingDB('projet_nosql');

// 1. Collection 'logs' - Historique des actions
db.logs.insertMany([
  {
    timestamp: new Date(),
    action: "INSCRIPTION_ETUDIANT",
    id_etudiant: 1,
    id_formation: 1,
    details: "Nouvelle inscription validée par l'administration"
  },
  {
    timestamp: new Date(),
    action: "SAISIE_NOTE",
    id_etudiant: 2,
    id_module: 3,
    id_intervenant: 1,
    details: "Note de 15.5 saisie pour le module SQL"
  },
  {
    timestamp: new Date(),
    action: "ARCHIVAGE_FORMATION",
    id_formation: 2,
    details: "Formation 'Développeur Web 2023' archivée"
  }
]);

// 2. Collection 'evaluations_libres' - Commentaires et feedback
db.evaluations_libres.insertMany([
  {
    id_etudiant: 1,
    id_module: 1,
    date: new Date(),
    commentaire_intervenant: "Très bonne participation. Comprend bien les concepts relationnels.",
    points_forts: ["Rigueur", "Logique"],
    points_amelioration: ["Rapidité d'exécution"],
    statut: "FINALISE"
  },
  {
    id_etudiant: 2,
    id_module: 1,
    date: new Date(),
    commentaire_intervenant: "Quelques difficultés sur les jointures complexes. À retravailler.",
    besoin_accompagnement: true,
    priorite: "HAUTE"
  }
]);

// 3. Collection 'historique_parcours' - Évolution de l'étudiant
db.historique_parcours.insertMany([
  {
    id_etudiant: 1,
    entrees: [
      { date: "2024-01-15", evenement: "Début de la formation", note: "Motivation initiale élevée" },
      { date: "2024-03-20", evenement: "Validation du premier bloc", note: "Résultats prometteurs" }
    ]
  }
]);

print("Initialisation NoSQL terminée avec succès.");
