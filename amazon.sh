#these are all the commands to configure an amazon instance for what I'm doing

sudo yum update
sudo yum install git
(wget -O - pi.dk/3 || curl pi.dk/3/ || fetch -o - http://pi.dk/3) | bash
git clone https://github.com/swampthings/thai-frequency.git

sudo mkdir /mnt/ramdisk/
sudo mount -t tmpfs -o size=5500m tmpfs /mnt/ramdisk

tar -xvzf wiki-orig.txt.tar.gz

cp /home/ec2-user/wiki-orig.txt /mnt/ramdisk/
cp /home/ec2-user/thai-frequency/try2/storeddata/wordlist123k.txt /mnt/ramdisk/
cp /home/ec2-user/thai-frequency/try2/try2.sh /mnt/ramdisk/


#then run try2
./try2.sh . &
