# Para instalar en LINUX

sudo apt-get --assume-yes update

sudo apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen tmux git

git clone https://github.com/ask2tam/gcloud-cpufree-mineXMR.git

cd gcloud-cpufree-mineXMR

cmake .

make install

cd bin

vi config.txt

# Press "[INS]" and edit file, to save press "[ESC]:wq" (meaning write-quit)

cd gcloud-cpufree-mineXMR/bin

tmux

./xmr-stak-cpu

# Then press "[ctrl+b]" and then press "d" now is save to exit without loosing conextion, if you want to return to minig write "tmux attach"
