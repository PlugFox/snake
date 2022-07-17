.PHONY: build generate-icons generate-splash

build: codegen
	@fvm flutter build web --release --no-source-maps --pwa-strategy offline-first --web-renderer auto --base-href /

generate-icons: get
	@fvm flutter pub run icons_launcher:create --path icons_launcher.yaml

generate-splash: get
	@fvm flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml

deploy:
	@firebase deploy