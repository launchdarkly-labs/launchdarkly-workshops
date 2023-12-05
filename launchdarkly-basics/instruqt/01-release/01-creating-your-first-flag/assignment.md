---
slug: creating-your-first-flag
id: nsksxnaudha7
type: challenge
title: Creating Your First Feature Flag
teaser: Let's create new feature flag we can use to control the release of our new
  feature
notes:
- type: text
  contents: Did you know that LaunchDarkly can reduce rollbacks from hours to seconds? There's no need to redeploy or deal with extended outages. Simply flip a switch to return to the last known good state!
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

# Getting Started with the Toggle Outfitters App

Toggle Outfitters is a retailer whose online presence is in need of an update. We're going to help modernize their website, and we're going to minimize downtime while we're at it.

The first thing we want to do is release our minimally viable product. Currently, we have a "Coming Soon" page, but we want to at least list our products availability.

# Create a Flag

Let's begin by creating a feature flag. This flag won't do much right now, but over the next few challenges, we'll incorporate this and other flags into an application and watch LaunchDarkly in action.

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. Select **Release**, then click **Next**
1. For **Name**, enter `Release Toggle Outfitters Updated Storefront`
1. For **Key**:
   1. Click the pencil
   1. Enter `storeEnabled`
   1. Click the **blue** checkmark to the right
   1. Click **Next**
1. For **Flag variations**:
   1. Select **Boolean**
   1. First **Name**: `Store Enabled`
   1. Second **Name**: `Store Disabled`
1. For **Default variations**:
   1. **Serve when targeting is ON**: *Store Enabled*
   1. **Serve when targeting is OFF**: *Store Disabled*
1. Click **Advanced configuration**, and check the **SDKs using Client-side ID** box
1. Click **Create flag**

Congratulations! You've created your first flag and you're ready to proceed to the next challenge!
