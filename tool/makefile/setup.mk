.PHONY: setup

setup:
	@npm install -g firebase-tools
	-firebase login
	@firebase init
	@fvm flutter pub global activate intl_utils
	@dart pub global activate flutterfire_cli
	@flutterfire configure \
		-i dev.plugfox.snake \
		-m dev.plugfox.snake \
		-a dev.plugfox.snake \
		-p snake \
		-e plugfox@gmail.com \
		-o lib/src/common/constant/firebase_options.g.dart