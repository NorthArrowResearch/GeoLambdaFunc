# --------------------------------------------------
# DEPLOYMENT SCRIPT
# --------------------------------------------------

HOMEDIR=${PWD}
VIRTUAL_ENV=$HOMEDIR/env
ZIPFILE=$HOMEDIR/Deploy.zip
S3URL=s3://nartesting/LAMBDA/functioname/func.zip

rm $ZIPFILE

# Create our virtual environment
virtualenv --no-site-packages envdeac
/usr/src/env/bin/pip install --upgrade pip
/usr/src/env/bin/pip --timeout=120 install -r requirements.txt

# These come from having pre-compiled them 
# on this box
zip -9 $ZIPFILE /usr/local/lib/libgdal.so.20.1.2 .
zip -9 $ZIPFILE /usr/local/lib/libproj.so.0.7.0 .

# Add our virtualenv libraries
cd $VIRTUAL_ENV/lib/python2.7/site-packages
zip -r9 $ZIPFILE *
cd $VIRTUAL_ENV/lib64/python2.7/site-packages
zip -r9 $ZIPFILE *

# Now add our python code
cd $HOMEDIR
zip -r9 $ZIPFILE *.py

# Now for the actual deploy
aws s3 cp $ZIPFILE $S3URL