###############################################################################
# Copyright (c) 2017, 2020 Eurotech and/or its affiliates and others
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     Eurotech - initial API and implementation
###############################################################################
@unit
@account
Feature: User Account Service
    The User Account Service is responsible for CRUD operations for user accounts in the Kapua
    database.

    Scenario: Creating A Valid Account
    Try to create an account with all valid fields. Kapua should not throw an exception.

        Given I create an account with name "account-1", organization name "organization" and email address "org@abc.com"
        When An account with name "account-1" is searched
        Then No exception was thrown

    Scenario: Creating An Account With Unique Name
    Try to create two accounts with different names. Kapua should not throw an exception.

        Given I create an account with name "account-1", organization name "organization" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "organization2" and email address "org2@abc.com"
        When An account with name "account-1" is searched
        Then No exception was thrown

    Scenario: Creating An Account With Non-unique Name
    Try to create an account and another one with same name. Exception should be thrown.

        Given I expect the exception "KapuaDuplicateNameException" with the text "*"
        When I create an account with name "account-1", organization name "organization" and email address "org@abc.com"
        And I select account "kapua-sys"
        When I create an account with name "account-1", organization name "organization2" and email address "org2@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account With Numbers In Name
    Try to create an account with numbers in name. Kapua should not throw an exception.

        Given I create an account with name "0123456789", organization name "organization" and email address "org@abc.com"
        When An account with name "0123456789" is searched
        Then No exception was thrown

    Scenario: Creating An Account With Numbers And Valid Symbols In Name
    Try to create an account with numbers and '-' in name.Kapua should not throw an exception, dash and numbers are allowed.

        Given I create an account with name "1231-2323", organization name "organization" and email address "org@abc.com"
        When An account with name "1231-2323" is searched
        Then No exception was thrown

    Scenario: Creating An Account Without Name
    Try to create an account without name. Exception should be thrown.

        Given I expect the exception "KapuaIllegalNullArgumentException" with the text "*"
        When I create an account with name "", organization name "organization" and email address "org@org.com"
        Then An exception was thrown

    Scenario: Creating An Account With Short Name
    Try to create an account with name that only has 3 characters. Kapua should not throw an exception.

        Given I create an account with name "abc", organization name "organization" and email address "org@abc.com"
        When An account with name "abc" is searched
        Then No exception was thrown

    Scenario: Creating An Account With Long Name
    Try to create an account with name that has 50 characters. Kapua should not throw an exception.

        Given I create an account with name "7j5w5HFyvkWta6W3pr6c35ihjHUxNVkcEovzXyySjKqWhsXbe3", organization name "organization" and email address "org@abc.com"
        When An account with name "7j5w5HFyvkWta6W3pr6c35ihjHUxNVkcEovzXyySjKqWhsXbe3" is searched
        Then No exception was thrown

    Scenario: Creating An Account Without Organization Name
    Try to create an account without organization name. Exception should be thrown

        Given I expect the exception "KapuaIllegalNullArgumentException" with the text "*"
        When I create an account with name "acc1", organization name "" and email address "org@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account With Short Organization Name
    Try to create an account with organization name that has only 1 character. Kapua should not throw an exception.

        Given I create an account with name "acc1", organization name "o" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Long Organization Name
    Try to create an account with organization name that has 255 characters. Kapua should not throw an exception.

        Given I create an account with name "acc1", organization name "70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Too Long Organization Name
    Try to create an account with organization name that has 256 characters. Exception should be thrown.

        Given I expect the exception "KapuaException" with the text "*"
        When I create an account with name "acc1", organization name "a70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account With Special Symbols In Organization Name
    Try to create an account with organization name that contains special symbols.
    No exception should be thrown as all characters are allowed for contact name

        Given I create an account with name "acc1", organization name "org@#$%&/!)=?(" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Numbers In Organization Name
    Try to create an account with organization name that contains numbers. Kapua should not throw an exception.

        Given I create an account with name "acc1", organization name "0123456789" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Wrong TLD Format In Email
    Try to create an account with wrong TLD (less than 2 or more than 63 characters). Exceptions should be thrown

        Given I expect the exception "KapuaIllegalArgumentException" with the text "*"
        When I create an account with name "acc1", organization name "org1" and email address "org@abc.commmcommmcommmcommmcommmcommmcommmcommmcommmcommmcommmcommmcommm"
        Then An exception was thrown
        And I select account "kapua-sys"
        Given I expect the exception "KapuaIllegalArgumentException" with the text "*"
        When I create an account with name "acc2", organization name "org2" and email address "org@abc.c"
        Then An exception was thrown

    Scenario: Creating An Account Without "@" In Email
    Try to create an account without '@' in email. Exception should be thrown.

        Given I expect the exception "KapuaIllegalArgumentException" with the text "*"
        When I create an account with name "acc1", organization name "org1" and email address "orgabc.com"
        Then An exception was thrown

    Scenario: Creating An Account Without "." In Email
    Try to create an account without '.' in email. Exception should be thrown.

        Given I expect the exception "KapuaIllegalArgumentException" with the text "*"
        When I create an account with name "acc1", organization name "org1" and email address "org@abccom"
        Then An exception was thrown

    Scenario: Creating An Account Without Email
    Try to create an account without email. Exception should be thrown

        Given I expect the exception "KapuaIllegalNullArgumentException" with the text "*"
        When I create an account with name "acc1", organization name "org1" and email address ""
        Then An exception was thrown

    Scenario: Creating An Account With Valid Contact Name
    Try to create an account with contact name. Kapua should not return any error.

        Given I create an account with name "account-1", organization name "org1", contact name "contactName" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Unique Contact Name
    Try to create two accounts with different contact name. Kapua should not return any errors.
        
        Given I create an account with name "account-1", organization name "org1", contact name "contactName" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "org2", contact name "different contact name" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Non-Unique Contact Name
    Try to create an account and another one with same name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", contact name "contactName" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "org2", contact name "contactName" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Numbers In Contact Name
    Try to create an account with numbers in contact name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", contact name "0123456789" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Symbols In Contact Name
    Try to create an account with symbols in contact name. Kapua should not return any errors.
        
        Given I create an account with name "account-1", organization name "org1", contact name "~!@#$%^&*()_+=-?></\|[]" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account Without Contact Name
    Try to create an account without contact name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", contact name "" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Short Contact Name
    Try to create an account with contact name that has only 1 character. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", contact name "c" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Long Contact Name
    Try to create an account with contact name that has 255 characters. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", contact name "70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Too Long Contact Name
    Try to create an account with contact name that has more than 255 characters.

        Given I expect the exception "KapuaException" with the text "*"
        When I create an account with name "account-1", organization name "org1", contact name "70PdfsdhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account With Valid Phone Number
    Try to create an account with valid phone number. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", phone number "+17872984728947289" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Unique Phone Number
    Try to create two accounts with different phone numbers. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", phone number "1213323443" and email address "org@abc.com"
        When I select account "kapau-sys"
        And I create an account with name "account-2", organization name "org2", phone number "+23214124124" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Non-Unique Phone Numbers
    Try to create two accounts with same phone number. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", phone number "+123456789" and email address "org@abc.com"
        When I select account "kapau-sys"
        And I create an account with name "account-2", organization name "org2", phone number "+123456789" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Letters And Symbols In Phone Number
    Try to create an account that has letters in phone number. Kapua should return an error.

        Given I create an account with name "account-1", organization name "org1", phone number "+212bdd!#$%%%" and email address "org@abc.com"
        When I search for the account with name "account-1"
        Then No exception was thrown

    Scenario: Creating An Account With Short Phone Number
    Try to create an account that has phone number with only one number. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", phone number "1" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Only '+' In Phone Number
    Try to create an account that has only '+' in phone number. Kapua sholud throw an exception.

        Given I expect the exception "KapuaIllegalArgumentException"
        When I create an account with name "account-1", organization name "org1", phone number "+" and email address "org"
        Then An exception was thrown

    Scenario: Creating An Account With Long Phone Number
    Try to create an account that has 64 digits in phone number. Kapua should not throw any errors.

        Given I create an account with name "account-1", organization name "org1", phone number "1234567890123456789012345678901234567890123456789012345678901234" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Too Long Phone Number
    Try to create an account that has more than 64 digits in phone number. Kapua should throw exception.

        Given I expect the exception "KapuaException"
        When I create an account with name "account-1", organization name "org1", phone number "1234567890123456789012345678901234567890123456789012345678901234567890" and email address "org@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account Without Phone Number
    Try to create an account without phone number. Kapua should not return any error.

        Given I create an account with name "account-1", organization name "org1", phone number "" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Valid Address1
    Try to create an account with valid address one. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "address for testing 1" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Unique Address1
    Try to create two account with different organization addresses 1. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "address for testing 1" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "org2", organization address 1 "address for testing 2" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Non-Unique Address1
    Try to create two accounts with same organization addresses 1. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "address for testing 1" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "org2", organization address 1 "address for testing 1" and email address "org2@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Special Symbols In Address1
    Try to create an account with special symbols in address1. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "address~!@#$%^&*()_+|?><" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Short Address1
    Try to create an account with short organization address 1, with only one letter. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "a" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Long Address1
    Try to create an account with long address 1. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Creating An Account With Too Long Address1
    Try to create an account with too long address 1. Kapua should throw an exception.

        Given I expect the exception "KapuaException"
        When I create an account with name "account-1", organization name "org1", organization address 1 "a70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        Then An exception was thrown

    Scenario: Creating An Account Without Address1
    Try to create an account without organization address 1. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org1", organization address 1 "" and email address "org@abc.com"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name To Unique One
    Try to edit account's organisation name so it stays unique. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "organization" and email address "org@abc.com"
        When Organization name of account "account-1" is changed into "organization for test"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name To Non-Unique One
    Try to edit account's organization name to non-unique one. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "organization" and email address "org@abc.com"
        When I select account "kapua-sys"
        And I create an account with name "account-2", organization name "organization2" and email address "org2@abc.com"
        And Organization name of account "account-2" is changed into "organization"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name With Short Name
    Try to edit account's organization name with short name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "o" and email address "org@abc.com"
        When Organization name of account "account-1" is changed into "organization for test"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name With Long Name
    Try to edit account's organization name with long name (255 characters). Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "70PhDFZYDvBRNWU3J0rLqXa7ynQs0ZcjI9BXILV8ufsdvr3JtR07nxjvbaqPAlQVEOGjpopecZaBVTmrzw45ARl64Alw2QNjVxbRp56lJTxCGePcys0PLj4ZbQSmi8xdUVOQsNn5WDd6xx1lt3OXsugq77tG9dbaheeQTWvaMpri9gDL61uS5O8me4YXQ6AMkNQZxwuibsk3ohsGBSN9Z5ahmBeCCgTZulFXjdiHABaDIEiTM8qH05hhWmTs9jp" and email address "org@abc.com"
        When Organization name of account "account-1" is changed into "organization for test"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name With Special Symbols
    Try to edit account's organization name with special symbols name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "org@#$%&/!)=?(" and email address "org@abc.com"
        When Organization name of account "account-1" is changed into "organization for test"
        Then No exception was thrown

    Scenario: Changing Account's Organization Name With Numbers In Name
    Try to edit account's organization name with numbers in name. Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "0123456789" and email address "org@abc.com"
        When Organization name of account "account-1" is changed into "organization for test"
        Then No exception was thrown

    Scenario: Deleting Existing Account
    Create an account and after that try to delete it. Kapua should not retrun any errors.

        Given I create an account with name "account-1", organization name "organization1" and email address "org1@abc.com"
        And I delete account "account-1"
        When I search for the account with name "account-1"
        Then The account does not exist

    Scenario: Deleting Existing Account And Creating It Again With Same Name
    Create an account and after that try to delete it. Create it again with the same name.
    Kapua should not return any errors.

        Given I create an account with name "account-1", organization name "organization1" and email address "org1@abc.com"
        When I delete account "account-1"
        And I select account "kapua-sys"
        When I create an account with name "account-1", organization name "organization1" and email address "org1@abc.com"
        And An account with name "account-1" is searched
        Then I find account with name "account-1"
        And No exception was thrown


#Scenario: Handle account creation
#    Create a test account and check whether it was created correctly.
#
#    Given I create a generic account with name "test_acc"
#    Then The account matches the creator settings
#
#Scenario: Find all child accounts
#    Create a number of subaccounts. Check that the account has the correct number of subaccounts.
#
#    When I create 15 childs for account with Id 1
#    Then The account with name "kapua-sys" has 15 subaccounts
#
#Scenario: Handle duplicate account names
#    Accounts with duplicate names must not be created. When a duplicate account name is
#    given, the account service should throw an exception.
#
#    Given I create a generic account with name "test_acc_1"
#    And I expect the exception "KapuaDuplicateNameException" with the text "An entity with the same name test_acc_1 already exists."
#    When I create a generic account with name "test_acc_1"
#    Then An exception was thrown
#
#Scenario: Handle null account name
#    If an account name is null, the account service should throw an exception.
#
#    Given I expect the exception "KapuaIllegalNullArgumentException" with the text "*"
#    When I create an account with a null name
#    Then An exception was thrown
#
#Scenario: Find account by Id
#    The account service must be able to find the requested account entity by its Id.
#
#     Given I create a generic account with name "test_acc_42"
#     When I search for the account with the remembered account Id
#     Then The account matches the creator settings
#
#Scenario: Find account by Ids
#    The account service must be able to find the requested account entity by its
#    parent and account Ids.
#
#    Given I create a generic account with name "test_acc_42"
#    When I search for the account with the remembered parent and account Ids
#    Then The account matches the creator settings
#
#Scenario: Find account by random Id
#    Search for an account that does not exist.
#
#    When I search for a random account Id
#    Then The account does not exist
#
#Scenario: Find account by name
#    The account service must be able to find the requested account entity by its name.
#
#    Given I create a generic account with name "test_acc_42"
#    When I search for the account with name "test_acc_42"
#    Then The account matches the creator settings
#
#Scenario: Find by name nonexisting account
#    Search for an account name that does not exist.
#
#    When I search for the account with name "test_acc_unlikely_to_exist"
#    Then The account does not exist
#
#Scenario: Modify an existing account
#    Test that the account service correctly modifies an existing account. The modified
#    account details must be correctly stored in the account database.
#
#    Given I create a generic account with name "test_acc_42"
#    When I modify the account "test_acc_42"
#    Then Account "test_acc_42" is correctly modified
#
#Scenario: Modify nonexisting account
#    Try to update an account that does not exist anymore. An exception should be thrown.
#
#    Given I create a generic account with name "test_acc_42"
#    Then I delete account "test_acc_42"
#    Given I expect the exception "KapuaEntityNotFoundException" with the text "The entity of type account with id/name"
#    And I modify the current account
#    Then An exception was thrown
#
#Scenario: Delete an existing account
#    Delete a previously created account. The account should be deleted from the database.
#
#    Given I create a generic account with name "test_acc_123"
#    When I delete account "test_acc_123"
#    And I search for the account with name "test_acc_123"
#    Then The account does not exist
#
#Scenario: Delete the Kapua system account
#    It must not be possible to delete the system account.
#
#    Given I expect the exception "KapuaIllegalAccessException" with the text "The current subject is not authorized for delete"
#    When I try to delete the system account
#    Then An exception was thrown
#    And The System account exists
#
#Scenario: Delete nonexisting account
#    Try to delete an account with a a random Id. The operation should fail and an exception
#    should be thrown.
#
#    Given I expect the exception "KapuaEntityNotFoundException" with the text "The entity of type account with id/name"
#    When I delete a random account
#    Then An exception was thrown
#
##Scenario: Change the account parent Id
##    The account service must not allow the account parent Id to be changed.
##
##    Given An existing account with the name "test_acc_123"
##    And I expect the exception "KapuaAccountException" with the text "An illegal value was provided for the argument"
##    When I try to change the account "test_acc_123" scope Id to 2
##    Then An exception was thrown
#
#Scenario: Change the account parent path
#    It must not be possible to change the account parent path. Any try should result in an exception.
#
#    Given I create a generic account with name "test_acc_11"
#    And I expect the exception "KapuaAccountException" with the text "An illegal value was provided for the argument"
#    When I change the parent path for account "test_acc_11"
#    Then An exception was thrown
#
#Scenario: Check account properties
#    It must be possible to set arbitrary account properties.
#
#    Given I create a generic account with name "test_acc_11"
#    When I set the following parameters
#        | name | value  |
#        | key1 | value1 |
#        | key2 | value2 |
#        | key3 | value3 |
#    Then The account has the following parameters
#        | name | value  |
#        | key1 | value1 |
#        | key2 | value2 |
#        | key3 | value3 |
#
#Scenario: Every account must have the default configuration items
#    Create a new account and check whether it has the default configuration items set.
#
#    Given I create a generic account with name "test_acc_11"
#    Then The default configuration for the account is set
#
#Scenario: A newly created account must have some metadata
#    Create a new account. Check whether the account has some associated metadata.
#
#    Given I create a generic account with name "test_acc_11"
#    Then The account has metadata
#
#Scenario: It should not be possible to change the configuration items
#    Values of the supported configurationm items must be modifiable.
#
#    Given I create a generic account with name "test_acc_11"
#    When I expect the exception "org.eclipse.kapua.KapuaException"
#    When I configure "integer" item "maxNumberChildEntities" to "5"
#    Then An exception was thrown
#    #Then The config item "maxNumberChildEntities" is set to "5"
#
#Scenario: Setting configuration without mandatory items must raise an error
#    Mandatory configuration items must always be set. Trying to set configuration items without
#    specifying the mandatory items must raise an error.
#
#    Given I create a generic account with name "test_acc_11"
#    When I expect the exception "org.eclipse.kapua.KapuaException"
#    When I configure "integer" item "ArbitraryUnknownItem" to "5"
#    Then An exception was thrown
#
#Scenario: Test account query
#    Perform a database query and find all the accounts that have the 'scopeId'
#    property set to '1' (children of the system account). This is the default query and
#    no additional parameter is needed to create it.
#
#    Given I create 9 accounts with organization name "test_org"
#    When I query for all accounts that have the system account as parent
#    Then The returned value is 9
#
#Scenario: Account name must not be mutable
#    It must be impossible to change an existing account name. When tried, an exception must
#    be thrown and the original account must be unchanged.
#
#    Given I create a generic account with name "test_acc"
#    And I expect the exception "KapuaAccountException" with the text "An illegal value was provided for the argument"
#    When I change the account "test_acc" name to "test_acc_new"
#    Then An exception was thrown
#    And Account "test_acc" exists
