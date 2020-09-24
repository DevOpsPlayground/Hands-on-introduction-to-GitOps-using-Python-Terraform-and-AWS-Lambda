Now that you have completed a deployment to test and production, you can try the following:
-------------------------------------------------------------------------------------------

Introduce a failing Terraform lint execution
============================================

1.  Navigate to **Repository \> Branches** in the left menu. Click **New
    branch** to create our new branch.

![A screenshot of a social media post Description automatically
generated](./media/image1.png)

2.  Name the branch **introducing-tflint-failure** and click **Create
    branch**

We will be redirected to the Repository File view screen, on our new
branch.

![A screenshot of a cell phone Description automatically
generated](./media/image2.png)

3.  Navigate to the **infra** directory by clicking on it in the
    repository view. Scroll down and click on the **outputs.tf** file

![Graphical user interface, text, application, email Description
automatically generated](./media/image3.png)

4.  Open the Web IDE by clicking on the **Web IDE** button.

![A screenshot of a social media post Description automatically
generated](./media/image4.png)

5.  Change the output value

![A screenshot of a cell phone Description automatically
generated](./media/image5.png)

Modify the line

> value = aws_s3_bucket.website.bucket_domain_name

Replace with:

> value = \"\${aws_s3_bucket.website.bucket_domain_name}\"

This is changing the syntax of the output value from Terraform 12 (which
we are using) to the older Terraform 11 syntax for using attribute
values. This will be noticed by tflint.

6.  Click **Commit**

![Graphical user interface, text, application Description automatically
generated](./media/image6.png)

7.  Untick the **Start a new merge request** option to prevent us
    merging to master. Click **Commit** and head back to the main repo
    screen by clicking the repo name in the top left

![](./media/image7.png)

8.  Click **Create merge request** which should be displayed at the top
    of the screen

9.  Change branches from master to test by clicking **Change branches**

10. Click **Compare branches and continue**

![Graphical user interface Description automatically
generated](./media/image8.png)

11. Disable **"Delete source branch when merge request is accepted."**

12. Now click **Submit merge request**

![Graphical user interface, text, application, chat or text message
Description automatically
generated](./media/image9.png)

13. Click on the detached pipeline to view it

![Graphical user interface, text, application, email Description
automatically
generated](./media/image10.png)

The job **merge:lint-terraform** should now fail. Refresh the page, and
there should now be a tab called **Tests (1)** displayed above the
pipeline. Click on this tab

![A close up of a logo Description automatically
generated](./media/image11.png)

![A screenshot of a cell phone Description automatically
generated](./media/image12.png)

![A screenshot of a cell phone Description automatically
generated](./media/image13.png)

If you click on the **merge:lint-terraform** under **Jobs** you will be
taken to the test view screen.

![A screenshot of a cell phone Description automatically
generated](./media/image14.png)

This shows us the file where the failure was found (**outputs.tf**) and
the **Trace** output shows us the error. In this case, the problem is
that we are using a deprecated syntax (which we introduced above).

We can go ahead and close this Merge Request now as we do not want to
merge the breaking changes test or production.

Destroy Environment
===================

We only really need the test environment for the lifecycle of our tests,
and after we are done with it, we can tear it down. This process is
automated via a job called **destroy:infra-test** which uses a Terraform
command called **destroy** to delete all of our deployed infrastructure.

![A screenshot of a cell phone Description automatically
generated](./media/image15.png)

If we navigate to our last Merge Request to the test environment and
open the pipeline by clicking on the pipeline ID

![A screenshot of a cell phone Description automatically
generated](./media/image16.png)

We can destroy our testing environment by clicking on the stop icon next
to **destroy:infra-test**

![A screenshot of a cell phone Description automatically
generated](./media/image17.png)

Click on **destroy:infra-test** to view the job execution logs

![A screenshot of a computer Description automatically
generated](./media/image18.png)

We can now watch as Terraform deletes all the AWS resources that we have
created. Don't worry, as we can easily deploy this again!

![A screenshot of a cell phone Description automatically
generated](./media/image19.png)

Go back to the pipeline screen and click the Retry button on the
**deploy:infra-test** job to redeploy our environment.

Deploy to production
====================

We tested our deployment to the test environment, now that we have
tested our changes, we are ready to deploy them to production.

1.  Click the **Merge request** button next to our **enable-ci** branch.

![Graphical user interface, text, application Description automatically
generated](./media/image20.png)

2.  Leave all the default values, and click **Submit merge request**

![Graphical user interface, text, application, email Description
automatically
generated](./media/image21.png)

Our merge request pipeline will now plan the changes to the production
environment.

3.  Click **Merge when pipeline succeeds** to automatically merge the
    branch when the merge pipeline is completed.

![Graphical user interface, text, application, email Description
automatically
generated](./media/image22.png)

![Graphical user interface, text, application, email Description
automatically
generated](./media/image23.png)
