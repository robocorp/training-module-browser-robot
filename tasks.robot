*** Settings ***
Documentation   Example Beginner's course solution
Resource        resources/keywords.robot
Suite Teardown  Log out and close browser


*** Tasks ***
Browser example task
    Open the site
    Log into sales site
    Get Sales Data and Enter Values
    Collect The Results
    Export The Table As PDF
