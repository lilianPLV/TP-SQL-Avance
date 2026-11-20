CREATE TABLE mv_synthese_segments (
  segment      VARCHAR(50)   NOT NULL PRIMARY KEY,
  nb_commandes INT           NOT NULL,
  ca_total     DECIMAL(14,2) NOT NULL,
  derniere_maj DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-------------------------------------------------

START TRANSACTION;
DELETE FROM mv_synthese_segments;
INSERT INTO mv_synthese_segments (segment, nb_commandes, ca_total)
SELECT cl.segment, COUNT(co.id), COALESCE(SUM(co.montant_total), 0)
FROM clients cl
LEFT JOIN commandes co ON co.client_id = cl.id
GROUP BY cl.segment;
COMMIT;

-------------------------------------------------

SELECT
  (SELECT SUM(nb_commandes) FROM mv_synthese_segments)  AS nb_dans_la_vue,
  (SELECT COUNT(*)          FROM commandes)             AS nb_reel,
  (SELECT SUM(ca_total)     FROM mv_synthese_segments)  AS ca_dans_la_vue,
  (SELECT SUM(montant_total) FROM commandes)            AS ca_reel,
  CASE WHEN (SELECT SUM(nb_commandes) FROM mv_synthese_segments) = (SELECT COUNT(*) FROM commandes)
        AND (SELECT SUM(ca_total)     FROM mv_synthese_segments) = (SELECT SUM(montant_total) FROM commandes)
       THEN 'À JOUR' ELSE 'STALE (obsolète)' END AS etat;

-------------------------------------------------
--Test pour vérifier si tout marche:

SELECT * FROM mv_synthese_segments ORDER BY ca_total DESC;
INSERT INTO commandes (client_id, date_commande, montant_total, statut)
VALUES (1, NOW(), 1000.00, 'LIVREE');
SELECT * FROM mv_synthese_segments ORDER BY ca_total DESC;