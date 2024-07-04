# Artificial Intelligence for Robotics Assignment I
## Introduction

## Description

The assignment requires to model a robotic coffee shop scenario from the
description given. There exist different ways to implement this problem,
it is asked to find the most efficient one.\
In particular, to run this coffee shop, the barista robot needs to
prepare the drinks ordered, which can be cold or warm. The waiter robot
is then in charge of serving customers, using its gripper or a tray, and
to clean the tables when customers have already left the shop. It is
possible to assume that all the orders are known.

## Constraints

More detailed information are then given about the barista, Ernesto:

-   uses 3 time units to prepare a cold drink;

-   uses 5 time units to prepare a warm drink;

about the waiter, Ambrogio:

-   can grasp a single drink using one of its grippers;

-   if it is not using a tray can only bring a drink at a time;

-   if it decides to use a tray can carry up to 3 drinks at the same
    time;

-   is not allowed to leave the tray on a table;

-   moves at 2 meters per time unit;

-   if it is using the tray moves 1 meter per time unit;

-   takes 2 time units per square meter to clean a table;

-   cannot clean a table while carrying the tray;

-   when the tray is taken from the bar it must be returned there;

and about the bar itself, it is given the planimetry of the room and the
dimension of the table here reported:

-   each table is 1 meter apart from any other;

-   the Bar is 2 meters away from tables 1 and 2;

-   Table 3 is the only table of 2 square meters;

-   all the others are of 1 square meter.

## Problems

At the end 4 different problems of increasing difficulty must be solved:

1.  There are 2 customers at table 2: they ordered 2 cold drinks. Tables
    3 and 4 need to be cleaned.

2.  There are 4 customers at table 3: they ordered 2 cold drinks and 2
    warm drinks. Table 1 needs to be cleaned.

3.  There are 2 customers at table 4: they ordered 2 warm drinks. There
    are also 2 customers at table 1: they ordered 2 warm drinks. Table 3
    needs to be cleaned.

4.  There are 2 customers at table 4 and 2 customers at table 1: they
    all ordered cold drinks. There are also 4 customers at table 3: they
    all ordered warm drinks. Table 4 needs to be cleaned.
