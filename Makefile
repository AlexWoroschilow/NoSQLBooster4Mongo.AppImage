SOURCE="http://s3.mongobooster.com/download/releasesv6/nosqlbooster4mongo-6.0.3.AppImage"
OUTPUT="NoSQLBooster4Mongo.AppImage"


all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)

