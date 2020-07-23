# firebase-tools

[Firebase CLI](https://www.npmjs.com/package/firebase-tools) installed globally over the official [NodeJS image](https://hub.docker.com/_/node)

[url]: https://microbadger.com/images/andreysenov/firebase-tools

[![](https://images.microbadger.com/badges/version/andreysenov/firebase-tools.svg)][url]
[![](https://images.microbadger.com/badges/image/andreysenov/firebase-tools.svg)][url]
[![](https://images.microbadger.com/badges/commit/andreysenov/firebase-tools.svg)][url]

```
THIS DOCKER IMAGE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE MAINTAINERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE DOCKER IMAGE OR THE USE OR OTHER DEALINGS IN THE DOCKER IMAGE.
```

## Quick reference

* Where to file issues:<br>
[the Issues page on Github](https://github.com/AndreySenov/firebase-tools-docker/issues)

* Where to see the Dockerfile:<br>
[Dockerfile](https://github.com/AndreySenov/firebase-tools-docker/blob/master/Dockerfile)

* Where to see the image metadata:<br>
[the page on Microbadger][url]

* Running the Firebase Emulators with your project:<br>
[Running Firebase Emulators](#running-firebase-emulators)

## Image content

* Firebase CLI
* Firebase emulators
* Node (from the base image)
* OpenJDK 11
* Yarn (from the base image)

## Exposed ports

| Port | Emulator          |
| ---- | ----------------- |
| 5000 | Firebase Hosting  |
| 5001 | Cloud Functions   |
| 8080 | Cloud Firestore   |
| 8085 | Cloud Pub/Sub     |
| 9000 | Realtime Database |
| 9005 | Login Confirm     |
| 4000 | Emulator Suite UI |

## Running Firebase Emulators
These steps assume that you have a properly configured Firebase project with running emulators.  Running the docker container in this way mounts your project directory into `/home/node` inside the docker container giving firebase tools access to your firebase project.

1. Start this docker image with the following command:
    ```
    docker run -p 9005:9005 -p 9000:9000 -p 8085:8085 -p 8080:8080 -p 5001:5001 -p 5000:5000 -p 4000:4000 -v /path/to/project:/home/node --name firebase-tools andreysenov/firebase-tools
    ```
1. From the shell prompt running in the docker container, run `firebase init emulators` to update the `firebase.json` file in the root of your project. When asked whether you want to enable the emulator UI, choose "yes".
1. Edit your `firebase.json` file to contain this snippet:
    ```
   "ui": {
             "enabled": true,
             "host": "0.0.0.0",  //<--IMPORTANT
             "port": 4000
           }
   ```
1. If you are using the hosting emulator, you will need to run `firebase login`.
    - Follow the instructions on CLI prompt to login.  It will involve navigating to a website, authenticating to Google, and then redirecting to the firebase emulators.
    - Your login token is stored in the `.config` directory, so you won't have to repeat this step every time you start the container.
    - It is recommended that you add `.config` to your `.gitignore` file if you haven't already.
1. Start the emulator suite by running `firebase emulators:start`. You should be able to access the firebase emulator UI by pointing your browser to `http://localhost:4000`

_**Note:** Use the following command to start the docker container AND the emulators together:_
```
docker run -p 9005:9005 -p 9000:9000 -p 8085:8085 -p 8080:8080 -p 5001:5001 -p 5000:5000 -p 4000:4000 -v /path/to/project:/home/node --name firebase-tools andreysenov/firebase-tools firebase emulators:start
```
