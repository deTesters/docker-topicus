#Googledag project

Docker container met een SQL Server (Linux) ingespoelt met test-data

- Hernoem de .bak file naar db_backup.bak en plaats in dezelfde folder als de Dockerfile 
- Bouw de docker image obv de Dockerfile, voer onderstaand commando uit
```
docker build -t sql-server .
```
- Run de docker image in een container, voer onderstaand commando uit
```
docker run -d --name sql-server sql-server
```

Op dit moment werkt het automatisch inspoelen als onderdeel van de build nog niet, ik heb dat laatste statement uit-gecomment in de Dockerfile, daar moet nog naar gekeken worden, er wordt nu een error gegeven dat die statement niet correct zou zijn :s . Dat kan nu nog wel handmatig ingespoeld worden na het starten:
- attach de terminal van de container:
```
docker exec -it sql-server bash
```
- Log in op sqlcmd:
```
sqlcmd -S localhost -U SA -P T3st3r33
```
- Voer de volgende statement per regel in en druk op enter na elke regel:
```
RESTORE DATABASE STAGING-RABO-INTERN-XLD 
```
```
FROM DISK='/var/opt/mssql/backup/db_backup.bak' 
```
```
WITH MOVE 'pakket_1' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.mdf', 
```
```
MOVE 'pakket_1_log' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.ldf'
```
```
GO
```
- de database is nu ingespoeld voer `EXIT` in en druk op enter om sqlcmd te verlaten.