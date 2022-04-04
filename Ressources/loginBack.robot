*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot

*** Keywords ***
Verifier que user existe
    connect to database using custom params  pymysql  database='demo', user='root', password='', host='localhost'
    row count is equal to x  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1

Authentifier user
    create session  session3  ${WEBSITE_LINK}
    ${response} =  GET On Session  session3  url=login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    log  ${json}
    Should Be Equal As Strings   ${response.status_code}  200
    Should Be Equal As Strings   ${json['message']}  Successfully Login!

Supprimer user
    connect to database using custom params  pymysql  database='demo', user='root', password='', host='localhost'
    execute sql string  DELETE FROM users WHERE username = '${USERNAME}' and password = md5('${PASSWORD}')
    disconnect from database

Authentifier user inexistant
    create session  session4  ${WEBSITE_LINK}
    ${response} =  GET On Session  session4  url=login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    Should Be Equal As Strings   ${response.status_code}  200
    Should Be Equal As Strings   ${json['message']}  Invalid Username or Password!

