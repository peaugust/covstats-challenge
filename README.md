# CovStats Challenge 

## Description

This challenge is a subset of [COVStats - a Figma community design](https://www.figma.com/community/file/824267725540451043). The main goal of this app is to show some stats about the COVID-19 spread worldwide. The focus of this challenge is on debug and fix existing bugs. The app screens should allow the user to see on the Home tab the number of total cases, active cases, recovered, total death, and top-five countries cases reports. The map tab shows a map to discover the reported cases near the user allowing filter results by: City/Country, Reported Cases and Reported Deaths. On this challenge the only data retrived will be the cases around.

## Acceptance criteria

### Requirements

#### Overall: 
- Be able to see the title of each screen on the Navigation Bar 
- Be able to run the app without crashes 

#### Home screen: 
- Be able to see all fields expected in the design 
- Be able to scroll the screen 

#### Map screen: 
- Be able to open the map screen and use the map 
- Be able to select a filter 
- Be able to see the number of cases around

## Resources

<img width="921" alt="image" src="https://user-images.githubusercontent.com/29137856/197544338-c3369891-78d1-427c-8f37-ef1f23432b04.png">
<img alt="image" src="https://user-images.githubusercontent.com/29137856/197548156-00a599bb-221a-4383-a395-369886919f30.gif">


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
