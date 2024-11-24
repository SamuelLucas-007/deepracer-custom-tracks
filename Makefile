.PHONY:build
build:
	./scripts/build.sh

.PHONY:image
image:build
ifdef TAG
	docker buildx build --no-cache . -t awsdeepracercommunity/deepracer-simapp:5.3.2-cpu-ext -f scripts/Dockerfile.localext --build-arg FROM_TAG=5.3.2-cpu
else
	echo "Please set TAG variable."
endif

.PHONY:copy-install
copy-install:build
ifdef TARGET
	cp -r build/* $(TARGET)/install/deepracer_simulation_environment/share/deepracer_simulation_environment/
else
	echo "Please set TARGET variable."
endif

.PHONY:copy-src
copy-src:build
ifdef TARGET
	cp -r build/* $(TARGET)/bundle/
else
	echo "Please set TARGET variable."
endif

.PHONY:clean
clean:
	rm -rf build