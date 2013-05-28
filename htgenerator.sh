#!/bin/bash
####################################
#
# htgenerator.sh
# Task to sync directories, pull from REMOTE ORIGIN to TARGET
# 
####################################

BASEPATH=$1
FILE=$(basename "$2")
FULL=${BASEPATH}${FILE}

logger basepath: $BASEPATH
logger file: $FILE
logger full: $FULL

declare -a NAMES=('lagniappe' 'unscummed' 'rabi' 'era' 'spinning' 'maggie' 'lockup' 'sculpin' 'ringbone' 'dewar' 'gaga' 'kerak' 'strongpoint' 'mambo' 'vising' 'leapfrog' 'sidekick' 'benbrook' 'knitwear' 'schberg' 'bogor' 'sudan' 'nineteenth' 'noting' 'tagrag' 'bogey' 'repress' 'glinka' 'forgat' 'vinaigre' 'seadog' 'reseat' 'chaudfroid' 'naething' 'chafflike' 'favors' 'coven' 'handsaw' 'somedeal' 'bowsing' 'biformed' 'luxor' 'cawnpur' 'thorstein' 'milan' 'bumpy' 'manhunt' 'suited' 'sofa' 'do' 'china' 'phoebe' 'nana' 'payee' 'tania' 'unused' 'paplike' 'stoma' 'marcelle' 'oarlock' 'crossrail' 'choiceness' 'gatehouse' 'dunghill' 'collins' 'welder' 'heliced' 'lister' 'kirkwall' 'braunschweig' 'moral' 'explore' 'rompers' 'devest' 'delist' 'bentwood' 'unfudged' 'thalli' 'gritted' 'churchman' 'capsuled' 'cheerful' 'redrugged' 'dormy' 'maurine' 'sturty' 'paroled' 'sunder' 'curry' 'boulez' 'vis' 'dorrie' 'hawklike' 'berate' 'crivetz' 'awnless' 'dispensed' 'exon' 'shelb' 'menam')

FIRST=${NAMES[$[ 1 + $[ RANDOM % 50 ]]]}
LAST=${NAMES[$[ 1 + $[ RANDOM % 90 ]]]}
PW=${NAMES[$[ 1 + $[ RANDOM % 99 ]]]}
SALT="roundhouse agency 2013"

create_pw ()
{
    echo -n $PW | openssl enc -base64
}

PASSWORD=$(create_pw)


if [[ -d $FULL ]]; then
    #logger "$FULL is a directory"

    if [[ "$FILE" == *SUB_* ]]; then
        echo "user: ${FIRST}-${LAST}" > $FULL/GENERATED-PASSWORD.txt
        echo "password: ${PW}" >> $FULL/GENERATED-PASSWORD.txt
        echo "Copy the User and Password, this file will be deleted at midnight and you will not be able to retrieve the password." >> $FULL/GENERATED-PASSWORD.txt
    else    
        # wrong naming convention, rename and create htaccess
        mv $FULL ${BASEPATH}SUB_${FILE}
        
        echo "user: ${FIRST}-${LAST}" > ${BASEPATH}SUB_${FILE}/GENERATED-PASSWORD.txt
        echo "password: ${PW}" >> ${BASEPATH}SUB_${FILE}/GENERATED-PASSWORD.txt
        echo "Copy the User and Password, this file will be deleted at midnight and you will not be able to retrieve the password." >> ${BASEPATH}SUB_${FILE}/GENERATED-PASSWORD.txt
    fi
    # make .htaccess_<name> in secure directory
    htpasswd -cbd /home/ftp/htaccess/.htaccess_${FILE} ${FIRST}-${LAST} ${PW}

elif [[ -f $FULL ]]; then
    # remove files
    rm -rf $FULL
else
    exit 1
fi