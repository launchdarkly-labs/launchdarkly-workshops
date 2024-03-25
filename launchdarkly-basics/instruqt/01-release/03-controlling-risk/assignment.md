---
slug: controlling-risk
id: psvs88aqh4kt
type: challenge
title: Controlling Risk with Release Targeting
teaser: Getting changes to users without action on their part.
notes:
- type: text
  contents: You've seen how to quickly you can release new features, delivering them
    in less than 200ms. But what happens if there's an issue with the code? We don't
    want all of our users to see that. So let's provide a way to test in production
    before a full release.
tabs:
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 3

# Create a Segment

A *segment* is a collection of users, devices, or any other group that share some sort of common attribute. By creating a segment, we can provide targeted access to specific features. In our previous challenge, we learned how to turn on and off features in a general way. Now let's reduce our target audience to just our developers.

To get started, switch to the [LaunchDarkly tab](#tab-0), and do the following:

1. Click **Segments** in the left navigation menu.
2. Click the **Create segment** button in the upper, right-hand corner.
3. Select **Rule-based segments**
4. In the **Name** field, enter:
```js
Developers
```
5. Click **Save segment**.

Now let's add a rule to make this segment meaningful.

1. For **Rule 1**, select the following values:
   1. **Context kind**: user
   1. **Attribute**: name
   1. **Operator**: is one of
   1. **Values**:
      1. ron *\<Enter\>*
      1. leslie *\<Enter\>*
      1. april *\<Enter\>*
      1. andy *\<Enter\>*
1. Click **Save changes**, then **Save changes** again.

The list of **Values** is comprised of arbitrary usernames created for this exercise. In a real environment, you might use different attributes to identify groups of users in a more dynamic way. The usernames here are *case-sensitive*, so make sure you take that into consideration when you're creating targeting rules.

# Next: Test in Production

Now let's update our feature flag from Challenge 1 to use our new segment.

1. Click **Feature Flags** in the left navigation menu.
1. Click **Release Updated Storefront**.
1. Click **+ Add rules** and choose **Target segments**
1. Select the following values:
   1. **Operator**: is in
   1. **Segments**: Developers
   1. **Rollout**: Store Enabled
1. In the **Default rule** section, click the **Edit** button to the right side of the heading:
   1. **Serve --> Variation**: Store Disabled
1. Click the On/Off toggle at the top left to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.

Go ahead and navigate back to our [Toggle Outfitters](#tab-1) tab. Even though the flag is on, nothing looks different. That's because a developer isn't logged in!

1. Click **Login** located in the upper, right-hand corner of the Toggle Outfitters site.
1. Enter **ron**, **leslie**, **april**, or **andy** for the username.
1. Leave the password blank and click **Submit**.

Once logged in successfully, you will see your brand new webstore!
