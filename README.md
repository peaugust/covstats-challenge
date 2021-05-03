# Jungle Devs - iOS CovStats Challenge Work Experience > Carrer Launch

## Description

This challenge shows a subset of COVStats - a Figma community design. It shows some stats about the COVID-19 spread worldwide. This challenge focus is on setup the app code signing, debug and fix existing bugs. The app screens should allow the user to see on the Home tab the number of total cases, active cases, recovered, total death, and top-five countries cases report. And on the Map tab a map to discover the reported cases near the user (this data will be mocked).

### Challenge Goal:

This challenge aims to check the academy transition from Work Experience to Carrer Launch

### Target Level

Work Experience

### Final Accomplishment

Have the CovStats app deployed on Jungle's Testflight, showing the data retrieved from the BE correctly.

## Acceptance criteria

### Requirements

Overall:

- Setup the app code signing using the certificates stored in 1Password <ADD THE VAULT NAME HERE>

Home screen:

- Be able to see all fields expected in the design

Map screen:

- Be able to open and use the map screen

## Resources

https://www.figma.com/file/4jnYdbDcT3KQX7HzTFIGGL/iOS---Transition-Challenge?node-id=0%3A1

https://wiki.jungle.rocks/doc/getting-started-with-1password-E7rDPBEdw1

## Pre-requisites

- Knowledge on app code sigining, debug and integration

## Instructions to run

Fork the repo, in the forked repo, create a new branch to work on. When done, open a pull request from your branch to the master branch of the forked repo so that the end result can be reviewed.

To run the JSON server: In order to implement this challenge, we created a json db file to be used with JSON Server. To set it up follow the steps below.

1. Install Node.js on your machine if you haven't. You can run node -v or npm -v in the command line to check if it's already installed.
1. Open the terminal
1. Run: npm install -g json-server
1. Download the move-challenge-db json file below
1. Change directory to the one in which you created or the json file
1. Run: json-server --watch move-challenge-db.json --delay 3000
1. The command should have created a home endpoint: http://localhost:3000
