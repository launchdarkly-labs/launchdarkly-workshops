---
slug: introduction-to-targeting
id: 4zz3xokxxx7w
type: challenge
title: Introduction to Targeting
teaser: Learn about basic release targeting
notes:
- type: text
  contents: Software releases carry a high risk. Targeted releases allow you to make
    sure your blast radius is controlled and containable.
tabs:
- title: LaunchDogly
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /root/launchdogly
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Individual Targeting

Targeting allows us to reduce our blast radius to a smaller, more controlled group. Releases always carry some level of risk--even with the most rigorously tested code. With targeting, we can further reduce that risk by introducing new code to a trusted set of users.

There are several ways to enable targeting, so let's go through them, starting with the simplest--individual targeting.

From the LaunchDarkly tab, login to the LaunchDarkly platform. We'll be using the **Background Color** flag we created in a previous exercise.

First, let's make sure we're in the correct project by clicking on the down-arrow in the upper, left-hand corner. In the **Search** box, enter *LaunchDarkly Basics*, and select the **Test** environment.

1. From the left-hand navigation panel, click **Feature flags**
1. Click the **Background Color** flag
1. In the **Individual targets** section, click **+ Add individual targets**
1. In the box located in the **Valentine's Day** section, type `james` and press *<ENTER>* (NOTE: This is case sensitive, so please enter in all lower-case for this and following steps)
1. In the box located in the **St. Patrick's Day** section, type `alissa` and press *<ENTER>*
1. In the box located in the **Easter Day** section, type `marvin` and press *<ENTER>*
1. In the box located in the **No Holiday** section, type `nancy` and press *<ENTER>*
1. At the top of this main panel, click the toggle switch (should currently be **Off**) to **On**
Click the **Review and save** button, then the **Save changes** button.

Now let's click on the **LaunchDogly** tab to see the results of our targeting.

You will be asked to enter a username. Let's start by entering:
```
james
```

You can see that our app now has a pink background representing Valentine's Day. Just above the dog photo, you'll see `Username: james` with an icon of a pencil to the right. Click on the pencil to change the username, then enter:
```
alissa
```

The background now shows green, representing St. Patrick's Day. Click the pencil icon again and enter:
```
marvin
```

The background color is now a peach pastel color representing Easter. Finally, click the pencil icon once more and enter:
```
nancy
```

And the background color is reset to black, which is our default color.

Individual targeting is a great tool for a certain use cases, but it doesn't scale well. Next, we'll dive a little deeper into more flexible ways of targeting our releases.