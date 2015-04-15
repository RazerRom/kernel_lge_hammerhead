#!/system/bin/sh

CFG="/sdcard/chroma.cfg"

touch /sdcard/chroma.log
echo $(date) >> /sdcard/chroma.log

if [ ! -f /sdcard/chroma.cfg ]; then
	echo "cfg not present > creating chroma.cfg" >> /sdcard/chroma.log;
	cp /system/addon.d/00-chroma_kernel.cfg /sdcard/chroma.cfg;
	chmod 755 $CFG;
fi
echo "loaded values!" >> /sdcard/chroma.log;

###
#
# Start Apllying Value....
#
#
# WARNING: Do not mess up here!
#
##

# Set Sweep2Wake
s2w="`grep "s2w_cfg" $CFG | cut -d '=' -f2`"
echo $s2w > /sys/android_touch/sweep2wake;

# Set Sweep2Wake
s2s="`grep "s2s_cfg" $CFG | cut -d '=' -f2`"
echo $s2s > /sys/android_touch/sweep2sleep;

# Set Doubletap2wake
dt2w="`grep "dt2w_cfg" $CFG | cut -d '=' -f2`"
echo $dt2w > /sys/android_touch/doubletap2wake;

# Set S2W/DT2W Power Key Toggle
pwrkey="`grep "pwrkey_cfg" $CFG | cut -d '=' -f2`"
echo $pwrkey > /sys/module/qpnp_power_on/parameters/pwrkey_suspend;

# Set Cooler Colors
color="`grep "color_cfg" $CFG | cut -d '=' -f2`"
echo $color > /sys/module/mdss_dsi/parameters/color_preset;

# Set Wake Vibration Strength
vib="`grep "vib_cfg" $CFG | cut -d '=' -f2`"
echo $vib > /sys/android_touch/vib_strength;

# Set Wake Timeout
wt="`grep "wt_cfg" $CFG | cut -d '=' -f2`"
echo $wt > /sys/android_touch/wake_timeout;

# Set CPU Settings (Use app to set in boot for CPU Settings only! Do not edit manually unless you know what you doing!)
echo 1 > /sys/devices/system/cpu/cpu0/online;
echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor;
echo 1 > /sys/devices/system/cpu/cpu1/online;
echo conservative > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor;
echo 1 > /sys/devices/system/cpu/cpu2/online;
echo conservative > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor;
echo 1 > /sys/devices/system/cpu/cpu3/online;
echo conservative > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor;
echo 1190400 > /sys/devices/system/cpu/cpufreq/conservative/input_boost_freq;
echo 40 > /sys/devices/system/cpu/cpufreq/conservative/down_threshold;
echo 10000 > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate;
echo 40000 > /sys/devices/system/cpu/cpufreq/conservative/input_boost_duration;
echo 90 > /sys/devices/system/cpu/cpufreq/conservative/up_threshold;
echo 10000 > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate_min;
echo 10 > /sys/devices/system/cpu/cpufreq/conservative/freq_step;
echo 1 > /sys/devices/system/cpu/cpufreq/conservative/sampling_down_factor;
echo 0 > /sys/devices/system/cpu/cpufreq/conservative/ignore_nice_load;

# Set CPU Max Frequency
cpu_max="`grep "cpu_max_cfg" $CFG | cut -d '=' -f2`"
echo $cpu_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq;
echo $cpu_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq;
echo $cpu_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq;
echo $cpu_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq;

# Set CPU Min Frequency
cpu_min="`grep "cpu_min_cfg" $CFG | cut -d '=' -f2`"
echo $cpu_min > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq;
echo $cpu_min > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq;
echo $cpu_min > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq;
echo $cpu_min > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq;


# Set Max Screen Off
max_off_enable="`grep "max_off_enable_cfg" $CFG | cut -d '=' -f2`"
echo $max_off_enable > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max;

# Set backlight dimmer
backlight="`grep "backlight_cfg" $CFG | cut -d '=' -f2`"
echo $backlight > /sys/module/lm3630_bl/parameters/backlight_dimmer;

# Set fsync
fsync="`grep "fsync_cfg" $CFG | cut -d '=' -f2`"
echo $fsync > /sys/module/sync/parameters/fsync_enabled;

# Set GPU Governor
gpu_gov="`grep "gpu_gov_cfg" $CFG | cut -d '=' -f2`"
echo $gpu_gov > /sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;

# Set GPU Governor
gpu_freq="`grep "gpu_freq_cfg" $CFG | cut -d '=' -f2`"
echo $gpu_freq > /sys/class/kgsl/kgsl-3d0/max_gpuclk;

# Set Global Vibration
global_vib="`grep "global_vib_cfg" $CFG | cut -d '=' -f2`"
echo $global_vib > /sys/class/timed_output/vibrator/amp;

# Set IO scheduler
iosched="`grep "iosched_cfg" $CFG | cut -d '=' -f2`"
echo $iosched > /sys/block/mmcblk0/queue/scheduler;

# Set Readahead
readahead="`grep "readahead_cfg" $CFG | cut -d '=' -f2`"
echo $readahead > /sys/block/mmcblk0/queue/read_ahead_kb;


echo $s2w >> /sdcard/chroma.log;
echo "Success !\n\n" >> /sdcard/chroma.log
