.EXPORT_ALL_VARIABLES:
.PHONY: build watch down clean 

MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))
INFO := '\033[0;34m' # Blue
NC :='\033[0m' # No Color
VER := ${VERBOSE}

build:
	@echo -e ${INFO} Compose image and launch ${NC}
	docker-compose down
	docker-compose -f docker-compose.yml up --build -d

watch:
	docker-compose down
	@echo -e ${INFO} Share host DISPLAY ${NC}
	xhost +
	@echo -e ${INFO} Compose image and launch container ${NC}
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up -d
	@echo -e ${INFO} Welcome to shell ${NC}
	docker exec -ti react-native-test-ci docker-entrypoint.sh shell

run:
ifeq (${VERBOSE},0)
	docker exec -d react-native-test-ci docker-entrypoint.sh ${ACTION}
else
	docker exec -ti react-native-test-ci docker-entrypoint.sh ${ACTION}
endif
	

down:
	docker-compose down

clean:
	@echo TODO

