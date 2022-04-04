*** Settings ***
Resource  ../Ressources/signupBack.robot
Resource  ../Ressources/loginBack.robot
Resource  ../Ressources/variables.robot

*** Test Cases ***
Inscrire un user dans la BD
    [Tags]    First
    signupBack.Verifier l'exitance de l'utilisateur
    signupBack.Inscription user par une requete Http POST
    signupBack.Verifier que l'utilisateur es ajoué dans la bd

Inscrire le meme user
    [Tags]    Second
    signupBack.Inscription meme user par une requete Http POST
    signupBack.Verifier que user n'est pas dupliqué

Authentifier user
    [Tags]    Third
    loginBack.Verifier que user existe
    loginBack.Authentifier user

Suprimer user
    [Tags]    Fourth
    loginBack.Supprimer user
    loginBack.Authentifier user inexistant