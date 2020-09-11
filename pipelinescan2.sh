#!/bin/bash
# * Pipeline Scan script by Felipe Rodriguez Carcher - email: frodriguezcdev@outlook.com - Twitter: @frcdeveloper
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
set +x # ! DEBUGGING CONTROL
if [ ! -f 'pipeline-scan.jar' ]
    then ECHO 'No se encuentra el archivo auxiliar pipeline-scan.jar, descargando:'
        if [ ! -f 'pipeline-scan-LATEST.zip' ]
            then
                curl -O https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip;
        fi
        unzip pipeline-scan-LATEST.zip;
    else ECHO 'pipeline-scan... OK'
fi

# * SET CREDENTIALS
vid=<YOUR API ID>
vkey=<YOUR API KEY>

# * SET FILES TO SCAN AS AN ARRAY
filesToScan=($(find ./ -iname "*.js"));
for file in ${!filesToScan[@]}
do
    if [[ ${filesToScan[$file]} != ./pipeline-scan.jar ]]; then # * EXCLUDES PIPELINESCAN JAVA
        echo Analizando archivo $file: ${filesToScan[$file]}
        java -jar pipeline-scan.jar -vid $vid -vkey $vkey -f ${filesToScan[$file]} -sf $file'_res_pl_scan.txt'  -so true -id true -jf $file'_res_pl_scan.json' -t 4
    fi
done
