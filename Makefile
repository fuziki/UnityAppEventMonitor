UNITY_APP=/Applications/Unity/Hub/Editor/2022.2.2f1/Unity.app
BUILD_DIR=Build
TARGET_NAME=AppEventMonitor
UNITY_PROJECT_PATH=Examples/UnityAppEventMonitor
ASSET_PATH=Assets/Plugins/AppEventMonitor/Plugins

all: bundle copy package

bundle:
	xcodebuild \
		-project ${TARGET_NAME}.xcodeproj \
		-scheme ${TARGET_NAME} \
		-configuration Release \
		-sdk macosx \
		CONFIGURATION_BUILD_DIR=$(CURDIR)/${BUILD_DIR}

copy:
	cp -r ${BUILD_DIR}/${TARGET_NAME}.bundle ${UNITY_PROJECT_PATH}/${ASSET_PATH}/macOS/

package:
	${UNITY_APP}/Contents/MacOS/Unity \
		-exportPackage ${ASSET_PATH} $(CURDIR)/${BUILD_DIR}/${TARGET_NAME}.unitypackage \
		-projectPath ${UNITY_PROJECT_PATH} \
		-batchmode \
		-nographics \
		-quit
	echo exported ${BUILD_DIR}/${TARGET_NAME}.unitypackage
