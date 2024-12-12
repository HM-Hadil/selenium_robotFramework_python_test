*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.saucedemo.com/
${BROWSER}  chrome
${USERNAME}  standard_user
${PASSWORD}  secret_sauce
${PRODUCT_NAME}  Sauce Labs Backpack

*** Test Cases ***
Ajouter Un Produit Au Panier
    [Documentation]  Ce test vérifie si un produit peut être ajouté au panier sur www.saucedemo.com
    Ouvrir Le Navigateur  ${URL}  ${BROWSER}
    Se Connecter  ${USERNAME}  ${PASSWORD}
    Ajouter Le Produit Au Panier
    Vérifier Le Panier
    Fermer Le Navigateur

*** Keywords ***
Ouvrir Le Navigateur
    [Arguments]  ${url}  ${browser}
    Open Browser  ${url}  ${browser}

Se Connecter
    [Arguments]  ${username}  ${password}
    Input Text  id=user-name  ${username}
    Input Text  id=password  ${password}
    Click Button  id=login-button

Ajouter Le Produit Au Panier
    [Documentation]  Ce mot-clé ajoute un produit au panier
    Click Button  xpath=//div[text()="${PRODUCT_NAME}"]/ancestor::div[@class="inventory_item"]//button[text()="Add to cart"]

Vérifier Le Panier
    [Documentation]  Ce mot-clé vérifie si le panier contient le produit ajouté
    Click Link  class=shopping_cart_link
    Wait Until Element Is Visible  class=cart_list
    ${items}  Get WebElements  class=cart_item
    ${count}  Get Length  ${items}
    Should Be Equal As Numbers  ${count}  1

Fermer Le Navigateur
    Close Browser
