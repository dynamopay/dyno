mkdir /root/r1
mkdir /root/r1/dyno-w64
mkdir /root/r1/dyno-w64/depends
cp -r depends/x86_64-w64-mingw32 /root/r1/dyno-w64/depends

echo "sudo ./autogen.sh" > run.sh
echo "sudo ./configure --prefix=/root/r1/dyno-w64/depends/x86_64-w64-mingw32 --disable-tests" >> run.sh
echo "sudo make -j$(nproc)" >> run.sh
sudo chmod +x run.sh
sudo ./run.sh
