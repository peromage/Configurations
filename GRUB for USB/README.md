# GRUB for USB

# 如何使用
- 格式化优盘为 ***FAT32*** 格式。  
- 将 **/boot/** **bootmgr** 复制到优盘根目录。  
- 复制 **/etc/** 在一台安装了 ***GRUB2*** 的 Linux 的根目录。  
- 更改所有者 `sudo chown root:root /etc/grub.d/44_usb`。  
- 更改权限 `sudo chmod 755 /etc/grub.d/44_usb`。  
- 执行 `sudo grub-install --target=i386-pc --recheck --boot-directory=/mnt/boot /dev/sdX` 。  
- 根据需要修改 **/etc/grub.d/44_usb** 。  
- 执行 `sudo grub-mkconfig -o /mnt/boot/grub/grub.cfg` 。  
- 将镜像文件放到优盘 **/boot/image/** 下。  

---

# 配置说明
## Arch Linux

* 官方给出的标准配置为：  
```
menuentry '[loopback]archlinux-2014.12.01-dual.iso' {
	set isofile='/boot/iso/archlinux-2014.12.01-dual.iso'
	loopback loop $isofile
	linux (loop)/arch/boot/x86_64/vmlinuz archisodevice=/dev/loop0 img_dev=$imgdevpath img_loop=$isofile earlymodules=loop
	initrd (loop)/arch/boot/x86_64/archiso.img
}
```

有个问题在于引导的时候会提示找不到 */dev/loop0* 从而进入 *grub rescue* 模式。  
解决的办法也很简单，删除 `archisodevice` （似乎不是必须的）。另外 `img_dev` 最好也指定设备的 UUID。  

* 我使用的配置为：  
```
menuentry "Arch Linux dual 2016.09.03" {
	set isofile="/boot/image/archlinux-2016.09.03-dual.iso"
	loopback loop $isofile
	linux (loop)/arch/boot/x86_64/vmlinuz img_dev=/dev/disk/by-uuid/3973-2EAD img_loop=$isofile earlymodules=loop
	initrd (loop)/arch/boot/x86_64/archiso.img
}
```

* 后更改为自动侦测磁盘的 UUID：  
```
menuentry "Arch Linux dual 2016.09.03" {
	set imagefile="${imagedir}archlinux-2016.09.03-dual.iso"
	search --no-floppy --set=imgdisk --file ${imagefile} 
	probe --set=diskuuid --fs-uuid ${imgdisk}
	loopback loop ${imagefile}
	linux (loop)/arch/boot/x86_64/vmlinuz img_dev="/dev/disk/by-uuid/${diskuuid}" img_loop=${imagefile} earlymodules=loop
	initrd (loop)/arch/boot/x86_64/archiso.img
}
```

## Ubuntu

* 官方给出的标准配置为：  
```
 menuentry "Ubuntu 12.04 ISO" {
         set isofile="/home/<username>/Downloads/ubuntu-12.04-desktop-i386.iso"
         # or set isofile="/<username>/Downloads/ubuntu-12.04-desktop-i386.iso"
         # if you use a single partition for your $HOME
         loopback loop (hd0,5)$isofile
         linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile noprompt noeject
         initrd (loop)/casper/initrd.lz
 }
```

其中 `loopback` 时的设备位置不用特别指明，GRUB 启动的地方默认就为 root 了。  
如果此时进入 Live CD 的桌面环境安装系统会导致失败。按照官方文档，原因在于要成功安装系统必须成功卸载 */isodevice* 目录（优盘根目录）。  
解决办法为将其中一行最后加上一个参数：  
`linux /casper/vmlinuz boot=casper iso-scan/filename=/<ISO-name.iso> noprompt noeject toram --`  
其中 `toram` 的作用是试图将镜像所有文件载入到内存中，这样就可以卸载 */isodevice* 了。但如果内存不足则会失败。  
如果 `toram` 不可用，则在进入 Live CD 环境中，使用：  
`sudo umount -l -r -f /isodevice`  
尝试卸载。  
一般 `sudo umount -l /isodevice` 足矣。  

* 我使用的配置为：  
```
menuentry "Ubuntu Desktop amd64 16.04.1" {
	set isofile="/boot/image/ubuntu-16.04.1-desktop-amd64.iso"
	loopback loop $isofile
	linux (loop)/casper/vmlinuz.efi boot=casper iso-scan/filename=$isofile noprompt noeject toram --
	initrd (loop)/casper/initrd.lz
}
```

## Linux Mint

* 配置与 Ubuntu 相同：  
```
menuentry "Linux Mint 18 cinnamon 64bit" {
	set imagefile="${imagedir}linuxmint-18-cinnamon-64bit.iso"
	loopback loop ${imagefile}
	linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=${imagefile} noprompt noeject toram --
	initrd (loop)/casper/initrd.lz
}
```

## Deepin Linux

* 官方配置为：  
```
menuentry "Install Deepin" {
	set gfxpayload=keep
	linux	/live/vmlinuz.efi boot=live union=overlay livecd-installer locale=zh_CN quiet splash --
	initrd	/live/initrd.lz
}
```
无法引导，造成 Kernel Panic 错误。  

* 参考配置为：  
```
menuentry "Deepin Live 15 i386"  {
set isofile="/deepin-15-i386.iso"
search --set -f $isofile
loopback loop (hd0,1)$isofile
linux (loop)/live/vmlinuz boot=live union=overlay live-config findiso=${isofile} locales=zh_CN.UTF-8 quiet splash nomodeset
initrd (loop)/live/initrd.lz
}
```
其中 `findiso=${isofile}` 是必须的，否则无法引导镜像。`toram` 等参数可用，由于镜像较大，等待的时间会比 Ubuntu 等长。去掉 `quiet` `splash` 以监视进度。   

* 我使用的配置为：  
```
menuentry "Deepin 15.3 amd64" {
	set imagefile="${imagedir}deepin-15.3-amd64.iso"
	loopback loop ${imagefile}
	linux (loop)/live/vmlinuz.efi boot=live union=overlay findiso=${imagefile} noprompt noeject toram --
	initrd (loop)/live/initrd.lz
}



```

## Windows PE

与引导 Windows 启动相同，实质就是启动 *boot.wim* 这个镜像。镜像默认在根目录的 *source* 里面，BCD 文件根据需要编辑以更改镜像的位置。  

* 我使用的 GRUB 配置为：  
```
menuentry "Pony PE 20151120 beta" {
	insmod ntldr
	ntldr /BOOTMGR
}
```

* 我使用的 BCD 配置为：  
```
Windows Boot Manager
--------------------
identifier              {bootmgr}
description             Windows Boot Manager
locale                  en-US
inherit                 {globalsettings}
default                 {default}
displayorder            {default}
toolsdisplayorder       {memdiag}
timeout                 30

Windows Boot Loader
-------------------
identifier              {default}
device                  ramdisk=[boot]\boot\image\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}
path                    \windows\system32\boot\winload.exe
description             Windows Setup
locale                  en-US
inherit                 {bootloadersettings}
osdevice                ramdisk=[boot]\boot\image\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}
systemroot              \windows
bootmenupolicy          Standard
detecthal               Yes
winpe                   Yes
ems                     No
```

---

# 版本
## grub.cfg Ver 1.0
- 初始版本  

## grub.cfg Ver 1.2
- 加入镜像文件路径参数  
- 更新 Arch Linux Live CD 引导为自搜寻设备位置  

## grub.cfg Ver 1.5
- 加入 Linux Mint 的支持  
- 加入 Deepin Linux 的支持  
- 加入 Windows PE 的支持  

---

# 附录
[Github: GRUB2 Live ISO Multiboot][https://github.com/thias/glim]  
[Github: Multiboot USB][https://github.com/aguslr/multibootusb]  
[Multiboot USB drive][https://wiki.archlinux.org/index.php/Multiboot_USB_drive]  
[Grub2/ISOBoot][https://help.ubuntu.com/community/Grub2/ISOBoot]  
[Grub2/ISOBoot/Examples][https://help.ubuntu.com/community/Grub2/ISOBoot/Examples]  
[使用GRUB2引导ISO镜像][https://blog.icehoney.me/posts/2013-04-25-grub2-boot-from-iso]  
