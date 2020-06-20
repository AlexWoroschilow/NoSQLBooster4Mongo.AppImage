SOURCE="https://download.kde.org/unstable/kdenlive/16.12/linux/Kdenlive-16.12-rc-x86_64.AppImage"
OUTPUT="KDEnlive.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)
	rm -rf ./AppDir
	7z x $(OUTPUT) -o./AppDir
	cp --force ./AppRun ./AppDir
	chmod +x ./AppDir/*
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)
	rm -rf ./AppDir
