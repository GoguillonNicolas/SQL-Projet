CREATE TABLE etudiant (
    id_etudiant UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    statut VARCHAR(50) DEFAULT 'en cours'
);

CREATE TABLE intervenant (
    id_intervenant UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE formation (
    id_formation UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nom_formation VARCHAR(255) NOT NULL,
    duree_totale INT NOT NULL
);

CREATE TABLE module (
    id_module UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_formation UUID NOT NULL REFERENCES formation(id_formation) ON DELETE CASCADE,
    id_intervenant UUID REFERENCES intervenant(id_intervenant) ON DELETE SET NULL,
    nom_module VARCHAR(255) NOT NULL,
    duree INT NOT NULL
);

CREATE TABLE inscription (
    id_etudiant UUID REFERENCES etudiant(id_etudiant) ON DELETE CASCADE,
    id_formation UUID REFERENCES formation(id_formation) ON DELETE CASCADE,
    PRIMARY KEY (id_etudiant, id_formation)
);

CREATE TABLE evaluation (
    id_etudiant UUID REFERENCES etudiant(id_etudiant) ON DELETE CASCADE,
    id_module UUID REFERENCES module(id_module) ON DELETE CASCADE,
    note DECIMAL(4,2) CHECK (note >= 0 AND note <= 20),
    date_evaluation DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_etudiant, id_module)
);
