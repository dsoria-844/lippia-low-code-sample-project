Feature: Clockify

  Background:
    And base url https://api.clockify.me/api/
    And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5

  #Obtengo los datos de user
  @GetCurrentUser
  Scenario: Get current user info
    Given endpoint /v1/user
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    * print response
    * define UserID = response[0].id

  #Consultar las horas registradas.
  @HorasRegistradas
  Scenario: Get time entries for user on workspace
    Given endpoint /v1/workspaces/69435698bcad256eac0436ea/user/{{UserID}}/time-entries
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    * print response
    * define TimeEntryID = response[0].id


  #Punto 2
  @GetAllProjectsOnWorkspace
  Scenario: Get all projects on workspace
    Given endpoint /v1/workspaces/69435698bcad256eac0436ea/projects
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    * print response
    * define ProjectID = response[0].id


  @AddANewTimeEntry
  Scenario: Add a new time entry
    Given endpoint /v1/workspaces/69435698bcad256eac0436ea/time-entries
    And header Content-Type = application/json
    And set value 2025-01-01T10:00:00Z of key start in body jsons/bodies/AddANewTimeEntry.json
    And set value 2025-01-01T12:00:00Z of key end in body jsons/bodies/AddANewTimeEntry.json
    And set value {{ProjectID}} of key projectId in body jsons/bodies/AddANewTimeEntry.json
    When execute method POST
    Then the status code should be 201
    * print response
    * define NewTimeEntryID = response.id

  #Punto 3: Editar un campo de algún registro de hora
  @EditTimeEntry
  Scenario: Edit a time entry
    Given endpoint /v1/workspaces/69435698bcad256eac0436ea/time-entries/{{TimeEntryID}}
    And header Content-Type = application/json
    And set value 2025-01-01T10:00:00Z of key start in body jsons/bodies/EditTimeEntry.json
    And set value 2025-01-01T14:00:00Z of key end in body jsons/bodies/EditTimeEntry.json
    When execute method PUT
    Then the status code should be 200
    * print response

  #Punto 4: Eliminar hora registrada.
  @DeleteTimeEntry
  Scenario: Delete a time entry
    Given endpoint /v1/workspaces/69435698bcad256eac0436ea/time-entries/{{TimeEntryID}}
    And header Content-Type = application/json
    When execute method DELETE
    Then the status code should be 204


