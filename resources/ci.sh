# Create a directory for git to clone into, so it doesn't use the repository name.
cd /build && mkdir target

# Clone into repository specified by ${URL}
cd target && git clone ${URL} .

echo "ci.sh: Cloned repository ${URL}"

# Create a directory for cmake to output build files to.
mkdir cmake_build_dir

echo "ci.sh: Checking WPILib version..."

# Find current WPILib version
version="$(wget --quiet http://first.wpi.edu/FRC/roborio/release/eclipse/plugins/ && cat index.html | grep wpilib.plugins.cpp | sed -r 's/^.*wpilib.plugins.cpp_(.*).jar.*$/\1/')"

# Check the embedded downloaded version
source /build/wpilib.version

if [ ! "${version} = ${downloaded_version}" ] ; then
	echo "WPILib version is outdated! Please check for a new image binary"
	echo "and open an issue on Github if not found."
	echo "Link: https://github.com/WardBenjamin/FRC_CI"
	/bin/bash /util/downloadwpilib.sh
	exit 1
fi

echo "ci.sh: WPILib version good!"

echo "ci.sh: Generating CMake files..."

cd cmake_build_dir
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=/cmake/arm.cmake /cmake/robot.cmake .. > /dev/null


echo "ci.sh: Making project"

make VERBOSE=1
