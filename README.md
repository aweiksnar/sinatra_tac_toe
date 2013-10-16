# [Sinatra-Tac-Toe](http://sinatra-tac-toe.herokuapp.com/)

## Gameplay

Click on an empty space to make your move and the computer will move shortly after. First move alternates between games. To start a new game click the "New Game?" button after the current game has ended or refresh the page.

## Code Guide

### Organization

When the user makes a post request to the board it assigns that space to the user and then talks to the *MoveRouter* to get the responding move from the computer. Depending on how many moves are on the board the *MoveRouter* will ask the *FirstComputerTurn*, *SecondComputerTurn*, or *RemainingComputerTurn* class to calculate the computer's move choice. The *GameController* is responsible for keeping track of the number of moves on the board, move assignment, and alternating who goes first. Data persists through the session hash.

###UI

The user lands on the page and is able to start playing right away. Users make their move by clicking on an empty space. Turns alternate between games to make playing multiple games in a row a rapid task.

### Unbeatable

The game is unbeatable. The computer player will always win or tie with the user.

### Algorithm

The logic behind the computer player is based on wikipedia's tic-tac-toe [strategy](http://en.wikipedia.org/wiki/Tic-tac-toe#Strategy) guide.

### Goals

My goals when writing the code were follow Sandi Metz' [rules for developers](http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers) The only place I decided to break this was in the MoveRouter, which is designed to select the right class to talk to based on the number of moves on the board.

### Classes/Modules

The logic is broken into different classes depending on the number of moves on the board so that they were faster/easier to test, and quicker to understand for a human.

**MoveRouter:** Decides which class to get move from based on the current number of moves on the board. Knows when the game is over.

**FirstComputerTurn, SecondComputerTurn, RemainingComputerTurn:** Take in information about the current status of the board and return the computer's move choice.

**GameController:** Keeps track of information about the board. Talks to the MoveRouter

**Helpers:** Methods used by other classes to make the code more readable and easier to change.

## Setup Locally

Clone the repository and run `bundle install`.

## Tests

Run the test suite with the `rspec` command after setting up locally.
