---
slug: create-a-feature-flag
id: apflzsrmu3cw
type: challenge
title: Create a Feature Flag
teaser: Let's create our first feature flag!
notes:
- type: text
  contents: Now that our environment is setup and we have a project to work with,
    let's take a look at how LaunchDarkly integrates with our applications.
tabs:
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Setup Environment

By default, two environments are created for you when you create a new project: Production and Test. Most organizations have Dev, QA, Staging, and Production environments, but you can create as many environments as your organization has. In this track, we'll be working exclusively in the Test environment.

Let's begin by selecting our environment to work in.

1. At the top of the left-hand navigation menu, click the colored project bar just above **Feature Flags**
1. In the search box, type *LaunchDarkly Basics*
1. You should see both environments: Production and Test. Click **Test**

Now we're able to run everything in our Test environment.

# Create a Flag

Next, we need to create a feature flag. This flag won't do much right now, but over the few challenges, we'll incorporate the flag into an application and watch LaunchDarkly in action.

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. For the **Name** field, enter *Enable Auto Rotate* (NOTE: The **Key** field should be automatically populated with *enable-auto-rotate*. Please do not alter this field)
1. Under **Client-side SDK availability** check **SDKs using Client-side ID**
1. Scroll to the bottom of the panel and click **Save flag**

Congratulations! You've created your first flag and you're ready to proceed to the next challenge!
