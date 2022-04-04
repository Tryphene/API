*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot

*** Keywords ***
Verifier l'exitance de l'utilisateur
    connect to database using custom params  pymysql  database='demo', user='root', password='', host='localhost'
    row count is 0  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')

Inscription user par une requete Http POST
    create session  session1  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}
    ${headers} =  Create Dictionary  Content-Type=application/x-vvv-form-urlenooded
    ${response} =  POST On Session  session1  signup.php  data=${data}
    ${json} =  Set Variable  ${response.json()}
    log  ${json}
    Should Be Equal As Strings   ${response.status_code}  200

Verifier que l'utilisateur es ajoué dans la bd
    connect to database using custom params  pymysql  database='demo', user='root', password='', host='localhost'
    row count is equal to x  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1

Inscription meme user par une requete Http POST
    create session  session2  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}
    ${headers} =  Create Dictionary  Content-Type=application/x-vvv-form-urlenooded
    ${response} =  POST On Session  session2  signup.php  data=${data}
    ${json} =  Set Variable  ${response.json()}
    Should Be Equal As Strings   ${response.status_code}  200
    Should Be Equal As Strings   ${json['message']}  Username already exists!

Verifier que user n'est pas dupliqué
    connect to database using custom params  pymysql  database='demo', user='root', password='', host='localhost'
    row count is equal to x  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1
