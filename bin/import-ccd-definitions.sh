source .env

ATTEMPTS=0
until ./bin/ccd-import-definition.sh $CCD_CASE_DEFINITION_XLS
do
    echo "Failed to import definition, trying again in a few seconds"
    sleep $TRY_AGAIN_SECONDS
    ATTEMPTS=$((ATTEMPTS+1))
    if [ $ATTEMPTS = 200 ]; then
       echo "Giving up."
       exit;
    fi
done

if [ ! -z $CCD_BULK_SCANNING_DEFINITION_XLS ]; then
  if [ ! -f $CCD_BULK_SCANNING_DEFINITION_XLS ]; then
    echo "$CCD_BULK_SCANNING_DEFINITION_XLS not found"
  else
    ATTEMPTS=0
    until ./bin/ccd-import-definition.sh $CCD_BULK_SCANNING_DEFINITION_XLS
    do
      echo "Failed to import definition, trying again in a few seconds"
      sleep $TRY_AGAIN_SECONDS
      ATTEMPTS=$((ATTEMPTS+1))
      if [ $ATTEMPTS = 200 ]; then
         echo "Giving up."
         exit;
      fi
    done
  fi
fi
