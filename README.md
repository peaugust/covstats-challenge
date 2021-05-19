# Jungle Devs - iOS CovStats Challenge Work Experience > Carrer Launch

## Description

This challenge shows a subset of [COVStats - a Figma community design](https://www.figma.com/community/file/824267725540451043). It shows some stats about the COVID-19 spread worldwide. This challenge focus is on setup the app code signing, debug and fix existing bugs. The app screens should allow the user to see on the Home tab the number of total cases, active cases, recovered, total death, and top-five countries cases reports. The map tab shows a map to discover the reported cases near the user allowing filter results by: City/Country, Reported Cases and Reported Deaths. But on this challenge the unique data that will be retrived is the cases around.

### Challenge Goal:

This challenge aims to check the academy transition from Work Experience to Carrer Launch

### Target Level

Work Experience

### Final Accomplishment

Have the CovStats app deployed on Jungle's Testflight, showing the data retrieved from the BE correctly.

## Acceptance criteria

### Requirements

Overall: - Be able to see the title of each screen on the Navigation Bar - Be able to run the app without crashes Home screen: - Be able to see all fields expected in the design - Be able to scroll the screen Map screen: - Be able to open the map screen and use the map - Be able to select a filter - Be able to see the number of cases around

## Resources

https://www.figma.com/file/4jnYdbDcT3KQX7HzTFIGGL/iOS---Transition-Challenge?node-id=0%3A1

https://wiki.jungle.rocks/doc/getting-started-with-1password-E7rDPBEdw1

## Pre-requisites

- Knowledge on Basic UI, constraints, and debugging

## Instructions to run

Fork the repo, in the forked repo, create a new branch to work on.

To run the JSON server: In order to implement this challenge, we created a json db file to be used with JSON Server. To set it up follow the steps below.

1. Install Node.js on your machine if you haven't. You can run node -v or npm -v in the command line to check if it's already installed.
2. Open the terminal
3. Run: npm install -g json-server
4. Download the move-challenge-db json file below
5. Change directory to the one in which you created or the json file
6. Run: json-server --watch move-challenge-db.json --delay 3000
7. The command should have created a home endpoint: http://localhost:3000

When done your changes, open a pull request from your branch to the master branch of the forked repo so that the end result can be reviewed.
