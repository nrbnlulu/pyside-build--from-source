# run with venv
qt_io_url=https://download.qt.io/development_releases/prebuilt/libclang/
default_prebuilt=libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
echo "Please enter your qtpaths. It should look somthing like this /home/<your username>/Qt/6.3.1/gcc_64/bin/qtpaths" 
read qtpaths_var
echo "Please enter the link for the prebuilt binaries of libclang from <${qt_io_url}>"
echo "Press <Enter> to download the default is <${default_prebuilt}>"
read libclang_link
if [ ${#libclang_link} -eq 0 ]; then
    wget https://download.qt.io/development_releases/prebuilt/libclang/$default_prebuilt
else
    wget $qt_io_url+$libclang_link
fi

7z x libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
rm libclang-release_100-based-linux-Rhel7.6-gcc5.3-x86_64.7z
export CLANG_INSTALL_DIR=$PWD/libclang
git clone --recursive https://code.qt.io/pyside/pyside-setup
cd pyside-setup && git checkout 6.3.1
source ../venv/bin/activate
python -m pip install -r requirements.txt
python -m pip install setuptools==62.3.3 # resolves https://codereview.qt-project.org/c/pyside/pyside-setup/+/415268
python setup.py install --qtpaths=$qtpaths_var --build-tests --ignore-git --parallel=8

