---
slug: creating-your-first-flag
id: nsksxnaudha7
type: challenge
title: Creating Your First Feature Flag
teaser: Let's create new feature flag we can use to control the release of our new
  feature
notes:
- type: text
  contents: Did you know that LaunchDarkly can reduce rollbacks from hours to seconds?
    There's no need to redeploy or deal with extended outages. Simply flip a switch
    to return to the last known good state!
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
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Lab 1

# Getting Started with the Toggle Outfitters App

Toggle Outfitters is a retailer whose online presence is in need of an update. We're going to help modernize their website, and we're going to minimize downtime while we're at it.

The first thing we want to do is release our minimally viable product. Currently, we have a "Coming Soon" page, but we want to at least list our products availability.

# Create a Flag

Let's begin by creating a feature flag. This flag won't do much right now, but over the next few challenges, we'll incorporate this and other flags into an application and watch LaunchDarkly in action.

1. From the left-hand navigation menu, click **Feature Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. Select **Release**, then click **Next**
4. For **Name**, enter:
```js
Release Updated Storefront
```
5. Click **Next**
6. For **Flag variations**:
   1. Select **Boolean**
   1. First **Name**:
```js
Store Enabled
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Second **Name**:
```js
Store Disabled
```
7. For **Default variations**:
   1. **Serve when targeting is ON**: *Store Enabled*
   1. **Serve when targeting is OFF**: *Store Disabled*
8. Click **Advanced configuration** to show additional options
9. Under **Client-side SDK availability**, check the box for **SDKs using Client-side ID**
10. Click **Create flag**

Congratulations! You've created your first flag and you're ready to proceed to the next challenge!
