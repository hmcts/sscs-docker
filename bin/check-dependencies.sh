if [ -z ".env" ]; then
  echo "===================================================================================="
  echo "Please copy .env.example to .env, then update with your email address"
  echo "===================================================================================="
  exit
fi

source .env

command -v az >/dev/null 2>&1 || {
    echo "################################################################################################"
    echo >&2 "Please install Azure CLI - instructions in README.md"
    echo "################################################################################################"
    exit 1
}

command -v docker-compose >/dev/null 2>&1 || {
    echo "################################################################################################"
    echo >&2 "Please install Docker Compose - instructions in README.md"
    echo "################################################################################################"
    exit 1
}

if [ -z $CCD_CASE_DEFINITION_XLS ]; then
  echo "===================================================================================="
  echo "Please add the location of your CCD case definition spreadsheet to the .env file"
  echo "===================================================================================="
  exit
fi

if [ -z $HMCTS_EMAIL_ADDRESS ]; then
  echo "===================================================================================="
  echo "Please add your email address to the HMCTS_EMAIL_ADDRESS variable in the .env file"
  echo "===================================================================================="
  exit
fi