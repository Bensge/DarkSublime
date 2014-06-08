# Dark Sublime
Dark Sublime is a SIMBL extension for OS X that darkens Sublime Text 3's window title bar.

![Screenshot](https://github.com/Bensge/DarkSublime/raw/master/screenshot.png)

## Building
Dark Sublime uses [Theos by DHowett](https://github.com/DHowett/theos). Just ```make package install``` to install the package. Installing the .deb will fail as it requires superuser permission, but the package will be manually installed to the right directory. After installing, open EasySIMBL and enable the Plugin. Restart Sublime Text and have fun.

## Issues
Hovering over the window buttons (close, minimize, maximize) adds a bad-looking white line above those buttons. This is being looked into, pull requests are welcome.

## Requirements
Dark Sublime uses SIMBL and requires EasySIMBL.

## Credits
The titlebar image is taken from [SL3's Soda Theme](https://github.com/buymeasoda/soda-theme/)
I also recommend using soda in combination with this plugin.

Thanks to [kirb](https://github.com/kirb) for helping me getting started with SIMBL plugins.

## License
[Creative Commons Attribution-ShareAlike 3.0 License](http://creativecommons.org/licenses/by-sa/3.0/)