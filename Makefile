# Makefile for building and killing services in the Anomaly Detection Platform
# _PORT variables should have the same values as Port number specified in service's Dockerfile
# Replace variable values according to your setup

# Jupyter Variables
JUPYTER_IMAGE_NAME = koushik/anomaly-platform-jupyter
JUPYTER_DOCKERFILE = jupyter\Dockerfile
JUPYTER_TOKEN = dummytoken
JUPYTER_PORT = 8888

DATASET_PATH = D:/projects/anomaly-detection-platform/jupyter

# Prediction API Variables
API_IMAGE_NAME = koushik/anomaly-platform-api
API_DOCKERFILE = service\Dockerfile
# Same as port in uvicorn.run() in main.py
API_PORT = 8080

.PHONY: help run-jupyter run-api stop-jupyter stop-all

# Execute "run" as the default target for the "make" command
.DEFAULT_GOAL := run

help:
	@echo Targets available for this Makefile
	@echo ===========================================
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

run-jupyter:	## Build and Run a Jupyter Lab Container
	docker build -t $(JUPYTER_IMAGE_NAME) --file $(JUPYTER_DOCKERFILE) .
	docker run -d -p $(JUPYTER_PORT):$(JUPYTER_PORT) -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) --mount type=bind,source=$(DATASET_PATH),target=/src/ $(JUPYTER_IMAGE_NAME)
	@echo -------------------------------------------
	@echo Jupyter Lab URL: http://localhost:$(JUPYTER_PORT)/
	@echo Jupyter Lab Token: $(JUPYTER_TOKEN)
	
run-api: 		## Build and Run a Prediction API Container
	docker build -t $(API_IMAGE_NAME) --file $(API_DOCKERFILE) .
	docker run -d -p $(API_PORT):$(API_PORT) $(API_IMAGE_NAME)
	@echo -------------------------------------------
	@echo Prediction API Endpoint: http://localhost:$(API_PORT)/
	
run-all: run-jupyter run-api 	## Run all containers
	@echo ===========================================
	@echo Access Services Here
	@echo ===========================================
	@echo Jupyter Lab URL: http://localhost:$(JUPYTER_PORT)/
	@echo Jupyter Lab Token: $(JUPYTER_TOKEN)
	@echo Prediction API Endpoint: http://localhost:$(API_PORT)/
	
stop-jupyter: 	## Kill and Delete the Jupyter Lab Container
	docker stop $$(docker ps -q --filter ancestor=$(JUPYTER_IMAGE_NAME))
	@echo Stopped Jupyter Lab Container
	docker rm $$(docker ps -a -q --filter "ancestor=$(JUPYTER_IMAGE_NAME)")
	@echo Deleted Jupyter Lab Container

stop-api: 		## Kill and Delete the Prediction API Container
	docker stop $$(docker ps -q --filter ancestor=$(API_IMAGE_NAME))
	@echo Stopped Prediction API Container
	docker rm $$(docker ps -a -q --filter "ancestor=$(API_IMAGE_NAME)")
	@echo Deleted Prediction API Container

stop-all: stop-jupyter stop-api 	## Stop all containers
	@echo ========== All Containers Killed ==========

remove-all:  ## Remove all Docker images
	docker rmi $$(docker images -q)