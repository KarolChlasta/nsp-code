echo "kernel name: " ` uname --kernel-name`      
echo "network node hostname: " `uname  --nodename`      
echo "kernel release: " `uname  --kernel-release`  
echo "kernel version: " `uname  --kernel-version`    
echo "machine hardware name: " `uname  --machine`          
echo "processor type (non-portable): " `uname  --processor`         
echo "hardware platform (non-portable): " `uname  --hardware-platform` 
echo "operating system: " `uname  --operating-system`


echo "hardware info"
lshw

echo "CPU info"
lscpu

echo "Block info"
lsblk

echo "mounted filesystems"
 df -kH

echo "PCI info"
 lspci


  smem -tpm
  smem -tkm
  smem -tp
  smem -tk
  smem -tku
  smem -tpu


