---
slug: create-the-flags
id: gh2ckhorfabd
type: challenge
title: Create the Flags
teaser: Let's create new feature flag we can use to control the release of our new
  feature
notes:
- type: text
  contents: This is text
tabs:
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Galaxy Marketplace
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

# Lab 1

When experiments are built on top of flags, it gives 
us a great deal of flexibility. In this lab, we'll create 
two different flags: one to turn on some product banners, 
and one for the experiment.

What we'd like to learn with experiment is of our three 
different banners, which one generates a greater response 
from our customers.

# Create the First Flag

Our first flag is a simple boolean flag. The application is 
already programmed to handle it, so it will be function as 
soon as it's created.

1. From the left-hand navigation menu, click **Feature Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```js
Store Headers
```
4. Click **Create flag** in the lower right-hand side of the screen.

# Create the Second Flag

The second flag is is made of three different string variations. 
These variations will be used as part of our experiment to 
display different values to different shoppers.

1. From the left-hand navigation menu, click **Feature Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```js
Store Attention Callout
```
4. Under **Flag type**, select **String**
5. Under **Variations**:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. First **Name**:
```js
Control
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. First **Value**:
```js
New Items
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Second **Name**:
```js
Sale
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d. Second **Value**:
```js
Sale
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e. Click **Add variation**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f. Second **Name**:
```js
Final Hours
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g. Second **Value**:
```js
Final Hours!
```
6. Under **Default variations**, set both values to **Control**
7. Click **Create flag** in the lower right-hand side of the screen.

# Test the Flags

Now let's make sure the flags work before moving on.

1. From the left-hand navigation menu, click **Feature Flags**
1. For the **Store Headers** flag, click the toggle to turn the flag to **On**
1. Click **Save Changes**
1. For the **Store Attention Callout** flag, click the toggle to turn the flag to **On**
1. Click **Save Changes**
1. Switch to the (Galaxy Marketplace)[#tab-1] tab, and you should see a banner 
over the the first item.

Now we're ready to begin work on our experiment!
