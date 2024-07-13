## build described at https://wiki.winehq.org/Building_Wine#Shared_WoW64

source $stdenv/setup
preFlags="${configureFlags}"

unpackPhase
cd $TMP/$sourceRoot
patchPhase

configureScript=$TMP/$sourceRoot/configure
mkdir -p $TMP/wine-wow $TMP/wine64

cd $TMP/wine64
sourceRoot=`pwd`
configureFlags="${preFlags} --enable-win64"
configurePhase
buildPhase
# checkPhase

cd $TMP/wine-wow
sourceRoot=`pwd`
configureFlags="${preFlags} --with-wine64=../wine64"
configurePhase
buildPhase
# checkPhase

eval "$preInstall"
cd $TMP/wine-wow && make install -j$NIX_BUILD_CORES
cd $TMP/wine64 && make install -j$NIX_BUILD_CORES
eval "$postInstall"
fixupPhase
