echo $DEBIAN_MIRROR

echo "Acquire::http { Proxy \"$DEBIAN_MIRROR\"; };" | tee /etc/apt/apt.conf.d/02proxy

lb config --apt-http-proxy=$DEBIAN_MIRROR
lb build

ls

mv *.iso /tmp/builds/
