# Install OpenCV with Tesseract on Windows

This guide will take you through the very easy installation steps for OpenCV with Tesseract on Windows.  

**OS:                [Windows 10](https://www.microsoft.com/en-us/software-download/windows10)**  
**Installation Tool: [GitBash](https://git-scm.com/download/win)**  
**Visual Studio:     [Visual Studio 15 2017 Win64](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=15)**  
**OpenCV:            [OpenCV 4.0.1](https://github.com/opencv/opencv/releases/tag/4.0.1)**  
**Libpng:            [libpng1636](https://sourceforge.net/projects/libpng/files/)**  
**Zlib:              [zlib1211](https://sourceforge.net/projects/libpng/files/zlib/1.2.11/)**  
**Leptonica:         [Leptonica version 1.74.4](https://github.com/DanBloomberg/leptonica/releases/tag/1.74.4)**  
**Tesseract:         [Tesseract 4.0.0 Release](https://github.com/tesseract-ocr/tesseract/releases/tag/4.0.0)**  

## Step 1: Clone this Repo
Install [Git Bash for windows](https://git-scm.com/download/win) if you haven't yet.  

Open GitBash and Clone this repo. Lets clone in `C` drive. 

```ruby
cd /C/
git clone https://github.com/ghimiredhikura/Install-OpenCV-with-Tesseract-Windows.git 
cd Install-OpenCV-with-Tesseract-Windows
```
## Step 2: Install OpenCV
```ruby
./installOCV.sh
```
## Step 3: Install llpng and zlib
You must download [png lib](https://sourceforge.net/projects/libpng/files/) and [zlib](https://sourceforge.net/projects/libpng/files/zlib/1.2.11/). Uncompress lpng in folder `lpng` and zlib in folder `zlib`. lpng and zlib must be in same folder as `opencv` and `opencv_contrib`. 

```ruby
./installpngzlib.sh
```
## Step 4: Install leptonica
```ruby 
./installLaptonica.sh
```

## Step 5: Install Tesseract with OpenCV
```ruby
./installTesseract.sh
```

# References
1. [OpenCV (master) installation by using git-bash](https://docs.opencv.org/master/d3/d52/tutorial_windows_install.html#tutorial_windows_gitbash_build)
2. [Tesseract (master) installation by using git-bash](https://docs.opencv.org/master/db/d4c/tutorial_install_tesseract.html)