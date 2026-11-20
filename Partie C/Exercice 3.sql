--Le suivi GPS (10 000 écritures par seconde) va dans Cassandra (PA/EL), qui privilégie disponibilité et latence : perdre un point est sans gravité.
--Redis garde la dernière position de chaque véhicule en O(1).

--La facturation va dans PostgreSQL (PC/EC), car elle exige des transactions ACID et aucun risque de double débit.
--Aucune base unique ne peut être à la fois PA/EL pour le GPS et PC/EC pour l’argent : le choix se fait donc besoin par besoin.