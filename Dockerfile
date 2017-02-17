FROM microsoft/mssql-server-linux:latest
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=T3st3r33

COPY db_backup.bak /var/opt/mssql/backup/
RUN apt-get update
RUN apt-get install -y ca-certificates curl
RUN apt-get install apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get -y install msodbcsql=13.1.1.0-1 mssql-tools
RUN apt-get -y install unixodbc-dev-utf16
#Create symlinks for tools
RUN ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd
RUN ln -sfn /opt/mssql-tools/bin/bcp /usr/bin/bcp

RUN locale-gen en_US.UTF-8
ENV LANG "en_US.UTF-8"

#RUN sqlcmd -S localhost -U SA -P T3st3r33
#RUN RESTORE DATABASE AdventureWorks FROM DISK = '/var/opt/mssql/backup/db_backup.bak' WITH MOVE 'AdventureWorks2014_Data' TO '/var/opt/mssql/data/AdventureWorks2014_Data.mdf', MOVE 'AdventureWorks2014_Log' TO '/var/opt/mssql/data/AdventureWorks2014_Log.ldf'
#RUN GO
#RUN RESTORE DATABASE STAGING-RABO-INTERN-XLD && \
#    FROM DISK = '/var/opt/mssql/backup/db_backup.bak' && \
#    WITH MOVE 'pakket_1' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.mdf', && \
#    MOVE 'pakket_1_log' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.ldf' && \
#    GO

#sqlcmd -S localhost -U SA -P T3st3r33 -q "restore database STAGING-RABO-INTERN-XLD from DISK='/var/opt/mssql/backup/db_backup.bak'; with move 'pakket_1' to '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.mdf', move 'pakket_1_log' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.ldf'"

#RESTORE DATABASE AdventureWorks FROM DISK = '/var/opt/mssql/backup/db_backup.bak' WITH MOVE 'AdventureWorks2014_Data' TO '/var/opt/mssql/data/AdventureWorks2014_Data.mdf', MOVE 'AdventureWorks2014_Log' TO '/var/opt/mssql/data/AdventureWorks2014_Log.ldf' GO
#    GO

Msg 5133, Level 16, State 1, Server 70557b92de91, Line 1
Directory lookup for the file "G:\database\STAGING-RABO-INTERN-XLD.mdf" failed with the operating system error 2(The system cannot find the file specified.).
Msg 3156, Level 16, State 3, Server 70557b92de91, Line 1
File 'pakket_1' cannot be restored to 'G:\database\STAGING-RABO-INTERN-XLD.mdf'. Use WITH MOVE to identify a valid location for the file.
Msg 5133, Level 16, State 1, Server 70557b92de91, Line 1
Directory lookup for the file "L:\database\STAGING-RABO-INTERN-XLD.ldf" failed with the operating system error 2(The system cannot find the file specified.).
Msg 3156, Level 16, State 3, Server 70557b92de91, Line 1
File 'pakket_1_log' cannot be restored to 'L:\database\STAGING-RABO-INTERN-XLD.ldf'. Use WITH MOVE to identify a valid location for the file.
Msg 3119, Level 16, State 1, Server 70557b92de91, Line 1
Problems were identified while planning for the RESTORE statement. Previous messages provide details.
Msg 3013, Level 16, State 1, Server 70557b92de91, Line 1