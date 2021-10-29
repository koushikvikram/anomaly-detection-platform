IMAGE_NAME = koushik/anomaly-platform-jupyter
DOCKERFILE = jupyter\Dockerfile
JUPYTER_TOKEN = dummytoken
PORT = 8888
DATASET_PATH = D:/projects/anomaly-detection-platform/jupyter

run:
	docker build -t $(IMAGE_NAME) --file $(DOCKERFILE) .
	docker run -d -p $(PORT):$(PORT) -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) --mount type=bind,source=$(DATASET_PATH),target=/src/ $(IMAGE_NAME)
	@echo ===========================================
	@echo Jupyter Lab URL: http://localhost:$(PORT)/
	@echo Jupyter Lab Token: $(JUPYTER_TOKEN)
	