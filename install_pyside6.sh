# run with venv
wget https://download.qt.io/development_releases/prebuilt/libclang/libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
7z x libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
export CLANG_INSTALL_DIR=$PWD/libclang
git clone --recursive https://code.qt.io/pyside/pyside-setup
cd pyside-setup && git checkout 6.3.1
source ../venv/bin/activate
python -m pip install -r requirements.txt
python -m pip install setuptools==62.3.3
# replace </home/nir/Qt/6.3.1/gcc_64/bin/qtpaths> with your path 
python setup.py install --qtpaths=/home/nir/Qt/6.3.1/gcc_64/bin/qtpaths --build-tests --ignore-git --parallel=8
