# Para instalar en LINUX

sudo apt-get --assume-yes update

sudo apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen tmux git nano

git clone https://github.com/ask2tam/xmr-stak-cpu.git

cd xmr-stak-cpu

cmake .

make install

cd bin/

tmux 

./xmr-stak-cpu

** Then press ctrl + b at the same time and then press d para volver a la pantalla inicial **
tmux attach
