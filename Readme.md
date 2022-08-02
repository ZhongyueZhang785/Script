# **Readme**
This script contains four function to measure fuse kernel in Atlas

1. Latency when numjobs = 1 and QD increase

2. Latency when QD fixed and numjobs from 1-8

   
   
# **Install libfuse**

### Install Meson

````
sudo apt install python3-pip

pip3 install --user meson

sudo vim /etc/profile

append this line to the file:  export PATH=~/.local/bin:$PATH

source /etc/profile

meson -v

````
### Install Ninja

````
sudo apt-get install python3 python3-pip ninja-build
````
### Download and Install libfuse
````
https://github.com/libfuse/libfuse
````



# **Prepration before test**
1. please set up the variable in VARIABLE

2. install the following pacakage
````
pip install file_read_backwards

pip install numpy

pip install pandas

pip install matplotlib

git clone https://github.com/brendangregg/FlameGraph
````

3. change the source in every xx_script.sh file

# **Performance Test**



