Feature: Clients

  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5



  @addClienttoworkspace
  Scenario: Add new client to workpace
    Given call Workspace.feature@getallmyworkspaces
    And endpoint /v1/workspaces/{{idworkspace}}/clients
    And header Content-Type = application/json
    And body jsons/bodies/addNewClient.json
    And set value Prueba of key name in body jsons/bodies/addNewClient.json
    When execute method POST
    Then the status code should be 201
    And verify the response email 'contains' example.com
    * define idclient = $.id

  @deleteClient
  Scenario: Delete cliente from workspace
    Given call Clients.feature@addClienttoworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/clients/{{idclient}}
    When execute method DELETE
    Then the status code should be 200
    And response should be name = clienteAutomation