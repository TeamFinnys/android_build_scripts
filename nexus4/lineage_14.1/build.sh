#!/bin/bash

# Writing by 19cam92@xda
# Version 5.2

SAUCE=~/android/lineage
ROM=LineageOS
VENDOR=Google
DEVICE=mako
REPO=https://github.com/LineageOS/android.git
BRANCH=cm-14.1

###############################################################################################################################################

printf '\033]2;%s\007' "Building $ROM For $VENDOR $DEVICE"
echo Building $ROM For $VENDOR $DEVICE

# Check to see if repo is installed
if [ -e ~/bin/repo ]; then
	echo " "
	echo "Repo's already installed"
else
	echo " "
	echo "Installing Repo"
	mkdir ~/bin
	curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	echo "Setting Premissions"
	chmod a+x ~/bin/repo
fi

# Make Directory
if [ ! -d "$SAUCE" ]; then
	echo "Making Directory"
	mkdir $SAUCE
fi

# Initializing repository
echo "Initializing $ROM repository"
cd $SAUCE
repo init -u $REPO -b $BRANCH

# Clean's up old build files
echo " "
echo -n "Cleanup old build (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    	echo "Clean old files..."
	SCRIPTDIR="$(dirname "$0")"
	"$SCRIPTDIR/cleanupbuildfiles.sh"
	echo "Done!"
else
    echo "Skipping cleanup "
fi

# Move's to build directory
cd $SAUCE

# Sync lastest source's
echo " "
echo -n "Sync repo (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    	echo "Running repo sync..."
	repo sync
	echo "Done!"
else
    echo "Skipping repo sync"
fi

# Cherrypick commits
echo " "
echo -n "Cherrypick (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    	echo "Cherrypicking..."
	./cherrypick.sh
	echo "Done!"
else
    echo "Skipping cherrypick"
fi

# Enable or disable in build superuser
echo " "
echo -n "Enable build in superuser (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
	echo "Enabling SU..."
	export WITH_SU=true
	echo "Done!"
else
	echo "Disabling SU..."
   	export WITH_SU=false
	echo "Done!"
fi

# Enable or disable ccache
echo " "
echo -n "Enable ccache (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
	echo "Enabling ccache..."
	mkdir ~/.ccache/lineage
	export USE_CCACHE=1
	export CCACHE_DIR=~/.ccache/lineage
	prebuilts/misc/linux-x86/ccache/ccache -M 100G
	echo "Done!"
else
	echo "Disabling ccache..."
   	export USE_CCACHE=0
	echo "Done!"
fi

# Enable or disable ninja wapper
echo " "
echo -n "Disable ninja wapper (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
	echo "Disabling ninja wapper..."
	export USE_NINJA=false
	echo "Done!"
else
	echo "Enabling ninja wapper..."
   	export USE_NINJA=true
	echo "Done!"
fi

# Configre's jack compiler
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"


# Build commands
echo " "
source build/envsetup.sh
breakfast $DEVICE
croot
brunch $DEVICE

# Notifys you if build was successful
if [ -e $SAUCE/out/target/product/$DEVICE/lineage-14.1-*-UNOFFICIAL-$DEVICE-signed.zip ]; then
	echo "Build Successful..."
else
	echo "Build Failed..."
fi

# Kills java after build incase it's still runng
pkill -9 java

read
