.EXPORT_ALL_VARIABLES:
.PHONY: build watch down clean 

MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))
INFO := '\033[0;34m' # Blue
NC :='\033[0m' # No Color

build:
	@echo -e ${INFO} Compose image and launch ${NC}
	docker-compose -f docker-compose.yml up --build 

watch:
	@echo -e ${INFO} Share host DISPLAY ${NC}
	xhost local:docker
	@echo -e ${INFO} Compose image and launch container ${NC}
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up 
	@echo -e ${INFO} Welcome to shell ${NC}
	docker exec -ti boilerplate-react-native-img shell

down:
	docker-compose down

clean:
	@echo TODO

