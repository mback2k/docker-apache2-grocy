#!/bin/bash -e

if [ ! -f "${GROCY_DATA_DIR}/config.php" ]; then
    cp -a "${GROCY_DATA_DIST_DIR}/config.php" "${GROCY_DATA_DIR}/config.php"
fi

sed -i "s/Setting('CULTURE', '.*')/Setting('CULTURE', '${GROCY_CULTURE:-de}')/g" "${GROCY_DATA_DIR}/config.php"
sed -i "s/Setting('CURRENCY', '.*')/Setting('CURRENCY', '${GROCY_CURRENCY:-EUR}')/g" "${GROCY_DATA_DIR}/config.php"

exit 0
