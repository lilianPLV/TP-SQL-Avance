CREATE INDEX idx_cmd_statut_date ON commandes (statut, date_commande, montant_total);
ANALYZE TABLE commandes;

----------------------------------------------------------------------------------------

SELECT id, client_id, date_commande, montant_total
FROM commandes
WHERE statut = 'LIVREE'
  AND date_commande >= '2026-01-01' AND date_commande < '2027-01-01'
ORDER BY montant_total DESC
LIMIT 10;

----------------------------------------------------------------------------------------

ALTER TABLE commandes
PARTITION BY RANGE (YEAR(date_commande)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION p2026 VALUES LESS THAN (2027),
  PARTITION pmax  VALUES LESS THAN MAXVALUE
);

----------------------------------------------------------------------------------------

--Le YEAR() sans partition a un cout total de 2,96 soit 0,159 ms
--Avec le plage de date sans partition il y a un cout total de 0,645 soit 0,077 ms
--Et avec la plage de date avec partition = 0,338 soit 0,077 ms

--Grace au Partitionn Pruning lors de la requette le SQL ne regarde meme pas les lignes ou les dates ne correspondes pas