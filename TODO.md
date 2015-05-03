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
* It should be possible to remove users from the cooperative using the table at the page "Accounts list"


## Features

* [Contribute page](#contribute-page)
* [Modify activities](#modify-activities)
* [Excel import](#excel-import)
* [Excel export](#excel-export)

## Contribute page

We need something that mentions the fact that it is OSS and provide a link to the GitHub repo. This could be a perfect page for students in Lund looking for a simple open source project to contribute to. 

## Modify activities

The cooperative admin should be able to edit which activites there is for a worker on the admin page

## Excel import

More data validation need to be added. (eg dont import already existing members)
Format informations about the file need to be added.

## Excel export

The cooperative admin should be able to export workers to a excel csv file on the admin page
