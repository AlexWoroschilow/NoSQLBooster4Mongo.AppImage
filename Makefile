SOURCE="http://s3.mongobooster.com/download/releasesv6/nosqlbooster4mongo-6.0.4.AppImage"
OUTPUT="NoSQLBooster4Mongo.AppImage"

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
