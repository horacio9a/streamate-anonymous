streamate-anonymous
====================
streamate-anonymous lets you follow and archive your selected models shows on www.streamate.com and Streamate white labels sites.
All the SM scripts that you see here use the common SM_Model.txt that you can place where it suits you.
You don't need to be registered streamate user for recording models with this streamate-anonymous script.

Requirements
============
1. Download here [Python 2.7.13](https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi) instalation. Those who need to install python should watch this [video](https://www.youtube.com/watch?v=QYUBz4mrnFU)
2. Download here [RTMPDump(ksv)](https://github.com/K-S-V/Scripts/releases) used to capture the streams. Default location is C:/Windows, otherwise `config.cfg` must be edited
3. Last version of [ffmpeg and ffplay](https://ffmpeg.zeranoe.com/builds/) must be somewere.
4. Last version of [livestreamer](https://github.com/chrippa/livestreamer/releases) must be somewere.

Setup
=====
1. Install requirements `pip install -r Requirements.txt`. Livestreamer can be installed as a stand-alone program but my recommendation is to install it as a python module along with other modules.
2. Download and unpack the [code](https://codeload.github.com/horacio9a/streamate-anonymous/zip/master).
3. Open console and go into the directory where you unpacked the files (default is C:/-sm-py/)
4. sm.bat can be anywhere (default is C:/Windows/)
5. Edit `config.cfg` to your wish or accept default data. You must enter the correct location on your computer for all the files that are there. In that case, those files do not have to be in the path.

Running & Output
================
It's best to use 'Command Promt' first to install `Requirements.txt` and to try the basic `sm.py` script. 
For use these scripts it would be good to make a shortcut and put it in the task bar for easier startup. 
All scripts now use the same text file where is stored your favorite models, default is `C:\Windows\SM_Model.txt`. 
However, if you want to record a certain model permanently (24/7), then you need to use `sm.bat`, options number 3, 4 and 5 to start `smr.py`, `smffr.py` and `smlsr.py`.
For permanently recording more than one model at the same time you need to start another copy of `sm.bat`. 
If rtmpdump is used for recording, the record duration is limited to a maximum of 7'55". So if you want to record a freechat without a time limit then you should use ffmpeg or livestreamer. 
Currently ffmpeg has some problems, at least with me, so my recommendation is to use option 2 and 5 in sm.bat. These two scripts use the Livestreamer to record.
Recording is best abort with Ctrl-C or by clicking 'x' at the top right corner of the script window If Ctrl-C does not react.
For some scripts with `hlsurl` I used part of python code from @beaston02 which I customized from python35 to python27 so thanks to @beaston02.
