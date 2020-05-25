#!/bin/bash -e

if [ ! -f "${GROCY_DATA_DIR}/.htaccess" ]; then
    cp -ar "${GROCY_DATA_DIST_DIR}" -T "${GROCY_DATA_DIR}"
fi

exit 0
