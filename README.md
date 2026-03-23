# Projet SQL - Dictionnaire de Données


## 1. Étudiant (`etudiant`)
| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_etudiant` | INT | PRIMARY KEY | Identifiant |
| `nom` | VARCHAR(100) | NOT NULL | Nom |
| `prenom` | VARCHAR(100) | NOT NULL | Prénom |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Mail |
| `statut` | VARCHAR(50) | | Statut actuel (en cours, réussite, échec) |

## 2. Intervenant (`intervenant`)
| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_intervenant` | INT | PRIMARY KEY | Identifiant unique de l'intervenant |
| `nom` | VARCHAR(100) | NOT NULL | Nom de famille de l'intervenant |
| `prenom` | VARCHAR(100) | NOT NULL | Prénom de l'intervenant |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Adresse email de l'intervenant |

## 3. Formation (`formation`)
| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_formation` | INT | PRIMARY KEY | Identifiant unique de la formation |
| `nom_formation` | VARCHAR(255) | NOT NULL | Nom de la formation |
| `duree_prevue_heures`| INT | NOT NULL | Durée totale prévue (en heures) |

## 4. Module (`module`)
| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_module` | INT | PRIMARY KEY | Identifiant |
| `id_formation` | INT | FOREIGN KEY | Référence à la formation |
| `id_intervenant` | INT | FOREIGN KEY, NULL| Référence à l'intervenant |
| `nom_module` | VARCHAR(255) | NOT NULL | Nom du module |
| `duree_heures` | INT | NOT NULL | Durée estimée du module |

## 5. Inscription (`inscription`)

| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_etudiant` | INT | PK, FOREIGN KEY | Référence à l'étudiant |
| `id_formation` | INT | PK, FOREIGN KEY | Référence à la formation |
| `annee_inscription`| INT | NOT NULL | Année |
| `date_inscription` | DATE | NOT NULL | Date d'inscription |

## 6. Évaluation (`evaluation`)

| Champ | Type | Contraintes | Description |
|-------|------|-------------|-------------|
| `id_etudiant` | INT | PK, FOREIGN KEY | Référence à l'étudiant |
| `id_module` | INT | PK, FOREIGN KEY | Référence au module |
| `note` | DECIMAL(4,2) | NULL | Note sur 20 |
| `date_evaluation` | DATE | NULL | Date de la saisie de la note |


