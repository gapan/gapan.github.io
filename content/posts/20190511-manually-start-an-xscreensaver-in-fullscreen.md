+++ 
date = 2019-05-11T20:25:31+03:00
title = "Manually Start an XScreenSaver in Fullscreen"
+++

It turns out that my baby daughter is absolutely mesmerized by
[xscreensaver](https://www.jwz.org/xscreensaver/) and by the many
awesome screensavers it includes. Her favourite so far seems to be
Pacman! Here it is in all its glory:

![XScreenSaver Pacman](/images/xscreensaver-pacman.png)

So I needed to find a way to manually launch it fullscreen. I could do
it by launching `xscreensaver-demo` from the menu or a terminal, then
choosing the screensaver from the list and hitting the *Preview* button.
But that's too involved and I would preferably be able to do it as fast
as possible with one hand, because I'm usually holding her with the
other one.

So, a quick look reveals that XScreenSaver keeps all screensaver
binaries in `/usr/libexec/xscreensaver`. You can launch them manually
from a terminal window with, for example:

```
/usr/libexec/xscreensaver/pacman
```

But that only launches the screensaver in a window, which covers almost
half of my screen. I wanted to be able to launch it fullscreen, as
xscreensaver itself does after some time of inactivity.

You can get a list of command line options with:
```
/usr/libexec/xscreensaver/pacman -help
```
but none of them is about launching the window fullscreen.

The way XScreenSaver does it, is that it creates a
[virtual root window](https://en.wikipedia.org/wiki/Root_window),
puts it on top of all other windows and uses it to draw the screensaver.
That again, seemed to be too involved.

So, I remembered that
[wmctrl](http://tripie.sweb.cz/utils/wmctrl/)
exists and it can be used to change the state of any window.

After launching the screensaver manually and using `xwininfo` on it, I
discovered that its window ID is:

> Pacman: from the XScreenSaver 5.42 distribution (28-Dec-2018)

Apparently, wmctrl can do a partial match on the window ID, so I can use
```
wmctrl -r "Pacman: from the XScreenSaver" -b toggle,fullscreen
```
so that it works for all future version of XScreenSaver and make the
window fullscreen.

So, putting it all together, I wrote the following bash script:
```
#!/bin/bash

# launch the screensaver in a window and leave it running in the
# background
/usr/libexec/xscreensaver/pacman &
# wait a bit for the window to come up
sleep 1
# make the window fullscreen
wmctrl -r "Pacman: from the XScreenSaver" -b toggle,fullscreen
```
made it executable and set added a key binding that launches it by pressing
the `Win-X` key combination.

And I can now start it fullscreen with a single hand! Of course you can
use the same technique to launch any other screensaver included in the
XScreenSaver collection.
