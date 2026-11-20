EXPLAIN ANALYZE 
SELECT id, client_id, date_commande, montant_total, statut 
FROM commandes 
WHERE YEAR(date_commande) = 2026 
ORDER BY montant_total 
DESC LIMIT 10;

--Le premier defaut vient de YEAR(date_commande) = 2026, car il lit tout une colonne se qui n'est pas très grave sur une base de donnée de petite taille mais sur une grand se serais vraiment un probleme

--Le deuxieme probleme vient du fait qu'on doit trier toute les lignes a la fin