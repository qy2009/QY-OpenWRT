  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 定制默认IP
sed -i 's/10.0.0.1/10.0.0.254/g' package/base-files/files/bin/config_generate

# 替换默认Argon主题
rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
#git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo




#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译x64固件:
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

# 设置固件大小:
cat >> .config <<EOF
CONFIG_TARGET_KERNEL_PARTSIZE=30
CONFIG_TARGET_ROOTFS_PARTSIZE=200
EOF

# 固件压缩:
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

# 编译UEFI固件:
cat >> .config <<EOF
# CONFIG_EFI_IMAGES is not set
EOF

# IPv6支持:
cat >> .config <<EOF
# CONFIG_PACKAGE_dnsmasq_full_dhcpv6 is not set
# CONFIG_PACKAGE_ipv6helper is not set
EOF

# 多文件系统支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-fs-nfs=y
# CONFIG_PACKAGE_kmod-fs-nfs-common=y
# CONFIG_PACKAGE_kmod-fs-nfs-v3=y
# CONFIG_PACKAGE_kmod-fs-nfs-v4=y
# CONFIG_PACKAGE_kmod-fs-ntfs=y
# CONFIG_PACKAGE_kmod-fs-squashfs=y
# EOF

# 不要其他硬件支持:
cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-8139cp is not set
# CONFIG_PACKAGE_kmod-8139too is not set
# CONFIG_PACKAGE_kmod-bnx2 is not set
# CONFIG_PACKAGE_kmod-phy-realtek is not set
# CONFIG_PACKAGE_kmod-r8125 is not set
# CONFIG_PACKAGE_kmod-r8169 is not set
# CONFIG_PACKAGE_kmod-usb-net-rtl8152 is not set
# CONFIG_DEFAULT_kmod-ac97 is not set
# CONFIG_DEFAULT_kmod-ath10k is not set
# CONFIG_DEFAULT_kmod-ath5k is not set
# CONFIG_DEFAULT_kmod-ath9k is not set
# CONFIG_DEFAULT_kmod-ath9k-htc is not set
# CONFIG_DEFAULT_kmod-sound-hda-codec-realtek is not set
# CONFIG_DEFAULT_kmod-sound-hda-codec-via is not set
# CONFIG_DEFAULT_kmod-sound-hda-core is not set
# CONFIG_DEFAULT_kmod-sound-via82xx is not set
# CONFIG_DEFAULT_kmod-usb-audio is not set
# CONFIG_DEFAULT_kmod-usb-hid is not set
# CONFIG_DEFAULT_kmod-usb-net is not set
# CONFIG_DEFAULT_kmod-usb-net-asix is not set
# CONFIG_DEFAULT_kmod-usb-net-asix-ax88179 is not set
# CONFIG_DEFAULT_kmod-usb-net-rtl8150 is not set
# CONFIG_DEFAULT_kmod-usb-net-rtl8152 is not set
EOF

# USB3.0支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-usb-ohci is not set
# CONFIG_PACKAGE_kmod-usb-ohci-pci is not set
# CONFIG_PACKAGE_kmod-usb2 is not set
# CONFIG_PACKAGE_kmod-usb2-pci is not set
# CONFIG_PACKAGE_kmod-usb3 is not set
# EOF

# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-serverchan=y
CONFIG_PACKAGE_luci-app-adguardhome=y
# CONFIG_PACKAGE_luci-app-smartinfo is not set
CONFIG_PACKAGE_open-vm-tools=y
EOF

# ShadowsocksR插件:
# cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Server is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Socks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray= is not set
# EOF

# 常用LuCI插件选择:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Kcptun is not set
# CONFIG_PACKAGE_luci-app-transmission is not set
# CONFIG_PACKAGE_luci-app-qbittorrent is not set
# CONFIG_PACKAGE_luci-app-xlnetacc is not set
# CONFIG_PACKAGE_luci-app-zerotier is not set
# CONFIG_PACKAGE_luci-app-v2ray-server is not set
# CONFIG_PACKAGE_luci-app-pptp-server is not set
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set
CONFIG_PACKAGE_luci-app-adbyby-plus=y
# CONFIG_PACKAGE_luci-app-softethervpn= is not set
# CONFIG_PACKAGE_luci-app-haproxy-tcp is not set
CONFIG_PACKAGE_luci-app-webadmin=y
# CONFIG_PACKAGE_luci-app-frpc is not set
CONFIG_PACKAGE_luci-app-wrtbwmon=y
# CONFIG_PACKAGE_luci-app-hd-idle is not set
# CONFIG_PACKAGE_luci-app-ddns is not set
# CONFIG_PACKAGE_luci-app-samba is not set
# CONFIG_PACKAGE_luci-app-accesscontrol is not set
# CONFIG_PACKAGE_luci-app-vsftpd is not set
EOF

# LuCI主题:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-theme-netgear=y
CONFIG_PACKAGE_luci-theme-opentomcat=y
CONFIG_PACKAGE_luci-theme-bootstrap=y
EOF

# 常用软件包:
cat >> .config <<EOF
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
# CONFIG_PACKAGE_screen=y
# CONFIG_PACKAGE_tree=y
# CONFIG_PACKAGE_vim-fuller=y
CONFIG_PACKAGE_wget=y
EOF

# 取消编译VMware镜像以及镜像填充 (不要删除被缩进的注释符号):
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_PAD is not set
CONFIG_VMDK_IMAGES is not set
EOF

# 
# ========================固件定制部分结束========================
# 


sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
