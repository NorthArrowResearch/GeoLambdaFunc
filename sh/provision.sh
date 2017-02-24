# This should be run on an EC2 box and then have an image
# taken so that the AMI can be reused. Compiling GDAL can take
# 30-40 minutes so beware of that

yum update -y
yum upgrade -y
yum install gcc gcc-c++ make libtool curl python27-devel python27-pip python-numpy gcc libjpeg-devel zlib-devel git -y

# Now we need to get Proj4
wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
tar -zvxf proj-4.8.0.tar.gz
cd proj-4.8.0
./configure
make
make install
 
yum install ImageMagick -y

# Here is the trick I had to add to get around the following -fPIC error
# /usr/bin/ld: /root/gdal-1.9.1/frmts/o/.libs/aaigriddataset.o: relocation R_X86_64_32S against `vtable for AAIGRasterBand' can not be used when making a shared object; recompile with -fPIC
cd ../
wget http://download.osgeo.org/gdal/2.1.2/gdal212.zip
unzip gdal212.zip
wget http://zlib.net/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz

export CC="gcc -fPIC"
export CXX="g++ -fPIC"
 
cd gdal-2.1.2/
./configure --with-static-proj4
make
make install
 
export CC="gcc"
export CXX="g++"
 
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
export GDAL_CONFIG=/home/ec2-user/lambda/local/bin/gdal-config

# This is the virtualenv setup
pip install --upgrade pip
pip install virtualenv