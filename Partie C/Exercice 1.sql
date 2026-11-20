SELECT e.id, e.nom
FROM employes e
WHERE NOT EXISTS (
  SELECT 1
  FROM employes m
  WHERE m.manager_id = e.id
);