# Session 0: setup

- [A virtual machine (VM)](#a-virtual-machine--vm-)
- [Ubuntu embedded in Windows 10](#ubuntu-embedded-in-windows-10)
- [Other options](#other-options)

Computer scientists often start counting from zero. In this course, session 0 is about setting up the required environment for the course.

For this course we are using Ubuntu 20.04.

## A virtual machine (VM)

A virtual machine allows us to run a OS different from the one installed on our computer.

One way to do this: TODO (explain this completely)
- Download and install Oracle VM VirtualBox (https://www.virtualbox.org/) on your system
- In your web browser, go to osboxes.org, downloads, and look for Ubuntu 20.04
- Once the image for Ubuntu has been downloaded, open VirtualBox and:
- Click on "New", choose Linux, Ubuntu, and use an existing drive
- Choose the Ubuntu image
- ...

Once the process ends, within VirtualBox choose the Ubuntu virtual machine and click "Start"

It is likely that some user will need to change the keyboard distribution.
To do this, within the Ubuntu virtual machine, click on the "Show applications" button, type "settings", and click on the icon.
A "Settings" window will emerge, and on the left menu go down to "Region & Language" and click on it. There, below the "Input Sources" section, just click on the "+" icon, then the "..." icon, look for your language. If you cannot find it, choose "Other", to see a larger list of languages, and search again for yours. Click on your choice, and click "Add". Then, you should remove other languages, or change priorities moving the one of your choice to the top of the list below the "Input Sources" section.

Something which could be useful also is disabling shutting down the screen after some inactivity. To do this, go again to "Settings", on the left menu click on "Power", and under "Power Saving", "Blank Screen" choose "Never".

It is recommended also to install the Guest Additions (check if they are already installed, because the osboxes.org distribution should have it already), and check the VirtualBox options under the "Devices" menu, to share the clipboard.

Also, it is important to explain how to use the "Host key". This key can be pressed when within the virtual OS, to recover the keyboard and mouse control for the host OS, and also to activate some options. You can check which is your current "Host key" on the group of icons bottom right of the window running the virtual OS. One example of its use, press "Host key"+F to go full screen.

## Ubuntu embedded in Windows 10

For systems runnings Windows 10 there's a way of running Ubuntu and its terminal. Follow these steps:

1. Make sure you have version 1709 or hihger, as explained [here](https://www.protocols.io/view/ubuntu-on-windows-for-computational-biology-sfuebnw)

2. Open Microsoft Store. Search and install "Ubuntu". You can choose a particular version or simply 'Ubuntu' to get the latest supported version.

3. Open system admin and look for "Turn Windows Features on or off". Select the Windows subsystem for Linux.

4. Reboot and launch the Ubuntu app. After a few minutes you should be able to choose your own user and password. You are ready to go.


## Other options 

If you are running a MacOS computer you should be able to run this course on your terminal. You must learn how to install new software though.

If you use a Windows system you can install [MobaXterm](https://mobaxterm.mobatek.net). It is a powerfull yet simple tool to connect to SSH and SFTP servers. it also offers Linux terminal and X server. It also allows you to install parts beyond *bash*, such as *perl* or *python* packages. 

Other options include:

* https://www.vmware.com
* https://www.qemu.org
* https://multipass.run
* https://swcarpentry.github.io/shell-novice/setup.html
