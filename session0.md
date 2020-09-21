# Session 0: setup
Computer scientists often start counting from zero.

For this course we are using a virtual machine to run Ubuntu 20.04.
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

It is recommended also to install the Guest Additions (check if they are already installed, because the osboxes.org distribution should have it already), and check the VirtualBox options under the "Devices" menu, to share the clipboard.



Alternatives to using Oracle VM VirtualBox:
https://www.vmware.com/
https://www.qemu.org/
macOS terminal
mobaxterm
https://bioinfoperl.blogspot.com/2020/08/ubuntu-nativo-en-windows-10.html
https://multipass.run/

https://swcarpentry.github.io/shell-novice/setup.html

