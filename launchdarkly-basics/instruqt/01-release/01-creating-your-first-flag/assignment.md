---
slug: creating-your-first-flag
id: nsksxnaudha7
type: challenge
title: Creating Your First Feature Flag
teaser: Let's create new feature flag we can use to control the release of our new
  feature
notes:
- type: text
  contents: Give us just a minute or two to setup your environment.
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

# Getting Started with Toggle Outfitters

Toggle Outfitters is a retailer whose online presence is in need of an update. You've been brought on board to help modernize the Toggle Outfitters website.

# Create a Flag

First, we need to create a feature flag. This flag won't do much right now, but over the few challenges, we'll incorporate this and other flags into an application and watch LaunchDarkly in action.

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. Select **Release**, then click **Next**
1. For **Name**, enter `Release Toggle Outfitters Updated Storefront`
1. For **Key**:
   1. Click the pencil
   1. Enter `storeEnabled`
   1. Click **Next**
1. For **Flag variations**:
   1. Select **Boolean**
   1. For the first **Name**, enter `Store Enabled`
   1. For the second **Name**, enter `Store Disabled`
1. Click **Advanced configuration**, and check the **SDKs using Client-side ID** box
1. Click **Create flag**

Congratulations! You've created your first flag and you're ready to proceed to the next challenge!
