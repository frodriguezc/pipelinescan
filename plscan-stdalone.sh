#!/bin/bash
# * Pipeline Scan script by Felipe Rodriguez Carcher - email: frodriguezcdev@outlook.com - Twitter: @frcdeveloper
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
set +x # ! DEBUGGING CONTROL
if [ ! -f 'pipeline-scan.jar' ]
    then ECHO 'Wrapper pipeline-scan.jar not found, downloading:'
        if [ ! -f 'pipeline-scan-LATEST.zip' ]
            then
                curl -O https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip;
        fi
        unzip pipeline-scan-LATEST.zip;
    else ECHO 'Searching for pipeline-scan... OK'
fi

# * SET CREDENTIALS
vid=$(awk 'FNR == 2 {print $3}' ~/.veracode/credentials);
vkey=$(awk 'FNR == 3 {print $3}' ~/.veracode/credentials);

# * SET FILES TO SCAN AS AN ARRAY
filesToScan=$1
        echo Analizando archivo $filesToScan
        java -jar pipeline-scan.jar -vid $vid -vkey $vkey -f $filesToScan -sf RESULTADOS-PL.txt -so true -id true -jf RESULTADOS-PL.json -t 4

