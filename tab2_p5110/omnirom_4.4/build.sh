#!/bin/bash

SAUCE=~/android/omni-4.4
ROM=OmniROM
VENDOR=Samsung
DEVICE=espressowifi
REPO=https://github.com/omnirom/android.git
BRANCH=android-4.4
CCACHESIZE=50G

###############################################################################################################################################

printf '\033]2;%s\007' "Building $ROM For $VENDOR $DEVICE"
echo Building $ROM For $VENDOR $DEVICE
echo " "
echo "Writing by 19cam92@xda"
echo "Script version 5.3"

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

# Add Android SDK platform tools to path
if [ -d "$HOME/android/platform-tools" ] ; then
	export PATH="$HOME/android/platform-tools:$PATH"
fi

# Make Directory
if [ ! -d "$SAUCE" ]; then
	echo "Making Directory"
	mkdir $SAUCE
fi

# Move's to build directory
cd $SAUCE

# Initializing repository
echo "Initializing $ROM repository"
repo init -u $REPO -b $BRANCH

# Clean's up old build files
echo " "
echo -n "Cleanup old build (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    	echo "Clean old files..."
	make clean
else
    echo "Skipping cleanup "
fi

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
	prebuilts/misc/linux-x86/ccache/ccache -M $CCACHESIZE
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

export LC_ALL=C

# Configre's jack compiler
echo " "
echo -n "Configre's jack compiler to 4G (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
	echo "Setting jack compiler to 4G..."
	export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
	echo "Done!"
fi

# Build commands
echo " "
source build/envsetup.sh
breakfast $DEVICE
croot
brunch $DEVICE

# Notifys you if build was successful
if [ -e $SAUCE/out/target/product/$DEVICE/lineage-*.zip ]; then
	echo "Build Successful..."
else
	echo "Build Failed..."
fi

# Kills java after build incase it's still runng
pkill -9 java

read
