# run with venv
qt_io_url=https://download.qt.io/development_releases/prebuilt/libclang/
libclang_link=libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
echo "Please enter your qtpaths. It should look somthing like this /home/<your username>/Qt/6.3.1/gcc_64/bin/qtpaths" 
read qtpaths_var
echo "Please enter the link for the prebuilt binaries of libclang from <${qt_io_url}>"
echo "Press <Enter> to download the default is <${libclang_link}>"
read other_libclang
if [ ${#other_libclang} -ne 0 ]; then
    libclang_link=other_libclang
fi
echo "Downloading ${qt_io_url}${libclang_link} "
wget $qt_io_url+$libclang_link
7z x $libclang_link
rm $libclang_link
export CLANG_INSTALL_DIR=$PWD/libclang
git clone --recursive https://code.qt.io/pyside/pyside-setup
cd pyside-setup && git checkout 6.3.1
source ../venv/bin/activate
python -m pip install -r requirements.txt
python -m pip install setuptools==62.3.3 # resolves https://codereview.qt-project.org/c/pyside/pyside-setup/+/415268
python setup.py install --qtpaths=$qtpaths_var --build-tests --ignore-git --parallel=8

