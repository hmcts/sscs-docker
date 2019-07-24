source .env

rm .tags.env || true
./ccd enable frontend backend

if [ -z $INCLUDE_DM_STORE ]; then
  read -p "Include Document Store in new configuration? [y/n] " INCLUDE_DM_STORE
fi

if [ -z $INCLUDE_CASE_API ]; then
  read -p "Tribunals Case API? [y/n] " INCLUDE_CASE_API
fi

if [ -z $INCLUDE_BULK_SCAN ]; then
  read -p "Bulk Scanning API? [y/n] " INCLUDE_BULK_SCAN
fi

if [ -z $INCLUDE_STITCHING ]; then
  read -p "Stitching API? [y/n] " INCLUDE_STITCHING
fi

if [ $INCLUDE_DM_STORE == "y" ]; then
  ./ccd enable dm-store
fi

if [ $INCLUDE_CASE_API == "y" ]; then
  ./ccd enable case-api
fi

if [ $INCLUDE_BULK_SCAN == "y" ]; then
  ./ccd enable bulk-scan
fi

if [ $INCLUDE_STITCHING == "y" ]; then
  ./ccd enable stitching-api
fi

./ccd compose pull