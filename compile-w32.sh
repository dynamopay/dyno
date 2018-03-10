mkdir /root/r1
mkdir /root/r1/dyno-w32
mkdir /root/r1/dyno-w32/depends
cp -r depends/i686-w64-mingw32 /root/r1/dyno-w32/depends

echo "sudo ./autogen.sh" > run.sh
echo "sudo ./configure --prefix=/root/r1/dyno-w32/depends/i686-w64-mingw32 --disable-tests" >> run.sh
echo "sudo make -j$(nproc)" >> run.sh
sudo chmod +x run.sh
sudo ./run.sh
