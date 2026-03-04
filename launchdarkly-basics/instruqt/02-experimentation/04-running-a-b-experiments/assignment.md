---
slug: running-a-b-experiments
id: 4bagmujrlrel
type: challenge
title: Running A/B Experiments
teaser: A short description of the challenge.
notes:
- type: text
  contents: Getting started with your first A/B Experiment
tabs:
- id: llbyvxujo3uk
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: iwkhavwarlbd
  title: Galaxy Marketplace
  type: service
  hostname: workstation
  port: 3000
- id: tkah6hdh7kiz
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 4

# What is A/B Testing?

An A/B test, also known as split testing or feature testing, is a method of comparing two versions of a feature or web page to determine which one performs better. By showing version A to one group of users and version B to another, you can measure differences in user behavior and identify the more effective version. This approach is commonly used to test changes in user interfaces, call-to-action buttons, layouts, and more.

Feature flags are an essential part experiments as they allow you to control the rollout of different versions of a feature. You can easily switch between two or more versions of your code, directing segments of your audience to each feature.

This makes is easy to manage your experiment without deploying new code!

# Create the Experiment

1. From the left-hand navigation menu, click **Experiments**
2. Click the **Create experiment** button in the upper right-hand corner
3. For **Name**, enter:
```text
Upsell tracking Experiment
```
4. For **Hypothesis**, enter:
```text
If we enable the new cart suggested items feature, we can drive greater upsell conversion
```
5. For **Experiment type**, select **Feature change**
6. Click **Next**
7. Leave default settings and click **Next**
8. From the **Add metric or metric group** dropdown, select **In-Cart Upsell**
9. Click the dropdown again and select **In-Cart Total Price**
10. Click **Next**
11. From the **Flag** dropdown, select **Cart Suggested Items**
12. Click **Next**
13. In the **Define audience** section, for the **In this experiment** option, select **50%**
14. In the **Split experiment audience** section, select **Control** for the **Suggested Cart Component** flag variation.
15. Click **Finish**