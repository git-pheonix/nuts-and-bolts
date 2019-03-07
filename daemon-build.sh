#!/bin/sh

daemon=${1:-"pcepd"}
run_mode=${2:-"build"}
Arch=${3:-"octeon"}
IxOS=${4:-"8.60"}

echo "Parameters: Run Mode([build]/clean): $run_mode, Architechture([octeon]/ppc750/x86_64/i686): $Arch, IxOS([8.10]/...): $IxOS"

tot_cpu_num=`grep -c ^processor /proc/cpuinfo`
cpu_usable=`expr $tot_cpu_num - 1`
target_tar="c_$daemon.tar"
echo "Building $target_tar"
logfile="$daemon-$Arch-$run_mode.log"

rm $logfile

if [ "$run_mode" = "build" ];
then
	if [ "$Arch" = "octeon" ];
	then
		echo "scons -j $cpu_usable cpu=$Arch platform=$IxOS kernel=3.10 $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -j $cpu_usable cpu=$Arch kernel=3.10 platform=$IxOS $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile
	elif [ "$Arch" = "x86_64" ];
	then
		echo "scons -j $cpu_usable cpu=$Arch userspace_abi=64 platform=$IxOS kernel=3.10 $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -j $cpu_usable cpu=$Arch kernel=3.10 userspace_abi=64 platform=$IxOS $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile
	elif [ "$Arch" = "ppc750" ];
	then
		echo "scons -j $cpu_usable cpu=$Arch platform=$IxOS $Arch/$IxOS/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -j $cpu_usable cpu=$Arch platform=$IxOS $Arch/$IxOS/ixps/$target_tar 2>&1 | tee -a $logfile
	fi		
elif [ "$run_mode" = "clean" ];
then
	if [ "$Arch" = "octeon" ];
	then
		echo "scons -c -j $cpu_usable cpu=$Arch platform=$IxOS kernel=3.10 $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -c -j $cpu_usable cpu=$Arch kernel=3.10 platform=$IxOS $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile
	elif [ "$Arch" = "x86_64" ];
	then
		echo "scons -c -j $cpu_usable cpu=$Arch userspace_abi=64 platform=$IxOS kernel=3.10 $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -c -j $cpu_usable cpu=$Arch kernel=3.10 userspace_abi=64 platform=$IxOS $Arch/$IxOS/3.10/ixps/$target_tar 2>&1 | tee -a $logfile
	elif [ "$Arch" = "ppc750" ];
	then
		echo "scons -c -j $cpu_usable cpu=$Arch platform=$IxOS $Arch/$IxOS/ixps/$target_tar 2>&1 | tee -a $logfile"
		scons -c -j $cpu_usable cpu=$Arch platform=$IxOS $Arch/$IxOS/ixps/$target_tar 2>&1 | tee -a $logfile
	fi
fi
