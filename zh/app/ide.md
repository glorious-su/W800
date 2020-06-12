# W600 开发环境搭建指南

本文档旨在指导用户创建 W600 的软件环境。本文将通过一个简单的例子来说明如何使用 W600 进行应用开发，包括环境配置、程序编译、固件下载等步骤。

## **1 概述**

W600是联盛德新一代支持多接口、多协议的无线局域网802.11n（1T1R）低功耗 WLAN SoC 芯片。芯片内置 Cortex-M3 CPU处理器和Flash，集成射频收发前端RF Transceiver，CMOS PA功率放大器，基带处理器/媒体访问控制，集成电源管理电路，支持丰富的外围接口， 支持多种加解密协议。W600提供给客户的二次开发空间更大、芯片外围电路器件更少、开发更简便，性价比更优势。

W600芯片只有5mm x 5mm 大小，但集成度非常高。芯片内部集成了 RF Switch、Balun、低噪声放大器、滤波器、功率放大器、电源管理模块等，此外还内置了1MByte Flash，使得芯片外围电路器件更少，且模块体积更小、成本更优。W600不仅提供了更加丰富的接口和更大的内存空间，还集成了各种加解密硬件加速器，可提供更快的加解密算法执行速度。芯片采用业界通用的 Cortex-M3 处理器，代码可移植性更强、开发环境友善。

![image](../.assets/app/ide/block.png)

## **2 准备工作**

**·** **电脑**: 开发环境支持Keil 和GCC

**·** **SDK**: [W600 最新SDK](https://github.com/w600/sdk)

**·** **keil工具链**: MDK （Keil 开发）

**·** **gcc开发环境**: [eclipse + cygwin+ gcc](https://eyun.baidu.com/s/3ghjX5xL)

**·** **TB-01 开发板**（[购买链接](http://shop.thingsturn.com/)）

**·** **Micro USB 线**（需支持数据传输）

## **3 开发板介绍**

TB-01 是一款基于联盛德 W600 的超小体积核心开发板，该开发板引出了芯片的所有IO，并且内置LDO和UART传输芯片，只需一根 Micro USB 数据线与电脑连接即可使用，支持一键下载，外设拥有5个环形LED和2颗按键，调试操作极其方便。

![img](../.assets/app/ide/tb_01.png)

## **4 KEil 环境搭建**

### **4.1 安装MDK 环境搭建**

由于 SDK 需要 Cortex-M3 的 Device Pack 支持，如果在线下载速度较慢 或 安装遇到问题，建议安装 [MDK 5](https://www.keil.com/download/product/) 的同时也安装对应的 [Legacy 版本](http://www.keil.com/mdk5/legacy/)

![img](../.assets/app/ide/mdk_legacy.png)

### **4.2 打开工程**

打开下载的SDK工程，找到 **\SDK\Tools\Keil\Project\WM\_W600.uvproj** 文件并打开

![img](../.assets/app/ide/mdk_open_prj.png)

注意：若提示工程打开失败，请检查 MDK 是否按照上一章节进行正确配置

### **4.3 修改 Demo 示例**

找到main.c，此处的 void UserMain(void) 是用户程序的函数入口

修改 SDK 打印信息

![img](../.assets/app/ide/modify_user_main.png)

### **4.4 编译**

点击菜单栏可进行编译

![img](../.assets/app/ide/mdk_build_prj.png)
控制台窗口输出如下：

![img](../.assets/app/ide/build_output.png)

## **5.GCC环境搭建**

### **5.1 安装**

双击下载的 W600_IDE_Setup.exe ,如图，自行选择要解压的目录；

![img](../.assets/app/ide/decompression.png)

解压后的目录如下

![img](../.assets/app/ide/list.png)

### **5.2 配置**

1.  点击 **ConfigTool.exe** 弹出配置界面；

![img](../.assets/app/ide/En_path.png)

2.  点击 Default 按键，自动搜寻Eclipse Path 和 Cygwin Path路径；

3.  点击 Register 注册 cygwin；

4.  点击保存，使配置生效。可以在任何目录下，右键打开cygwin命令框。

![img](../.assets/app/ide/cygwin.png)

### **5.3 导入新工程**

双击 **IDE.exe** 打开IDE应用程序, IDE内置了一份W600的SDK，不是最新版本，建议更新

1.  点击 **file-> import**

![img](../.assets/app/ide/import.png)

2.  点击 **C/C++**，选择 **Existing Code as Makefile Project**

![img](../.assets/app/ide/import_1.png)

3.  去除 **C++** 支持，选择 **Cygwin GCC** ; 点击 **Browser** , 选中我们之前下载好的SDK工程

![img](../.assets/app/ide/import_2.png)

4.  点击Finish完成工程的导入

### **5.4 编译**

右键需要编译的工程,点击 **Clean project**, 清除完后再右键工程，点击 **Build Project** 即可，出现 Build fininsh！则编译正常无误，可以烧录固件。

![img](../.assets/app/ide/gcc_build.png) 

## **6.固件烧录与调试**

**注意：由于我们在硬件上将 W600 的 RESET 引脚和串口芯片的 RTS 引脚连接在了一起，当您在使用其它串口工具（如 SecureCRT）时，需要去掉开发板上面的 R100 电阻，否则串口可能会无输出。**

固件烧录和调试需依赖[星通智联串口调试助手](https://docs.w600.fun/?p=tools/serial.md)

### **6.1 连接设备**

1. 将开发板与电脑通过 Micro USB 线进行连接
2.  打开星通智联串口调试助手
3. 打开对应的串口，并点击 **复位设备**(或按下 RST 按键) 进行设备复位
4. 串口打印信息如下，说明开发板正常工作
![img](../.assets/app/ide/fw_reboot.png)

**如有异常，请参考以下方法进行检查**

* 检查拔插设备时**设备管理器**是否有变化（变化部分为串口），并检查 [串口驱动](http://wch.cn/downloads/file/65.html) 是否安装成功；
* 若未能发现新增串口，请尝试更换一根 Micro USB 数据线；
* 出现其它打印信息内容或者乱码，请联系对应的销售人员或技术支持人员；

### **6.2 固件烧录及运行**

1. 选择对应的固件，支持 FLS 和 img 格式；FLS 是 WM_W600_sec.img + secboot.img 的合并文件，一般用于芯片的首次下载，之后仅烧录 WM_W600_SEC.img即可。

2.  点击“下载”进行固件下载，波特率默认使用 115200 bps，支持 2Mbps！； 烧录遇到问题的用户请参考:[W600固件烧录指南](https://docs.w600.fun/?p=app/download.md)

3.  观察固件运行信息

 ![img](../.assets/app/ide/fw_download.png)

### **结束**

恭喜！你已完成 W600的入门！

现在你可以尝试其他的示例工程或者直接开发自己的应用程序。





























# W800 开发环境搭建指南

本文档旨在指导用户创建 W800 的软件环境。本文将通过一个简单的例子来说明如何使用 W800 进行应用开发，包括环境配置、程序编译、固件下载、在线调试等步骤。

## **1 概述**


W800 SDK 是集 RTOS 内核，硬件驱动， Wi-Fi 协议栈，蓝牙协议栈， TCP/IP 协议栈，网络应
指令集，多种应用层协议以及相应的示例代码于一体的嵌入式 Wi-Fi、蓝牙应用开发平台。
它提供的功能有：
无线
⚫ 支持 IEEE802.11b/g/n 无线标准
⚫ 支持 BT 4.2
⚫ 支持频率范围： 2.412~2.484 GHz
⚫ 支持基础网（Infra）
➢ 支持多种加密和认证机制： OPEN/WEP64/WEP128/TKIP/CCMP/WPA-PSK/WPA2-P
➢ 支持快速联网模式（指定信道与 BSSID）
➢ 支持无线漫游
➢ 支持 PS-POLL 节能模式
➢ 支持 WPS 功能
⚫ 支持软 AP
➢ 支持 OPEN、 WEP、 TKIP、 AES 加密认证
➢ 最多支持 8 个 station 连接
➢ 支持 STA 的 PS-POLL 节能
⚫ 支持软 APSTA
➢ 支持 2 级级联
➢ 最多支持 8 个 station 连接
驱动
⚫ 支持 SPI、 UART 接口通信
➢ 支持高速 SPI 数据从接口，接口最大速率 20Mbps
➢ 支持 UART 数据接口，接口最大速率 2Mbps
⚫ 支持用户可编程的 GPIO 控制
⚫ 支持 I2S 接口
⚫ 支持 I2C 接口，最大速率 400Kbps ⚫ 支持 7816 接口
⚫ 支持硬件加解密
⚫ 支持外挂 SPI-FLASH
⚫ 支持内置 FLASH
⚫ 支持 ADC 接口
⚫ 支持 PWM 接口
联网
⚫ 支持不同配网方式
➢ ONESHOT
➢ WPS
➢ WEB 页面
➢ AIRKISS
➢ 蓝牙
⚫ 支持 API 方式联网（针对二次开发者）
⚫ 支持 AT 指令方式联网（针对 AT 指令开发者）
TCP/IP 协议
⚫ 支持多种网络协议： TCP/UDP/ICMP/DHCP/DNS
⚫ 支持 DHCP Server、 DNS Server
⚫ 支持 HTTP Client、 HTTP Server 功能
⚫ 支持 IPERF
其它
⚫ 支持 AT 指令集
⚫ 支持标准 socket 接口
⚫ 支持 m-DNS
⚫ 支持 web socket
⚫ 支持 SSL Server、 SSL Client
⚫ 支持 OS 替换
⚫ 支持云移植
⚫ 支持基于串口方式的模块生产测试  

![img](https://www.w600.fun/docs/zh/.assets/app/ide/block.png)

## **2 准备工作**

**·** **电脑**: 开发环境支持CDS 集成开发环境  

**·** **SDK**: [W800 最新SDK](https://github.com/glorious-su/W800/tree/master/zh)

**·** CDS工具链:Simple版本集成ELF工具链 

​                      Full版本集成ELF和LINUX工具链

**·** **TB-08 开发板**（~~[购买链接](http://shop.thingsturn.com/)~~）

**·** **Micro USB 线**（需支持数据传输）

## **3 开发板介绍**

TB-08 是一款基于联盛德 W800 的超小体积核心开发板，该开发板引出了芯片的所有IO，并且内置LDO和UART传输芯片，只需一根 Micro USB 数据线与电脑连接即可使用，支持一键下载，外设拥有5个环形LED和2颗按键，调试操作极其方便。

![image-20200610165430926](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610165430926.png)

## **4 开发环境搭建**

### 4.1 安装CDS

在官网 https://occ.t-head.cn 平头哥芯片开放社区-技术部落-资源下载中可以找到 CDS 集成
开发环境下载链接，下载 CDS 安装包之后，双击压缩包中的 setup.exe 即可启动安装。

![image-20200610115630319](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115630319.png)   

安装中需要用户输入一些信息，根据界面提示输入即可：  

![image-20200610115736348](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115736348.png) ![image-20200610115751359](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115751359.png)

![image-20200610115848644](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115848644.png) 

最后，点击 next 启动安装：  

![image-20200610115923047](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115923047.png) 

![image-20200610115934125](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610115934125.png) 

### 4.2 导入工程

双击图标启动后将工程操作导入到 CDS 中：  

![image-20200610134142709](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134142709.png)

![image-20200610134202292](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134202292.png) 

![image-20200610134212414](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134212414.png) 

![image-20200610134225573](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134225573.png)

完成之后，导入的工程出现在工程管理视图中，如下图所示。  

![image-20200610134323879](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134323879.png)

## 5 编译 SDK

导入 SDK 工程之后，在左侧工程管理视图中右键单击工程，选择 Build Project 开始编译：  

![image-20200610134449714](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610134449714.png)

在 CDS 的 Console 窗口会输出编译信息，如果有错误也会在 Problems 中显示，可以根据提示自行修改。  

![image-20200610135056872](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135056872.png) 

## 6 下载固件

W800 可以使用多种方式下载固件，这里仅以集成 wm_tool 工具下载举例。
首先右键工程依次选择“Make Targets” → “Create…”：  

![image-20200610135215059](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135215059.png) 

在弹出的对话框中按照下图进行设置：  
![image-20200610135246899](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135246899.png)

“Target name”输入“download”；
“Make Target”输入“download DL_PORT=串口号”，如 COM18；
“Build Command”输入“make -f ${project_loc}\..\..\..\..\utilities\download.mk”；
这几条配置，除了串口号用户按需修改之外，其余建议用户直接复制粘贴，填完点击 OK 按钮。
然后右键工程依次选择“Make Targets” → “Build…”：  

![image-20200610135346783](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135346783.png) 

在弹出的对话框中选中刚才配好的“download”项目，点击“Edit…”按钮：  

![image-20200610135423572](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135423572.png) 

这时弹出对话框如下图：  

![image-20200610135442155](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135442155.png) 

直接点击 OK 按钮返回即可。  

![image-20200610135501021](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135501021.png) 

此时，选中刚才配好的“download”项目，点击“Build”按钮即可开始下载固件：  

![image-20200610135617244](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610135617244.png) 

下载过程中，有可能需要用户手动复位开发板，请按照 Console 窗口中的提示信息操作即可。至此，固件的编译和烧录已经成功  

## 7 在线调试  

### 7.1 安装 Debug Server

在官网 https://occ.t-head.cn 平头哥芯片开放社区-技术部落-资源下载中可以找到 Debug
Server 下载链接，下载 Debug Server 安装包之后， Windows 系统下双击压缩包中的 setup.exe
即可启动安装， Linux 系统下执行压缩包中的安装脚本即可启动安装。
注意： Windows 系统下安装 CDS 集成开发环境的话是可选安装 Debug Server 的。（安装CSD时选择了debug sever可跳过此安装环节）  

![image-20200610163251916](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163251916.png)

安装中需要用户输入一些信息，根据界面提示输入即可：  

![image-20200610163326299](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163326299.png)

![image-20200610163335861](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163335861.png)

![image-20200610163341632](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163341632.png)

最后，点击 next 启动安装：  

![image-20200610163419216](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163419216.png)

然后请耐心等待安装完成。  

![image-20200610163434350](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163434350.png)

![image-20200610163443818](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163443818.png)

### 7.2 连接 CK-LINK

先使用杜邦线连接CK-LINK和W800模块，其连接方式如下图：  

![image-20200610163533672](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163533672.png)![image-20200610163907590](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610163907590.png)

打开上述路径打开软件安装位置，双击安装驱动

然后模块供电，并将 CK-LINK 和电脑连接，驱动文件安装正确的话， CK-LINK 的指示灯将会由红色变为黄色。

注意：

要使用调试功能， 需要配置 PA1 和 PA4 的 IO 的复用为调试功能， SDK 里把宏 WM_SWD_ENABLE 置为 1

后编译版本，烧录到板子后即可使用调试器。  



5  s双击桌面图标启动之后，界面会如下显示：

![image-20200610164111624](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610164111624.png)  

第一行会显示 CK-LINK 的版本等信息，如果驱动未安装成功这行信息不会出现；
后面几行显示了 CPU 等芯片信息，如果接线不正确这些信息也不会显示。
当显示无误之后，说明环境已经就绪，此时可以关闭此程序，请阅读下文使用 CDS 集成环境进行调试。  

### 7.3 使用 CDS 集成环境在线调试程序  

6.1 配置工程
导入 SDK 工程之后，在左侧工程管理视图中右键单击工程，如下图选择设置：  

![image-20200610164337845](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610164337845.png)

![image-20200610164344957](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610164344957.png)

6.2 启动调试  

右键工程选择如下：  

![image-20200610164411648](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610164411648.png)

之后根据界面提示操作即可。  

![image-20200610164427410](C:\Users\Y\AppData\Roaming\Typora\typora-user-images\image-20200610164427410.png)

## 8 结束

恭喜！你已完成 W800的环境搭建、程序编译、一种固件下载、在线调试等步骤。

现在你可以尝试其他的示例工程或者直接开发自己的应用程序。