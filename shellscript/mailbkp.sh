#!/bin/bash

# This script enters a directory with backups stored in subdirectories named
# per year. Subdirectories are like years: Ex .: 2015, 2016, 2017 ...

# With a "for" loop the script checks each year for subdirectories that have
# more than 365 days and stores the positive results in a list. 
# Subdirectories are like months: Ex: 01, 02, 03, ..., 12.

# At each iteration of the for loop the script executes another for loop over
# each month found by looking for directories that have more than 7 days with
# exception  of the directory  number 01 and stores the positive results in a 
# list.

# The two lists are sent in the body of an encrypted email to are responsible
# for retaining  backups. The  retention policy says that only backups of the 
# list of each month with less than 365 days and backups of the last 7 days 
# of the current month should be stored.

# ---------------------------------------------------------------------------

# Este  script entra em um diretório com backups armazenados em subdiretórios 
# nomeados por ano. Subdiretórios são como anos: Ex.: 2015, 2016, 2017...

# Com um  loop "for" o script verifica em cada YEAR  encontrado  subdiretórios 
# que  possuam mais que 365  dias e armazena  os resultados  positivos em uma 
# lista. Subdiretórios são como mêses: Ex.: 01, 02, 03, ..., 12.

# A cada iteração do loop for o script executa outro loop for  sobre cada mês 
# encontrado  buscando por diretórios que tenham mais que 7 dias com excessão 
# do diretório de numero 01 e  armazena os resultados positivos em uma lista.

# As  duas  listas são enviadas  no corpo  de um email  criptografado  para a 
# equipe responsável pela retenção de backups.A politica de  retenção diz que
# só devem  ser armazenados  backups do  dia 01  de cada mês com menos de 365 
# dias e backups dos últimos 7 dias do mês corrente.

BKP='/srv/asf/backups/'
ARQ='/srv/asf/homes/backup/relatorio.txt'

function arqslist(){
    
    DIR=`ls | grep 201`
    DATA=`date +%d-%m-%Y`
    
    cd $1
    echo -e "\n$1 in $DATA\n" >> $ARQ
    for YEAR in $DIR
        do
            find $YEAR/* -noleaf -type d -atime +365 -maxdepth 1 -exec ls -d >> $ARQ {} \; 2>> /dev/null
	        for MONTH in '01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12'
	            do
                        find $YEAR/$MONTH/* -noleaf -type d -not -name 01 -atime +6 -maxdepth 1 -exec ls -d >> $ARQ {} \; 2>> /dev/null
		done
    done
}

echo 'Backups with more than 365 days should be excluded.' >> $ARQ
echo 'Backups with more than 7 days, except from day 01, should be excluded.' >> $ARQ

arqslist $BKP
I=`wc -l $ARQ | cut -d' ' -f1`

if [ $I -gt 6 ]
    then
        cat $ARQ | gpg --trust-model always -ea -r "Backup Group" | mail -s 'Retention time expired' backup@asf.com
fi
