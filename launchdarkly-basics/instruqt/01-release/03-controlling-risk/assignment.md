---
slug: controlling-risk
id: psvs88aqh4kt
type: challenge
title: Controlling Risk with Release Targeting
teaser: Getting changes to users without action on their part.
notes:
- type: text
  contents: We've shown how you can release features instantly to your users by placing
    the feature behind a flag, giving you the ability to enable to disable in less
    than 200ms - but if theres an issue with the code, it's still going to be visible
    to all of our users. So let's fix that using release targeting!
tabs:
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- title: VS Code
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /opt/ld/talkin-ship-workshop-app
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

Create a Segment
===

A *segment* is a collection of users, devices, or any other group that share some sort of common attribute.

To get started, switch to the **[LaunchDarkly tab](#tab-0)**, and do the following:

1. Click **Segments** in the left navigation menu.
1. Click the **Create segment** button in the upper, right-hand corner.
1. Enter *Developers* in the **Name** field.
1. Click **Save segment**.

Now let's add a rule to make this segment meaningful.

1. In the **Include targets who match these rules** section at the bottom, click **+ Add rules**.
1. Select the following values:
   1. **Context kind**: user
   1. **Attribute**: name
   1. **Operator**: is one of
   1. **Values**:
      1. ron *\<Enter\>*
      1. leslie *\<Enter\>*
      1. april *\<Enter\>*
1. Click **Save changes**, then **Save changes** again.

The list of **Values** is comprised of arbitrary usernames created for this exercise. In a real environment, this field should contain real usernames from your team members. The usernames are *case-sensitive*, so make sure you take that into consideration when you're creating targeting rules.

Next: Test in Production
===

Now let's update our feature flag from Challenge 1 to use our new segment.

1. Click **Feature Flags** in the left mavigation menu.
1. Click **Release Toggle Outfitters Updated Storefront**.
1. Scroll down to the **Rules** section, and click **+ Add rules**.
1. Select the following values:
   1. **Context kind**: is in segment
   1. **Values**: Developers
   1. **SERVE --> Rollout**: Store Enabled
1. In the **Default rule** section, select the following value:
   1. **SERVE --> Rollout**: Store Disabled
1. Click the On/Off toggle at the top left of the panel to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.

Go ahead and navigate back to our **[Toggle Outfitters tab](#tab-1)**. Even though the flag is on, nothing looks different. That's because a developer isn't logged in!

1. Click **Login** located in the upper, right-hand corner of the Toggle Outfitters site.
1. Enter **ron**, **leslie**, or **april** for the username.
1. Leave the password blank and click **Submit**.

Once logged in successfully, you will see your brand new webstore!
