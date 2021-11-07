# A Real-Time Anomaly Detection Platform

> 🚦⚠️👷‍♂️🏗️ Repo Under Construction 🚦⚠️👷‍♂️🏗️

![](images/dashboard-gif.gif)

> We've done our development and testing on Windows 10 and used `Git Bash` to run our commands.

## Software Requirements

You'll need the following sofware to execute this project.
<details>
<summary> Python 3.x </summary>

![](images/python-logo.png)

Python is an interpreted high-level general-purpose programming language. Its design philosophy emphasizes code readability with its use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects.

Python comes pre-installed with most Linux and Mac Systems. To install Python, follow the instructions provided here: https://www.python.org/downloads/

Please make sure you install a version of Python 3.x
</details>

<details>
<summary> Git BASH (for Windows users) </summary>

![](images/git-bash.jpg)

Git BASH is an application for Microsoft Windows environments which provides an emulation layer for a Git command line experience.

Install Git BASH if you're on a Windows machine by following the instructions here: https://gitforwindows.org/

</details>

<details>
<summary> make </summary>

![](images/gnu-make.png)

GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files.

Follow the instructions in the [Install make on Windows](https://github.com/koushikvikram/anomaly-detection-platform#install-make-on-windows) section to install `make` on Windows. 

To install `make` on Linux, follow the instructions listed on GNU's website: https://www.gnu.org/software/make/
</details>

<details>
<summary> Docker </summary>

![](images/docker-logo.jpg)

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

To install Docker, follow the instructions listed on Docker's website: https://docs.docker.com/desktop/#download-and-install
</details>


## Platform Architecture

![](images/architecture-square-grey-background.png)

## Makefile Documentation

| Target        | Utility                                                          |
|:--------------|:-----------------------------------------------------------------|
| help          | Lists all targets in this Makefile along with their descriptions |
| run-jupyter   | Build and Run a Jupyter Lab Container                            |
| build-api     | Build the Prediction API Docker Image                            |
| run-api       | Build and Run a Prediction API Container                         |
| run-platform  | Build and Run the entire Platform                                |
| run-all       | Run the Platform and the Jupyter Lab Container                   |
| stop-jupyter  | Kill and Delete the Jupyter Lab Container                        |
| stop-api      | Kill and Delete the Prediction API Container                     |
| stop-all      | Stop the Platform and the Jupyter Lab Container                  |
| remove-all    | Remove all the Docker images we've created                       |
| test-platform | Create Python Virtual Environment, run the tester script and visualize output in Grafana |
| remove-env    | Delete the Python Virtual Environment created for testing        |


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

## Install `make` on Windows

Windows does not support makefiles natively. So, we need to first install the `chocolatey package manager` before installing `make`.

### Steps to Install chocolatey/choco on Windows 10
1. Click Start and type "powershell"
2. Right-click Windows Powershell and choose "Run as Administrator"
3. Paste the following command into Powershell and press enter.
```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; `iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
4. Answer Yes when prompted
5. Close and reopen an elevated PowerShell window (Run as Administrator) to start using choco.

Source: [How to install chocolatey/choco on Windows 10 by JC](https://jcutrer.com/windows/install-chocolatey-choco-windows10)

Now, Run the following command in Powershell to install `make` and you can start using `make` in either the Command Prompt or Powershell:
```
choco install make
```


## API Documentation

![](images/api-documentation-1.png)
![](images/api-documentation-2.png)
![](images/api-documentation-3.png)
![](images/api-documentation-4.png)
![](images/api-documentation-5.png)

### CURL Command for `/prediction`:

```bash
curl -X 'POST' \
  'http://localhost:8080/prediction' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "feature_vector": [
    194, 167
  ],
  "score": false
}'
```

Replace values for `"feature_vector"` with your input values for mean and standard deviation.

Set `"score": true` if you want `anomaly_score` included in the output.

### CURL Command for `/model_information`:

```bash
curl -X 'GET' \
  'http://localhost:8080/model_information' \
  -H 'accept: application/json'
```