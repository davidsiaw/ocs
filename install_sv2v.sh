cd /opt

# install sv2v
wget -qO- https://get.haskellstack.org/ | sh
git clone https://github.com/zachjs/sv2v.git
pushd sv2v
make
cp bin/sv2v /usr/local/bin/
popd
