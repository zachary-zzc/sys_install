# !/bin/bash ~

# check ubuntu version
echo "Check your ubuntu version"
lsb_release -r

# maybe need to config update manager settings to find new release version
# should check if there is a new release
read -p "Do you want to update to newer release? [y/n] " SYS_UPGRADE

if [ $SYS_UPGRADE = "Y" ] || [ $SYS_UPGRADE = "y" ]
then
    do-release-upgrade
fi

# upgrade all packages
echo "upgrade packages"
# sudo apt-get update
# sudo apt-get dist-upgrade

# install linear algebra libraries
echo "install linear algebra libraries"
sudo apt-get install liblapack-dev libblas-dev libopenblas-dev libarpack2-dev

# install fortran compiler
echo "install fortran compiler"
sudo apt-get install gfortran gfortran-doc

# install other packages
echo "install other packages"
sudo apt-get install cmake rpm automake

# install packages
echo "install essential packages"
sudo apt-get install build-essential 
sudo apt-get install binutils-doc cpp-doc gcc-4.7-doc gcc-doc glibc-doc libstdc++6-4.7-dev stl-manual cpp-4.7-doc manpages manpages-dev

# install git
echo "install git"
sudo apt-get install git
# config git
read -p "Input your git user name : " GIT_USERNAME
git config --global user.name "$GIT_USERNAME"

read -p "Input your git email address : " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

read -p "Input your git core editor [vim]: " GIT_EDITOR
if [ $GIT_EDITOR = "" ]
then
    GIT_EDITOR=vim
fi
git config --global core.editor "$GIT_EDITOR"

read -p "Input your git diff tool [vimdiff]: " GIT_DIFF
if [ $GIT_DIFF = "" ]
then
    GIT_DIFF=vimdiff
fi
git config --global merge.tool "$GIT_DIFF"

echo "confirm your git config : "
git config --list
read -p "Press [Enter] key to continue"

# generate ssh keys
read -p "Do you need to generate new ssh keys? [y/n] " SSH_KEY
if [ $SSH_KEY = "Y" ] || [ $SSH_KEY = "y" ]
then
    read -p "Input your email address as ssh key label : " EMAIL
    ssh-keygen -t rsa -C "$EMAIL"
    # add this new key to the ssh-agent
    ssh-add ~/.ssh/id_rsa
    read -p "Do you need to set this ssh key to github? [y/n] " SSH_GITHUB
    if [ $SSH_GITHUB = "Y" ] || [ $SSH_GITHUB = "y" ]
    then
        sudo apt-get install xclip
        # copy id_rsa.pub file to clipboard
        xclip -sel clip < ~/.ssh/id_rsa.pub
        echo "please do as the following steps:"
        read -p "Press [ENTER] to start ADD SSH-KEY to GITHUB"
        firefox https://github.com/settings/ssh
        echo "1. Click \"Add SSH key\""
        echo "2. In the Title field, add a descriptive label for the new key"
        echo "3. Click right mouse and paste your key into Key field"
        echo "4. Click Add Key"
        echo "5. Confirm the action by entering your Github password"
        echo "Test Everything out"
        ssh -T git@github.com
        read -p "Press [ENTER] to continue"
    fi
fi

# install vim
echo "install vim"
sudo apt-get install vim

# set up vim
echo "set up vim"
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
chmod a+x install_*
sh ~/.vim_runtime/install_awesome_vimrc.sh
# install ctags
sudo apt-get install ctags

# try Vundle later
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Config Vundle

# check python, check python3
echo "check python and python3"
python --version
# fix this later
if [ -e $(python3 --version | grep "command not found") ]
then
    echo "python3 not installed"
    sudo apt-get install python3
fi
python3 --version

# config python, python3
echo "config python, python3"
echo "install numpy, scipy, matplotlib, pandas, pip, sympy, nose"
sudo apt-get install python-numpy python-scipy python-matplotlib python-pandas python-pip python-sympy python-nose
sudo apt-get install python3-numpy python3-scipy python3-matplotlib python3-pandas python3-pip python3-nose
echo "install ipython, ipython-notebook"
sudo apt-get install ipython ipython-doc ipython-notebook ipython-qtconsole
sudo apt-get install ipython3 ipython3-notebook ipython3-qtconsole

# install octave
echo "install octave, version 3.8.1, 7/3/2014 released"
read -p "Would you like to install this version? [y/n] " OCTAVE

OCT_INSTALLED=$false
if [ $OCTAVE = 'Y' ] || [ $OCTAVE = 'y' ]
then
    wget -c ftp://ftp.gnu.org/gnu/octave/octave-3.8.1.tar.gz
    tar zxvf octave-3.8.1.tar.gz
    cd octave-3.8.1
    # pre packages
    sudo apt-get install gfortran debhelper automake dh-autoreconf texinfo texlive-latex-base texlive-generic-recommended epstool transfig pstoedit libreadline-dev libncurses5-dev gperf libhdf5-serial-dev libblas-dev liblapack-dev libfftw3-dev texi2html less libpcre3-dev flex libglpk-dev libsuitesparse-dev gawk ghostscript libcurl4-gnutls-dev libqhull-dev desktop-file-utils libfltk1.3-dev libgl2ps-dev libgraphicsmagick++1-dev libftgl-dev libfontconfig1-dev libqrupdate-dev libarpack2-dev dh-exec libqt4-dev libqscintilla2-dev default-jdk dpkg-dev gnuplot-x11 libbison-dev libxft-dev llvm-dev
    ./configure
    make
    sudo make install
    cd ../
    # check if octave installed correctly
    if [ $(octave --version | grep "command not found") ]
    then
        OCT_INSTALLED=$true
    fi
fi

if [ $OCT_INSTALLED = $true ]
then
    rm -r octave*
fi

if [ $OCT_INSTALL -eq $false ]
then
    echo "Haven't installed octave, please manually install it later"
fi

# install chromium
echo "install chromium"
sudo apt-get install chromium-browser
echo "set up adobe flash for chromium"
# code for install adobe flash plugin for chromium
echo "please add this feature later"

# install vmware
# code for install vmware

# install NVIDIA DRIVER
# finally i give up install NVIDIA DRIVER...
lspci | grep "VGA"

# set up 3D acceleration for vmware
