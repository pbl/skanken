# TODO

## Issues

* The "filter by activity" button sometimes stops working

## Legal issues

The web page is going to be storing person data. This could be against the PUL law in sweden. We need a person with insight to provide knowledge in this. 

## Tech/Code

* Writing basic tests
  - Test controllers
  - Test models
* Making a license footer
* Rename "member" to "worker" in model and controller

## Minor features

* A website user should be prompted to make a call when clicking a workers phone number on a mobile.
* When editing a worker the activities need to be filled in again. That need to be changed so that the activities aren't lost if the user doesn't fill them in again
* Activity filter in views/members/_activity_filter.html.erb need to be modified to only use the existing ACTIVITIES values in member.rb


## Features

* [Landing page](#landing-page)
* [Contribute page](#contribute-page)
* [User assocation to a cooperative](#user-assocation-to-a-cooperative)
* [Cooperative user creation](#cooperative-user-creation)
* [Modify activities](#modify-activities)
* [Excel import](#excel-import)
* [Excel export](#excel-export)


## Landing page

Right now the landing page is the standard devise log in page. The landing page need to give new potientiall users a way to get a feeling of what the site is. Like something the facebook page has as a login page. Easy to login and yet a feeling for the page as weel. 

## Contribute page

We need something that mentions the fact that it is OSS and provide a link to the GitHub repo. This could be a perfect page for students in Lund looking for a simple open source project to contribute to. 

## User assocation to a cooperative

Currently a user is a assigned a cooperative id. It would be simpler if a user is associated with the cooperative model directly.

## Cooperative user creation

The cooperative admin should be able to add be able to add users to the cooperative. It should be possible to both add regular users and other cooperative admins

## Modify activities

The cooperative admin should be able to edit which activites there is for a worker on the admin page

## Excel import

The cooperative admin should be able to import workers from a excel csv file on the admin page

## Excel export

The cooperative admin should be able to export workers to a excel csv file on the admin page
