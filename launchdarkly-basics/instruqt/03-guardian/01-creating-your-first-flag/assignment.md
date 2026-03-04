---
slug: creating-your-first-flag
id: iqedlr5wjiev
type: challenge
title: Creating Your First Feature Flag
teaser: Let's create a new feature flag that we can use to control the release of
  a new feature
notes:
- type: text
  contents: Did you know that LaunchDarkly can reduce rollbacks from hours to seconds?
    There's no need to redeploy or deal with extended outages. Simply flip a switch
    to return to the last known good state!
tabs:
- id: 8yenigd7gcvt
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: yv4zvhxpvg2x
  title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- id: um6njzl1xfdd
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 1

# Getting Started with the Toggle Outfitters App

Toggle Outfitters is a retailer whose online presence is in need of a refresh. You're going to modernize their website, and are going to minimize downtime while you do it.

The first thing you want to do is release your minimally viable product. Currently, you have a "Launching Soon" page, but you want to at least list product availability.

# Create a Flag

Let's begin by creating a feature flag. This flag won't do much right now, but over the next few labs, we'll incorporate this and other flags into an application and watch LaunchDarkly in action.

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button
3. For **Name**, enter:
```js
Release Updated Storefront
```
4. Scroll down to  **Variations**:
   1. First Variation **Name**:
```js
Store Enabled
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. Second Variation **Name**:
```js
Store Disabled
```
5. Click **Create flag** in the lower right-hand side of the screen.

Congratulations! You've created your first flag and you're ready to proceed to the next lab!
