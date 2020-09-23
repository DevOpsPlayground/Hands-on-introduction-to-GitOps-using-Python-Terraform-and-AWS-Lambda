# Environments

To use the concept of application environments in our Gitops workflow, we can model them using Git branches.

## Git Branches

We can use Git branches to represent our environments.

|Branch|Environment|
|---|---|
|master|production|
|test|integration test|

As such, we set these branches as "Protected" in our repository settings. This means that we can't just go and push a commit directly to these branches, a Merge Request must.

We will discuss Merge Requests more in the next section, and how they fit into our Gitops workflow.

### Create test branch

Open your Gitlab project. In the left menu, go to Repository > Branches.

Click the New branch button. Name the branch "test".


### Mark test branch as protected

In the left menu, go to Settings > Repository.

Click **Expand** next to **Protected Branches**.

Add *test* as a protected branch:

* Branch: *test*
* Allowed to merge: Maintainers
* Allowed to push: No one

This will now make sure that nobody can push directly to either our main or test branches. These must be updated via Merge Requests.