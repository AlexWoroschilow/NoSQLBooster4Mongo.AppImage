# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/nosqlbooster
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/nosqlbooster' 					>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' 									>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'UUC_VALUE=`cat /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null`' 		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'if [ -z "$${UUC_VALUE}" ]' 													>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    then' 																	>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/nosqlbooster/nosqlbooster4mongo --no-sandbox "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    else' 																	>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/nosqlbooster/nosqlbooster4mongo "$${@}"' 				>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    fi' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun

	wget --output-document=$(PWD)/build/NoSQLBooster4Mongo.AppImage https://s3.mongobooster.com/download/releasesv7/nosqlbooster4mongo-7.1.7.AppImage
	7z x $(PWD)/build/NoSQLBooster4Mongo.AppImage -o$(PWD)/build/squashfs-root

	cp --force --recursive $(PWD)/build/squashfs-root/usr/share/* 					$(PWD)/build/Boilerplate.AppDir/share			| true
	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib64/* 					$(PWD)/build/Boilerplate.AppDir/lib64			| true
	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib/* 					$(PWD)/build/Boilerplate.AppDir/lib64			| true
	cp --force --recursive $(PWD)/build/squashfs-root/* 							$(PWD)/build/Boilerplate.AppDir/nosqlbooster

	rm -rf $(PWD)/build/Boilerplate.AppDir/nosqlbooster/usr
	rm -rf $(PWD)/build/Boilerplate.AppDir/nosqlbooster/AppRun
	rm -rf $(PWD)/build/Boilerplate.AppDir/nosqlbooster/*.desktop		| true
	rm -rf $(PWD)/build/Boilerplate.AppDir/nosqlbooster/*.png			| true
	rm -rf $(PWD)/build/Boilerplate.AppDir/nosqlbooster/*.svg			| true

	rm -rf $(PWD)/build/Boilerplate.AppDir/*.png			| true
	rm -rf $(PWD)/build/Boilerplate.AppDir/*.desktop		| true
	rm -rf $(PWD)/build/Boilerplate.AppDir/*.svg			| true

	cp --force $(PWD)/AppDir/*.desktop	$(PWD)/build/Boilerplate.AppDir
	cp --force $(PWD)/AppDir/*.png  	$(PWD)/build/Boilerplate.AppDir | true
	cp --force $(PWD)/AppDir/*.svg  	$(PWD)/build/Boilerplate.AppDir | true

	chmod +x $(PWD)/build/Boilerplate.AppDir/nosqlbooster/chrome-sandbox
	chmod +x $(PWD)/build/Boilerplate.AppDir/nosqlbooster/nosqlbooster4mongo

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/NoSQLBooster4Mongo.AppImage
	chmod +x $(PWD)/NoSQLBooster4Mongo.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/build
