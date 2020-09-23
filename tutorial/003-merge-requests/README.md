# Merge Requests

Merge Requests and Reviews are key in any Gitops based workflows. They provide a record of tests, reviews and approvals for all changes which make it into an upstream branch.

## Test Environment

When you are ready to test a new feature, it is useful to deploy it to the test environment to validate the changes before deploying to production. This is easily achived via the branching model described in 002-environments.

Here is our review workflow for deploying a new feature to a test environment:

* A Merge Request is created from the feature branch to the test branch in GitLab
* When the Merge Request is created, a pipeline runs including automated tests and creates a Terraform plan of the change
* The Merge Request can then be reviewed, clearly displaying the test results, changes and planned changes to the Infrastructure and Application from Terraform
* When the Merge Request is then merged, the plan is applied to the test environment
* A series of automated integration tests are performed on the test environment

## Production Environment


### Testing

We are now going to deploy the first of our CI pipelines. 
In the left menu, click Issues

Create a new Issue called "Enable CI"

Click the menu icon next to "Create merge request" and click "Create branch"

Use the default name

Pull your branch

Rename **.gitlab-ci.yml.tmp** to **.gitlab-ci.yml** and commit it

Now go back to our branch on Gitlab

Create a Merge Request to the "test" branch

Review the changes

Replace description with "Testing CI"

Remove option "Delete source branch when merge request is accepted."

Submit Merge Request

Click on the pipeline ID: "Detached merge request pipeline #193461874 pending for 5094374b"

