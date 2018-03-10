mkdir /root/r1
mkdir /root/r1/dyno-l
mkdir /root/r1/dyno-l/depends
cp -r depends/x86_64-pc-linux-gnu /root/r1/dyno-l/depends

echo "sudo ./autogen.sh" > run.sh
echo "sudo ./configure --prefix=/root/r1/dyno-l/depends/x86_64-pc-linux-gnu --disable-tests" >> run.sh
echo "sudo make -j$(nproc)" >> run.sh
sudo chmod +x run.sh
sudo ./run.sh
