---
slug: understanding-flags
id: noydjrthnzox
type: challenge
title: Understanding Feature Flags
teaser: Feature flags are an important part of running proper experiments
notes:
- type: text
  contents: Using feature flags as a foundation for experiments gives us ultimate
    control. Features created for the experiment can be deployed to production at
    any time, then toggled on when the experiment is ready!
tabs:
- id: jq9djsmqcn9s
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: yreqyyl78ukw
  title: Galaxy Marketplace
  type: service
  hostname: workstation
  port: 3000
- id: oew0ykq9gus3
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 2

When experiments are built on top of flags, it gives
us a great deal of flexibility. In this lab, we'll create
a basic feature flag for releasing a new site banner.

We're not quite ready to build our experiment, but this
exercise will help us understand how to implement a flag
inside our code.

# Create the First Flag

Our first flag is a simple boolean flag meant for turning on
and off a feature within the application.

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```text
Featured Store Headers
```
4. For **Key**, enter:
```text
storeHeaders
```
4. For **Description**, enter:
```text
Headers to drive engagement on stores
```
5. Under **Configuration**, select **Release**
6. Click **Create flag** in the lower right-hand side of the screen.

# Implementing the Flag

The code has already been implemented for us, and can be reviewed 
in the (Code Editor)[#tab-2] tab in the following file:

`/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`

On lines 68 and 72, you'll see where our flag key is referenced 
as `storeHeaders`. This is the same flag key we just entered when 
creating the flag. 

# Testing the Flag

Now let's see what this flag is doing for us. Switch back to the 
(LaunchDarkly)[#tab-0] tab, and turn the flag on. You should still 
be on the flag's property page.

1. At the top-left of the flag's page, toggle the flag to **On**
2. At the bottom of the page, click **Review and save**, then **Save changes**.

Back over to the (Galaxy Marketplace)[#tab-1], under the **Popular Shops** 
section, you won't see any changes! Why?

By default, Release flags are evaluated to `false` regardless of the flag's
state--whether **On** or **Off**. That's to ensure that no content will be 
served if someone accidentally turns this flag on before it's ready.

Switch back to the (LaunchDarkly)[#tab-0] tab. Scroll to the end of the 
flag's property page and let's roll this new feature out.

1. In the last section, titled **Default rule**, click **Edit** on the right side.
2. Under **Variation** change **Serve** to **Available**.
3. At the bottom, click **Review and save**, the **Save changes**.

Now, when we view the (Galaxy Marketplace)[#tab-1] tab and look under **Popular Shops**, 
we see a bright ribbon on the top right of each store's icon.

Great work! You've successfully created and implemented a feature flag! Next, 
we'll begin optimizing our customers' experience by using LaunchDarkly's 
experimentation feature.






Now we can use this flag in our code. The new feature will
hide safely in an unreachable block of code until we're
ready to roll it out!

To begin, let's switch over to the (Code Editor)[#tab-2], and
locate the following file:

`/components/ui/marketcomponents/stores/storecart.tsx`

On line 36, add the following code:
```javascript
const { cartSuggestedItems } = useFlags();
```



###

# Create the Second Flag

The second flag is is made of three different string variations.
These variations will be used as part of our feature experiment
to display different values to different shoppers.

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```text
Store Highlight Text
```
4. For **Description**, enter:
```text
Header text for marketplace items
```
5. Under **Configuration**, select **Experiment**, and leave **Flag type** as **String**
6. Under **Variations**, for the first variation **Name** and **Value**, enter:
```text
Control
```
7. For the second variation **Name** and **Value**, enter:
```text
Sale
```
8. For the third variation **Name** and **Value**, enter:
```text
Final Hours
```
9. Click **Create flag** in the lower right-hand side of the screen.

# Create the Third Flag

Our third flag is for running a funnel experiment. In a future

1. From the left-hand navigation menu, click **Feature Flags**
1. For the **Store Headers** flag, click the toggle to turn the flag to **On**
1. Click **Save Changes**
1. For the **Store Attention Callout** flag, click the toggle to turn the flag to **On**
1. Click **Save Changes**
1. Switch to the (Galaxy Marketplace)[#tab-1] tab, and you should see a banner
over the the first item.

Now we're ready to begin work on our experiment!
