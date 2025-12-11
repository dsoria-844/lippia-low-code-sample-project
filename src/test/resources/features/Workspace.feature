Feature: Clockify

  @getallmyworkspaces
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api/
    And endpoint /v1/workspaces
    And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5
    When execute method GET
    Then the status code should be 200
    * print response
    * define idworkspace = $[0].id

  @GetWorkspaceInfo
  Scenario: Get workspace info
    Given call Workspace.feature@getallmyworkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idworkspace}}
    And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5
    When execute method GET
    Then the status code should be 200
    And response should be $.name = Diego's workspace
    * print response


 @getallprojectonmyworskpace
 Scenario: Get all project on my workspace
   Given base url https://api.clockify.me/api
   And endpoint /v1/workspaces/69278d12641ff344293cb521/projects
   And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5
   When execute method GET
   Then the status code should be 200
    * print response


