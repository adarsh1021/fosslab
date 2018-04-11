# Kernel Compilation

### Step 1 - Get the kernel
Download the kernel from https://www.kernel.org/  
The latest kernel : https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.1.tar.xz  

### Step 2 - Install required packages
To install the packages execute : 
```
sudo apt-get update
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc
```

### Step 3 - Extract the kernel
To extract the kernel execute : 
```
tar xf linux-4.7.1.tar.xz
cd linux-4.7.1.tar.xz
```

### Step 4 - Configuring and compiling
To configure the modules to be installed : 
```
make menuconfig
```
To compile and install the kernel : 
```
sudo make -j 4
sudo make modules_install -j 4
sudo make install -j 4
```

### Step 5 - Update grub
```
sudo update-grub
```