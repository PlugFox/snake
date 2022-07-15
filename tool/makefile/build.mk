.PHONY: build generate-icons generate-splash

build: codegen
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

generate-icons: get
	@fvm flutter pub run icons_launcher:create --path icons_launcher.yaml

generate-splash: get
	@fvm flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml