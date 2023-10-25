---
slug: workflows
id: ckqy3sd1fwjv
type: challenge
title: Workflows
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

# Setting up Workflows

Setting up targeted releases in the flag configuration is a very common method of releasing features and enhancements, which gives your teams maximum control. However, there are occasions when teams are fully ready to rollout changes, and an automated approach would be ideal.

Workflows provide an automated way of releasing changes with a specific rollout method. For example, we may want to increment the number of users we release to by 10% over the next 10 days. Or perhaps we want to release to specific segments over time. Workflows help us automate these tasks.

Let's create a simple workflow for a progressive rollout.

1. Navigate to **Feature flags** in the menu on the left
1. Click on the flag named **New App Name**
1. In the submenu across the top, click **Workflows**

As you can see, there are a number of options, including creating workflows from scratch. We're going to keep ours simple.

1. Click **Progressive rollout**
1. By default, the **Roll out variation** is set to **true**, **Increments** is set to **10%**, and **Frequency** is set to **day**
1. Click **Review workflow**
1. For the **Name**, enter "Progressive rollout" and click **Next**

Review the proposed workflow. Notice that it's broken everything down into steps. These can be altered as necessary. At the top right, click **Start workflow**

You now have a scheduled workflow for rolling out your new changes!
