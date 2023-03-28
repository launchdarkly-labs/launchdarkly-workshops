---
slug: segments
id: qebncm5hdszc
type: challenge
title: Segments
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
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

# Understanding Segments

Segments offer a simple way of scaling context usage and targeting. These allow us to group contexts together and determine who gets to see what features. This is similar to the targeting feature in a specific flag, except that segments can be used by any flag in the environment.

Much like flag-specific targets, segments allow for individual targets as well as targeting rules.

For our application, let's create a new segment for our beta users.

1. In the **LaunchDarkly** tab, navigate to **Segments** in the left menu
1. Click **Create segment** on the right side of the screen
1. For the **Name**, enter "Beta users"
1. Ensure the **Key** was automatically entered as "beta-users"
1. Click **Save segment**

We now have a segment we can configure. Let move past **Individual targets** to the **Include targets who match these rules** section.

1. Click **+Add rules**
1. For the four dropdowns in the **If** (first) row, enter the following selections:
  1. *user*
  1. *userType*
  1. *is one of*
  1. *beta*
1. Click **Save changes**, then **Save changes** again

Look familiar? We did something very similar in the previous challege--only it was specific to one flag. Now we can use the same selection in any flag in this project's environment. So let's update our flag to use this segment.

1. Navigate to **Feature flags** in the menu on the left
1. Click on the flag named **New App Name**
1. The **Targeting** submenu is selected by default. In the **Rules** section, click **+ Add rules**
1. For the first dropdown in the **If** (first) row, select *is in segment* (notice the other selections with change)
1. In the *Select segments...* dropdown, select *Beta users*
1. From the single dropdown in the second row, select *true*
1. Click **Review and save**, then **Save changes**

Switch to the **LaunchDogly** web app tab, and you'll notice the title of the application changed from *LaunchDogly* to *LaunchBarkly*.

Once again, this is due to the context in our application. Switch to the **Code Editor** tab, and open the *static/main.js* file. On line 123 of the file, you'll see the following:
```js,nocopy
newContext = {
    kind: 'user',
    key: mainUserName,
    name: mainUserName + '-user',
    userType: 'beta',
    location: 'CA'
};
```

Our current user is in our beta segment. Change the **userType** value from `beta` to `ga-only`. Refresh the **LaunchDogly** tab and you'll notice the title changes back to *LaunchDogly* since we're no longer part of the beta group.

As you can see segments offer an excellent way to scale targeted releases in a diversified manner.
