if [ ! -f "resources/wpilib.version" ] || [ ! -f "resources/cpp.zip" ]; then

  echo "export downloaded_version=$(wget --quiet http://first.wpi.edu/FRC/roborio/release/eclipse/plugins/ && cat index.html | grep wpilib.plugins.cpp | sed -r 's/^.*wpilib.plugins.cpp_(.*).jar.*$/\1/')" > resources/wpilib.version

  rm index.html

  source resources/wpilib.version

  wget -O wpicppjar.zip http://first.wpi.edu/FRC/roborio/release/eclipse/plugins/edu.wpi.first.wpilib.plugins.cpp_${downloaded_version}.jar
unzip wpicppjar.zip resources/cpp.zip

  rm wpicppjar.zip

fi

docker build -t frc_ci .
