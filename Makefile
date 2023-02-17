generate-bin:
	mkdir -p "./build"
	cd ./build && cmake -G Ninja ../ && ninja 

install:
	sudo cp -n ./images/wave-sound.png /usr/share/icons/
	sudo cp -n ./build/appwaves /usr/bin/
	sudo cp -n ./org.kaetaen.waves.desktop /usr/local/share/applications/
