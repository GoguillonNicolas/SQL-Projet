# Partie 5 : Sécurité et Sauvegarde (Administration)

## 1. Gestion des droits et rôles

Pour assurer la sécurité des données, le plus simple semble le système de privilèges de PostgreSQL et le système RLS (Row Level Security).
On peut appliquer des droits différents, par exemple sur le SELECT, INSERT, UPDATE, DELETE.
Les RLS, eux, permettent de donner des autorisations ligne par ligne ; cela peut être utile par exemple pour ne permettre à un étudiant que de lire ses propres notes dans les différents modules.

### Exemple de mise en oeuvre sur les rôles
- **Administrateur (`admin_role`)** :
    - Droits d'accès complet (`SUPERUSER`)
    - Droits de modification des tables et de la DB en général
- **Intervenant (`intervenant_role`)** :
    - Lecture seule sur les tables `etudiant`, `formation` et `module`.
    - Ecriture (INSERT/UPDATE) sur les notes (`evaluation`).
- **Étudiant (`etudiant_role`)** :
    - Lecture seule uniquement sur ses propres données.


## 2. Sauvegarde et Restauration

### Stratégie de sauvegarde
- **Sauvegarde complète** : Effectuer une sauvegarde automatique (par CRON par exemple) chaque nuit pour faire une sauvegarde complète de la DB. Envisager une duplication sur deux serveurs distincts par sécurité.
- **Système de Logs** : Permet de garder un historique de toutes les actions
- **Conservation** : Sauvegardes conservées pendant un mois ; logs conservés indéfiniment.

