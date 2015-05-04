# TODO

## Issues

* The jquery data table stops working when it is empty. 
* The jquery data table stops working sometimes. No idea why.. It might have to do with a field being empty or faulty.  
* Can't create a jobs or contacteds. When submitting the form something goes wrong

## Legal issues

The web page is going to be storing person data. This could be against the PUL law in sweden. We need a person with insight to provide knowledge in this.

## Tech/Code

* Writing basic tests
  - Test controllers
  - Test models
* Making a license footer
* Rename "member" to "worker" in model and controller
* Validation
  - Client side validation of forms
  - Server side validation of input data
  - Validate creation of a account
* Security. Make sure that all resources is rightfully secured
* There seem to be two different folders for devise views. The devise folder and the user folder. Both of which are used by devise. This need to be refactored to one folder with all devise logic
* Make sure the webiste is mobile friendly

## Minor features

* A website user should be prompted to make a call when clicking a workers phone number on a mobile.
* When editing a worker the activities need to be filled in again. That need to be changed so that the activities aren't lost if the user doesn't fill them in again
* A cooperative user should only see the links it has rights to visit.
* Make landing page responsive (mobile friendly)


## Features

* [Contribute page](#contribute-page)
* [Excel import](#excel-import)
* [Excel export](#excel-export)

## Contribute page

We need something that mentions the fact that it is OSS and provide a link to the GitHub repo. This could be a perfect page for students in Lund looking for a simple open source project to contribute to.

## Excel import

More data validation need to be added. (eg dont import already existing members, should not chrash if no file is chosen)
Format informations about the file need to be added.

## Excel export

The cooperative admin should be able to export workers to a excel csv file on the admin page
