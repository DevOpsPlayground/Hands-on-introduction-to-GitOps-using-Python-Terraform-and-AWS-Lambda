# Gitlab

We will be using Gitlab.com as both our git provider, but also for the CI functionality. Gitlab.com can be accessed via your existing Github or Bitbucket.org users so you probably don't even need to register for it.

A public Gitlab group has been created to support this playground. This is linked to Gitlab runner on AWS which can deploy the infrastructure and applications we'll be playing with throughout.

## Adding your repository to the group

To be able to deploy to the DPG AWS account using our Gitlab runner, you must first create a new repository and add it to our group.

https://gitlab.com/dpg-gitops


Once you are authorized in the group, you can go ahead and create your GitOps repository.

After creating your repository, we will need to make you the Maintainer, so you can approve merge requests and manage branches.

Reach out on Slack with your username and repository name and we can do it for you.

Once you have created your repo, download the Playground code from LINK

Copy this into your repo and commit it.

Go to infra/envs and change the value of username to a unique name for yourself, must be alphabetic.

Go to infra/terraform.tf and replace "<USERNAME>" with your username

In Gitlab, go to Settings > CI/CD
Expand "Runners"
Click "Disable shared runners"

This will


### Gitlab Runner

If you want to set up your own Gitlab Runner to be used with Gitlab CI, you can deploy it to AWS using [terraform-aws-gitlab-runner](https://github.com/npalm/terraform-aws-gitlab-runner)