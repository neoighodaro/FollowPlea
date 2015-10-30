# FollowPlea

This is a drop-in library to request that anyone that installs your Tweak follow you on Twitter.

![img_1603](https://cloud.githubusercontent.com/assets/807318/10805875/7a8a87e2-7dd1-11e5-9400-9cdea3863e8c.jpg) ![img_1604](https://cloud.githubusercontent.com/assets/807318/10805872/780fd120-7dd1-11e5-9204-645fb3e77e3e.jpg)

### Installation

Download the ZIP of this repository (or clone it). Better still you can add it as a submodule to your project.

Open your Makefile and...

* Add `FollowPlea/FollowPlea.xm` to your "TweakName_FILES".
* Add `Social` and `Accounts` to your `TweakName_FRAMEWORKS` list.
* Open command line and run `./FollowPlea/install.sh` OR just copy the contents of `FollowPlea/FollowPleaSettings.stub` to `FollowPleaSettings.h` in the root of your project directory, and customize it.

Note: Don't forget to open `FollowPleaSettings.h` and customize it. Enjoy.

## Contributing

Feel free to fork and send pull requests if this helped you and you wanna contribute to making it better.
