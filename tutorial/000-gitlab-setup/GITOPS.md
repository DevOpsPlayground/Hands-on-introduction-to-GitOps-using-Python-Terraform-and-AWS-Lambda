# GitOps


*GitOps is a paradigm or a set of practices that empowers developers to perform tasks which typically fall under the purview of IT operations. GitOps requires us to describe and observe systems with declarative specifications that eventually form the basis of continuous everything.*

What do we mean when we talk about IT operations? 

Deployments to production/testing environments.

Whatever is in master is always deployed to production. We can use the power of Git to roll back if required, using Git tags as a versioning tool.

In essence, Gitops is levarging Git pull requests to manage changes to the configuration of our applications and infrastructure.


## A basic GitOps workflow

* Create new feature branch from master
* Implement new features and test locally 
* When ready, create Merge Request to master 
* Tests are performed, and if passing, a plan of changes is created and attached to the Merge Request
* When the merge request is merged, the changes are then application to production, effectively releasing a new version of our application

### Environments

It is common in the software development lifecycle to have numerous application environments. These allow us to deploy and test our features in isolation, without modifying anything on production. 

#### Integration Testing

When we have developed a set of features and tested locally, we want to validate that these changes will function as expected when deployed alongside the other components of our application. 

We don't want to just push these changes to production and hope for the best, so we can deploy them to an isolated integration testing environment. 

