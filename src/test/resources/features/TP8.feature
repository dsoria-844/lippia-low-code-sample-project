Feature: Clockify

  Background:
    And base url https://api.clockify.me/api/
    And header x-api-key = Y2Y1M2ExM2EtM2Q3NC00MWUwLWE4YWItYzE5Yjk3MDdlMzI5

 #Punto N°1 del TP: Crear un proyecto dentro del workspace exitosamente.
  @AddWorkspace
  Scenario: Add new workspace
    Given endpoint /v1/workspaces
    And header Content-Type = application/json
    And body {}
    And set value Workspace-para-TP8 of key name in body jsons/bodies/addWorkspace.json
    And set value 67e5b041cb70de288a1e4564 of key organizationId in body jsons/bodies/addWorkspace.json
    When execute method POST
    Then the status code should be 201
    * print response

 #Punto N°2 del TP: Consultar un proyecto por su identificador exitosamente.
  @getallprojectsfromworkspace
  Scenario: Get all projects from workspace
    Given call Workspace.feature@getallmyworkspaces
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * print response
    * define idproject = $[0].id


  @findProjectByID
  Scenario: Find project by ID
    Given call Workspace.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}
    When execute method GET
    Then the status code should be 200
    * print response

  #Punto N°3 del TP: Editar el valor de algún campo del proyecto y validar el cambio realizado
  @UpdateProjectOnWorkspace
  Scenario: Update project on workspace
    Given call Workspace.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/69373a2def91d07ca5c2a875/projects/69373b6f13651e5c0175d7e9
    And header Content-Type = application/json
    And body jsons/bodies/updateProject.json
    And set value TP8-P3 of key name in body jsons/bodies/updateProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.name = TP8-P3
    * print response

  #Punto N°4 del TP: Endpoint /projects, camino feliz. Analizar si tiene parámetros obligatorios y no obligatorios, y definir pruebas para todos los casos.

  @AddANewProject
  Scenario: Add a new project
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/AddANewProject.json
    And set value Project_API2 of key name in body jsons/bodies/AddANewProject.json
    When execute method POST
    Then the status code should be 201
    * print response
    * define newidproject = $.id

  @DeleteProjectFromWorkspace
  Scenario: Delete project from workspace
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/69374a54a205727222ce90b8
    When execute method DELETE
    Then the status code should be 200
    * print response

  #@findProjectByID ya realizado en este mismo feature.Feature.
  #@UpdateProjectOnWorkspace

  @UpdateProjectEstimate
  Scenario: Update project estimate
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And call TP8.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}
    And header Content-Type = application/json
    And body jsons/bodies/UpdateProjectEstimate.json
    And set value 99 of key hour in body jsons/bodies/UpdateProjectEstimate.json
    When execute method PUT
    Then the status code should be 200
    * print response

  @UpdateProjectMemberships
  Scenario: Update project memberships
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And call TP8.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}
    And header Content-Type = application/json
    And body jsons/bodies/UpdateProjectMemberships.json
    And set value membershipType2 of key membershipType in body jsons/bodies/UpdateProjectMemberships.json
    When execute method PUT
    Then the status code should be 200
    * print response

  @Assign/removeUsersTo/fromTheProject
  Scenario: Assign/remove users to/from the project
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And call TP8.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}/memberships
    And header Content-Type = application/json
    And body jsons/bodies/Assign-removeUsersTo-fromTheProject.json
    And set value userId1 of key userId in body jsons/bodies/Assign-removeUsersTo-fromTheProject.json
    When execute method POST
    Then the status code should be 200
    * print response


  @UpdateProjectTemplate
  Scenario: Update project template
    Given call TP8.feature@GetAllProjectsOnWorkspace
    And call TP8.feature@getallprojectsfromworkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}/template
    And header Content-Type = application/json
    And body jsons/bodies/UpdateProjectTemplate.json
    And set value true of key isTemplate in body jsons/bodies/UpdateProjectTemplate.json
    When execute method PATCH
    #Then the status code should be 200
    * print response

    @UpdateProjectUserCostRate
    Scenario: Update project user cost rate
      Given call TP8.feature@GetAllProjectsOnWorkspace
      And call TP8.feature@getallprojectsfromworkspace
      And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}/users/6328ddc5efbd3c091e23432b/cost-rate
      And header Content-Type = application/json
      And body jsons/bodies/UpdateProjectUserCostRate.json
      And set value 999 of key amount in body jsons/bodies/UpdateProjectUserCostRate.json
      When execute method PUT
      #Then the status code should be 200
      * print response

      @UpdateProjectUserBillableRate
      Scenario: Update project user billable rate
        Given call TP8.feature@GetAllProjectsOnWorkspace
        And call TP8.feature@getallprojectsfromworkspace
        And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproject}}/users/6328ddc5efbd3c091e23432b/hourly-rate
        And header Content-Type = application/json
        And body jsons/bodies/UpdateProjectUserBillableRate.json
        And set value 888 of key amount in body jsons/bodies/UpdateProjectUserBillableRate.json
        When execute method PUT
        Then the status code should be 200
        * print response






