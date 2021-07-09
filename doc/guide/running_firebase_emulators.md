## Running Firebase Emulators
These steps assume that you have a properly configured Firebase project with running emulators.  Running the docker container in this way mounts your project directory into `/home/node` inside the docker container giving firebase tools access to your firebase project.

1. Start this docker image with the following command:
    ```
    docker run -p 9199:9199 -p 9099:9099 -p 9005:9005 -p 9000:9000 -p 8085:8085 -p 8080:8080 -p 5001:5001 -p 5000:5000 -p 4000:4000 -v /path/to/project:/home/node --name firebase-tools andreysenov/firebase-tools
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
docker run -p 9199:9199 -p 9099:9099 -p 9005:9005 -p 9000:9000 -p 8085:8085 -p 8080:8080 -p 5001:5001 -p 5000:5000 -p 4000:4000 -v /path/to/project:/home/node --name firebase-tools andreysenov/firebase-tools firebase emulators:start
```
