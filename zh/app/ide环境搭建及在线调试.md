# W800 开发环境搭建指南

本文档旨在指导用户创建 W800 的软件环境。本文将通过一个简单的例子来说明如何使用 W800 进行应用开发，包括环境配置、程序编译、固件下载、在线调试等步骤。

## **1 概述**

W800 芯片是一款安全 IoT Wi-Fi/蓝牙 双模 SoC 芯片。支持 2.4G IEEE802.11b/g/n Wi-Fi 通讯协议；
支持 BT/BLE 双模工作模式，支持 BT/BLE4.2 协议。芯片集成 32 位 CPU 处理器，内置 UART、 GPIO、 SPI、
I2C、 I2S、 7816 等数字接口；支持多种硬件加解密算法，内置 DSP、浮点运算单元与安全引擎，支持代码安
全权限设置， 内置 2MBFlash 存储器， 支持固件加密存储、固件签名、安全调试、安全升级等多项安全措
施，保证产品安全特性。 适用于用于智能家电、智能家居、智能玩具、无线音视频、工业控制、医疗监护
等广泛的物联网领域

![image-20200617102157395](../.assets/app/ide/W800.png)



## **2 准备工作**

**·** **电脑**: 开发环境支持CDS 集成开发环境  

**·** **SDK**: [W800 最新SDK](https://github.com/glorious-su/W800/tree/master/zh)

**·** CDS工具链:Simple版本集成ELF工具链 

​                      Full版本集成ELF和LINUX工具链

**·** **TB-08 开发板**（[购买链接](https://item.taobao.com/item.htm?spm=a2oq0.12575281.0.0.50111deblTxzXr&ft=t&id=619140804201)）

**·** **Micro USB 线**（需支持数据传输）

## **3 开发板介绍**

TB-08 是一款基于联盛德 W800 的超小体积核心开发板，该开发板引出了芯片的所有IO，并且内置LDO和UART传输芯片，只需一根 Micro USB 数据线与电脑连接即可使用，支持一键下载，外设拥有5个环形LED和2颗按键，调试操作极其方便。

![TB_08](../.assets/app/ide/TB_08.png)

## **4 开发环境搭建**

### 4.1 安装CDS

在官网 https://occ.t-head.cn 平头哥芯片开放社区-技术部落-资源下载中可以找到 CDS 集成
开发环境下载链接，下载 CDS 安装包之后，双击压缩包中的 setup.exe 即可启动安装。

![image-20200610115630319](../.assets/app/ide/setup.png)   

安装中需要用户输入一些信息，根据界面提示输入即可：  

![image-20200610115736348](../.assets/app/ide/install) ![image-20200610115751359](../.assets/app/ide/install_1.png)

![image-20200610115848644](../.assets/app/ide/install_2.png) 

最后，点击 next 启动安装：  

![image-20200610115923047](../.assets/app/ide/install_3.png) 

![image-20200610115934125](../.assets/app/ide/install_4.png) 

### 4.2 导入工程

双击图标启动后将工程操作导入到 CDS 中：  

![image-20200610134142709](../.assets/app/ide/importcds.png)

![image-20200610134202292](../.assets/app/ide/importcds2.png) 

![image-20200610134212414](../.assets/app/ide/importcds3.png) 

![image-20200610134225573](../.assets/app/ide/importcds4.png)

完成之后，导入的工程出现在工程管理视图中，如下图所示。  

![image-20200610134323879](../.assets/app/ide/importcds5.png)

## 5 编译 SDK

导入 SDK 工程之后，在左侧工程管理视图中右键单击工程，选择 Build Project 开始编译：  

![image-20200610134449714](../.assets/app/ide/compile.png)

在 CDS 的 Console 窗口会输出编译信息，如果有错误也会在 Problems 中显示，可以根据提示自行修改。  

![image-20200610135056872](../.assets/app/ide/compile1.png) 

## 6 下载固件

W800 可以使用多种方式下载固件，这里仅以集成 wm_tool 工具下载举例。
首先右键工程依次选择“Make Targets” → “Create…”：  

![image-20200610135215059](../.assets/app/ide/fw_dowload1.png) 

在弹出的对话框中按照下图进行设置：  
![image-20200610135246899](../.assets/app/ide/fw_dowload2.png)

“Target name”输入“download”；
“Make Target”输入“download DL_PORT=串口号”，如 COM18；
“Build Command”输入“make -f ${project_loc}\..\..\..\..\utilities\download.mk”；
这几条配置，除了串口号用户按需修改之外，其余建议用户直接复制粘贴，填完点击 OK 按钮。
然后右键工程依次选择“Make Targets” → “Build…”：  

![image-20200610135346783](../.assets/app/ide/fw_dowload3.png) 

在弹出的对话框中选中刚才配好的“download”项目，点击“Edit…”按钮：  

![image-20200610135423572](../.assets/app/ide/fw_dowload4.png) 

这时弹出对话框如下图：  

![image-20200610135442155](../.assets/app/ide/fw_dowload6.png) 

直接点击 OK 按钮返回即可。  

![image-20200610135501021](../.assets/app/ide/fw_dowload7.png) 

此时，选中刚才配好的“download”项目，点击“Build”按钮即可开始下载固件：  

![image-20200610135617244](../.assets/app/ide/fw_dowload8.png) 

下载过程中，有可能需要用户手动复位开发板，请按照 Console 窗口中的提示信息操作即可。至此，固件的编译和烧录已经成功  

## 7 在线调试  

### 7.1 安装 Debug Server

在官网 https://occ.t-head.cn 平头哥芯片开放社区-技术部落-资源下载中可以找到 Debug
Server 下载链接，下载 Debug Server 安装包之后， Windows 系统下双击压缩包中的 setup.exe
即可启动安装， Linux 系统下执行压缩包中的安装脚本即可启动安装。
注意： Windows 系统下安装 CDS 集成开发环境的话是可选安装 Debug Server 的。（安装CSD时选择了debug sever可跳过此安装环节）  

![image-20200610163251916](../.assets/app/ide/debug.png)

安装中需要用户输入一些信息，根据界面提示输入即可：  

![debug](../.assets/app/ide/debug1.png)

![image-20200610163335861](../.assets/app/ide/debug3.png)

![image-20200610163341632](../.assets/app/ide/debug4.png)

最后，点击 next 启动安装：  

![image-20200610163419216](../.assets/app/ide/debug5.png)

然后请耐心等待安装完成。  

![image-20200610163434350](../.assets/app/ide/debug6.png)

![image-20200610163443818](../.assets/app/ide/debug7.png)

### 7.2 连接 CK-LINK

先使用杜邦线连接CK-LINK和W800模块，其连接方式如下图：  

![image-20200610163533672](../.assets/app/ide/CK-LINK.png)![image-20200610163907590](../.assets/app/ide/driver.png)

打开上述路径打开软件安装位置，双击安装驱动

然后模块供电，并将 CK-LINK 和电脑连接，驱动文件安装正确的话， CK-LINK 的指示灯将会由红色变为黄色。

注意：

要使用调试功能， 需要配置 PA1 和 PA4 的 IO 的复用为调试功能， SDK 里把宏 WM_SWD_ENABLE 置为 1

后编译版本，烧录到板子后即可使用调试器。  



5  s双击桌面图标启动之后，界面会如下显示：

![image-20200610164111624](../.assets/app/ide/start.png)  

第一行会显示 CK-LINK 的版本等信息，如果驱动未安装成功这行信息不会出现；
后面几行显示了 CPU 等芯片信息，如果接线不正确这些信息也不会显示。
当显示无误之后，说明环境已经就绪，此时可以关闭此程序，请阅读下文使用 CDS 集成环境进行调试。  

### 7.3 使用 CDS 集成环境在线调试程序  

6.1 配置工程
导入 SDK 工程之后，在左侧工程管理视图中右键单击工程，如下图选择设置：  

![image-20200610164337845](../.assets/app/ide/cds debug.png)

![image-20200610164344957](../.assets/app/ide/cds debug2.png)

6.2 启动调试  

右键工程选择如下：  

![image-20200610164411648](../.assets/app/ide/cds debug3.png)

之后根据界面提示操作即可。  

![image-20200610164427410](../.assets/app/ide/cds debug4.png)

## 8 结束

恭喜！你已完成 W800的环境搭建、程序编译、一种固件下载、在线调试等步骤。

现在你可以尝试其他的示例工程或者直接开发自己的应用程序。

