# FollowPlea

This is a drop-in library to request that anyone that installs your Tweak follow you on Twitter.

![img_1603](https://cloud.githubusercontent.com/assets/807318/10805875/7a8a87e2-7dd1-11e5-9400-9cdea3863e8c.jpg) ![img_1604](https://cloud.githubusercontent.com/assets/807318/10805872/780fd120-7dd1-11e5-9204-645fb3e77e3e.jpg)

### Installation

Download the ZIP of this repository (or clone it). Better still you can add it as a submodule to your project.

#### Using Git

* In the root of your project run the command `git submodule add git@github.com:TapSharp/FollowPlea.git`
* Run the command `./FollowPlea/install.sh`


#### Without Git

* Download the ZIP of the project and place the FollowPlea directory in the root of your project
* Create `FollowPleaSettings.h` in the root of your project and copy the contents of `FollowPlea\FollowPleaSettings.stub` into it.


#### Final Steps (Git / Without Git)

* Open `FollowPleaSettings.h` and customize it.
* In your `Makefile` add `FollowPlea/FollowPlea.xm` to your `TweakName_FILES` list.
* In your `Makefile` add `Social` and `Accounts` to your `TweakName_FRAMEWORKS` list.


## Contributing

Feel free to fork and send pull requests if this helped you and you wanna contribute to making it better.
