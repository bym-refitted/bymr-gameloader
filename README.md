<p align="center">
 <img width="100%" src="./images/4.jpg">
</p>

<br/>

![ActionScript](https://img.shields.io/badge/ActionScript-%23DD0031.svg?style=for-the-badge)

## About
The original decompiled client files for the Backyard Monsters gameloader. The purpose of the original gameloader was to encapsulate important runtime variables, such as endpoints pointing to several backend services, before loading and injecting them into the main game SWF.
<br/><br/>
In this repository you can find the original script for the gameloader at `/scripts/ORIGINAL_GAMELOADER.as`; although this was rewritten in Backyard Monsters Refitted to simulate loading behaviour in `/scripts/GAMELOADER.as`
<br/><br/>
You can find the compiled gameloader file on our [GitHub Releases](https://github.com/bym-refitted/bymr-gameloader/releases) for this repository.

<br/>

## How it works
We are serving this gameloader file via our game launcher's stable version. It calls out to our CDN to grab this gameloader file. From here, the launcher takes advantage of Flash vars as a way of passing parameters in the URL, such as the user selected language, and their token - resulting in a url that may look something like:

```url
## URL
https://cdn.bymrefitted.com/swfs/gameloader.swf?language=english&token=1234
```
The gameloader simulates a 500ms load in intervals of 10ms, and proceeds to load the main game SWF within it's container, passing these Flash vars to the main SWF.
