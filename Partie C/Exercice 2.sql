--Sous READ COMMITTED, la session A démarre une transaction et lit le solde du compte 1 (15 000 €) 
--la session B débite alors ce compte de 3 000 € et fait COMMIT, puis A relit le même compte et obtient 12 000 € :

--c’est un Non-Repeatable Read, car le snapshot est recalculé à chaque instruction.
--En répétant exactement le même scénario sous REPEATABLE READ, A relit 15 000 € malgré le COMMIT de B,
--car son snapshot est figé dès sa première lecture (MVCC), 
--et elle ne voit 12 000 € qu’après avoir terminé sa propre transaction.

--Le WAL annule toute modification non valider