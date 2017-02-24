# --------------------------------------------------
# DEPLOYMENT SCRIPT
# --------------------------------------------------

# Create our virtual environment
virtualenv --no-site-packages env
/usr/src/env/bin/pip install --upgrade pip
/usr/src/env/bin/pip --timeout=120 install -r requirements.txt

# These come from having pre-compiled them 
# on this box
cp /usr/local/lib/libgdal.so.20.1.2 .
cp /usr/local/lib/libproj.so.0.7.0 .