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

#RUN sqlcmd -S localhost -U SA -P T3st3r33 -q "RESTORE DATABASE STAGING-RABO-INTERN-XLD FROM DISK='/var/opt/mssql/backup/db_backup.bak' WITH MOVE 'pakket_1' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.mdf', MOVE 'pakket_1_log' TO '/var/opt/mssql/data/STAGING-RABO-INTERN-XLD.ldf'"