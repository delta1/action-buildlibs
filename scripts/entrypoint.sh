#!/bin/bash
PLATFORMS=$1
LEVEL=$2
SRCDIR=$3
VERSION=$4
VERSION=${VERSION/refs\/tags\/libwallet-/}
# fix version for branch instead of tag
if [ $VERSION = "refs/heads/libwallet" ]
then
  VERSION=libwallet
fi

echo "Action Build Libs: Invoking with"
echo "PLATFORMS: ${PLATFORMS}"
echo "LEVEL: ${LEVEL}"
echo "SRCDIR: ${SRCDIR}"
echo "VERSION: ${VERSION}"

IFS=';' read -ra PLATFORMARRAY <<< "$PLATFORMS"

for platform in "${PLATFORMARRAY[@]}"; do
  /scripts/build_jnilib.sh ${platform} ${LEVEL} ${SRCDIR} || exit 1
done

/scripts/hash_libs.sh "$PLATFORMS" "$VERSION" "${SRCDIR}"
