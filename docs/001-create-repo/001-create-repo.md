Once you have been given access to the group, you can create your
repository.

1.  Click the "New Project" button

![A screenshot of a cell phone Description automatically
generated](./media/image1.png)

2.  Choose the option "Import project" to import the main playground
    repo

![A screenshot of a social media post Description automatically
generated](./media/image2.png)

3.  Click "Repo by URL"

![A screenshot of a cell phone Description automatically
generated](./media/image3.png)

Enter the following in **Git repository URL**:
<https://github.com/DevOpsPlayground/Hands-on-introduction-to-GitOps-using-Python-Terraform-and-AWS-Lambda.git>

4.  Scroll down and give your repository a name, similar to
    "gitops-cmhrpr", replacing cmhrpr with your own name

![A screenshot of a cell phone Description automatically
generated](./media/image4.png)

5.  Leave the project Private and click **Create project.** You will now
    be taken to your new Repository.

**IMPORTANT**

You must now do the following:

i.  **Request Maintained Access**

Now that you have set up your repo, reach out to us in the \#support
channel on Slack with your Gitlab user and repo link and we will set you
as a maintainer.

This will allow you to change your repository settings, which you will
require for setting up the Playground Gitlab runner and modifying your
branch settings, which we will cover in the next exercise.

ii. **Disable Shared Workers**

To ensure we use the Playground provided Gitlab runner to perform our CI
operations, we need to disable the Gitlab Shared Runners from our
repository.

Usually, Gitlab will attempt to use any of the available runners to run
a CI job. Each user has a 2000 minute credit balance for the Gitlab.com
shared runner pool. We want to disable these shared runners for two
reasons:

-   Using the Playground runner will not impact your Gitlab credit
    balance

-   The Playground runner has been authorised to deploy to the
    Playground AWS account which we will be using for this exercise.

To disable Shared Runners:

![A screenshot of a cell phone Description automatically
generated](./media/image5.png)

On the left menu, hover over **Settings** and click on **CI/C**

Click **Expand** at the Runners section

![A screenshot of a social media post Description automatically
generated](./media/image6.png)

Click the **Disable shared Runners** button

![A screenshot of a cell phone Description automatically
generated](./media/image7.png)

**You can now proceed to exercise 002-environment-branches!**
