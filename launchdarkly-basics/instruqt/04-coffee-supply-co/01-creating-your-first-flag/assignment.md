---
slug: creating-your-first-flag
id: hqncxwyfhezw
type: challenge
title: Creating Your First Feature Flag
teaser: Create a feature flag to control a new home page slider
notes:
- type: text
  contents: |-
    Welcome to the Coffee Supply Co. feature flags workshop!

    You'll use LaunchDarkly to safely release new features, target specific
    users, recover from failures in seconds, and automate rollbacks when
    things go wrong — all without redeploying your application.
tabs:
- id: yj0ol88ctfle
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: csxxrxpodkue
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
- id: u4jnn39jqrgz
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 1

# Getting Started with Coffee Supply Co.

[Coffee Supply Co.](#tab-1) is a wholesale coffee supplier. Their online store is getting an upgrade — you're going to add a new home page image slider to showcase their products.

Right now the site has no slider. Before touching any code, let's create the feature flag that will control it.

# Create a Flag

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. From the left-hand navigation menu, click **Flags**.
1. Click the **Create flag** button.
1. For **Name**, enter:
```
Release Home Page Slider
```
5. Scroll down to **Variations** and update the names:
   - First Variation **Name**:
```
Slider Visible
```
   - Second Variation **Name**:
```
Slider Hidden
```
6. Click **Create flag** in the lower right-hand corner.

That's it! The flag exists in LaunchDarkly, but the application doesn't know about it yet — the slider still won't appear. In the next lab, you'll wire the flag into the application code.
