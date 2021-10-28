# A Real-Time Anomaly Detection Platform

> 🚦⚠️👷‍♂️🏗️ Repo Under Construction 🚦⚠️👷‍♂️🏗️

![](images/anomaly-platform-banner.jpg)

We'll do our development on Windows 10.

Build the image with jupyter lab using the command

```bash
docker build -t koushik/anomaly-platform-jupyter --file jupyter\Dockerfile .
```

Run the Docker image using the command

```bash
docker run -d -p 8888:8888 -e JUPYTER_TOKEN="dummytoken" koushik/anomaly-platform-jupyter
```

Then, go to `http://localhost:8888/` in your browser and type in the value you set for `JUPYTER_TOKEN` to enter Jupyter Lab. 

If you don't pass in `JUPYTER_TOKEN`, you'll have to run Docker in Foreground mode (without `-d`) to get the token for Jupyter Lab.

To make the training and test data available inside the Docker container, we need to "mount" the `jupyter` directory which contains the training and test datasets into the container.

We can mount the `jupyter` directory into the container's working directory, `/src/` by using the command

```bash
docker run -d -p 8888:8888 -e JUPYTER_TOKEN="dummytoken" --mount type=bind,source=D:/projects/anomaly-detection-platform/jupyter,target=/src/ koushik/anomaly-platform-jupyter
```

Some things to note here:
- The container name `koushik/anomaly-platform-jupyter` has to come after all the arguments
- The `source` key in the `--mount` argument requires the **absolute** path in the host machine 
- There should be no space between the keys for the `--mount` argument

Now, when we enter Jupyter Lab inside the container, we see that the train and test files are available to us.