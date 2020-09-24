In this exercise, we will be introducing the concepts of application
environments. These allow us to deploy both a test and production
version of our application, meaning we can make and test changes while
still providing our service.

1\. In the left menu, hover over **Repository** and click **Branches**

![A screenshot of a cell phone Description automatically
generated](./media/image1.png)

**2.** Click **New branch**

![A screenshot of a cell phone Description automatically
generated](./media/image2.png)

3\. Name your branch "test" and click **Create branch**

![A screenshot of a cell phone Description automatically
generated](./media/image3.png)

Now we are going to set our new "test" branch as a **Protected Branch**.
A Protected Branch prevents anyone from pushing directly to the "test"
branch, meaning that a Merge Request must be created and merged to the
branch.

We will go into more detail on Merge Requests in the next tutorial.

This allows us to make sure that all changes to the **test** branch are
reviewed first.

**To set up a protected branch:**

i.  Navigate to the Repository settings via **Settings \> Repository**

![A screenshot of a cell phone Description automatically
generated](./media/image4.png)

ii. Click **Expand** next to the **Protected Branches**

![A screenshot of a cell phone Description automatically
generated](./media/image5.png)

Under **Protect a branch**, use the following values:

**Branch**: test

**Allowed to merge**: Maintainers

**Allowed to push**: No one

![A screenshot of a cell phone Description automatically
generated](./media/image6.png)

Once you've entered the values, click **Protect**

Confirm that both master and test are now set to:

**Allowed to merge:** maintainers

**Allowed to push**: no one

![A screenshot of a cell phone Description automatically
generated](./media/image7.png)

**We can now proceed with enabling CI on the next exercise
003-enabling-ci-and-merge!**
