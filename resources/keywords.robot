*** Settings ***
Library         RPA.Browser.Selenium
Library         RPA.PDF
Library         RPA.HTTP
Library         RPA.Excel.Files

*** Variables ***
${password}   thoushallnotpass
${siteurl}    https://robotsparebinindustries.com
${excel}      SalesData.xlsx

*** Keywords ***
Open the site
    Open Available Browser   ${siteurl}

*** Keywords ***
Log into sales site
    Input Text   username    maria
    Input Password   password   ${password}
    Click Element   //button
    Wait Until Element Is Visible  id:logout

*** Keywords ***
Enter values into form
    [Arguments]  ${salesdata}
    Input Text     firstname   ${salesdata}[First Name]
    Input Text     lastname    ${salesdata}[Last Name]
    ${target_as_string}=   Convert To String  ${salesdata}[Sales Target]
    Select From List By Value   salestarget   ${target_as_string}
    Input Text     salesresult   ${salesdata}[Sales]
    Click Element  //button[@type="submit"]

*** Keywords ***
Get Sales Data and Enter Values
    Download   ${siteurl}/${excel}   overwrite=True
    Open Workbook  ${excel}
    ${salesdata}=   Read Worksheet As Table   header=True
    Close Workbook
    FOR  ${sd}  IN  @{salesdata}
        Enter Values Into Form  ${sd}
    END

*** Keywords ***
Log out and close browser
    Click Element  id:logout
    Close All Browsers

*** Keywords ***
Collect the results
    Screenshot   css:div.sales-summary  ${CURDIR}${/}sales_summary.png

*** Keywords ***
Export The Table As PDF
    Wait Until Element Is Visible  id:sales-results
    ${sales_results_html}=  Get Element Attribute  id:sales-results  outerHTML
    HTML To PDF   <h1>Extra Heading</h1>${sales_results_html}   ${CURDIR}${/}sales_results.pdf
