---
slug: multi-variate-flags
id: nhv5jljadybo
type: challenge
title: Multi-variate Flags
teaser: Flags can be more than just true or false!
notes:
- type: text
  contents: Feature flags don't need to be just true or false. In this challenge,
    you'll learn how to provide content based on any number of flag values.
tabs:
- title: LaunchDogly
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /root/launchdogly/track1
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Multivariate Flags

Many flags values are simply set to true or false, on or off. However, in some cases, we need to deliver content based on values other than true or false. For example, what if we wanted to change our app's background color to pink on Valentine's Day, then to green on St. Patrick's Day, and so on.

Multivariate flags allow a flag to have any number of values. The code can either consume those values, or deliver various types of content based on those values. So let's get started!

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. For the **Name** field, enter *Background Color* (NOTE: The **Key** field should be automatically populated with *background-color*. Please do not alter this field)
1. Under **Client-side SDK availability** check **SDKs using Client-side ID**
1. Under **Flag variations**, select **String** from the dropdown menu
1. For **Variation 1**, enter:
```html
#FFC0CB
```
and *Valentine's Day* for the **Name** field
1. For **Variation 2**, enter:
```html
#FF5733
```
and *St. Patrick's Day* for the **Name** field
1. Now click **Add Variation**
1. For **Variation 3**, enter:
```html
#FFCBA4
```
and *Easter Day* for the **Name** field
1. Click **Add Variation** once more
1. For **Variation 4**, enter:
```html
#000000
```
and *No Holiday* for the **Name** field
1. Under **Default variations**, for **ON**, select *St. Patrick's Day*, and for **OFF**, select *No Holiday*
1. Scroll to the bottom of the panel and click **Save flag**

Let's add a little more code to our application to take advantage of this new flag. Using this multivariate flag, we can change the background of our application based on the holiday of our choice.

Navigate to the Code Editor tab, and open the *static/main.js* file. There are two sections in the code marked with comments `// Code Section`. In those two sections, paste the following code:

```js
    mainBgColor = client.variation('background-color', '#000000');
    document.getElementsByTagName('html')[0].style.backgroundColor = mainBgColor;
    for (item in document.getElementsByClassName('progressbar')) {
        document.getElementsByClassName('progressbar')[item].style.backgroundColor = mainBgColor;
    }
```

Now go back to the **LaunchDogly** tab and refresh it. It shouldn't look any different at this point. Now, in the **LaunchDarkly** tab, turn on the **Background Color** flag.

Back to the **LaunchDogly** tab, you'll see the background color has changed to match the holiday in the **Default rule** value. You can change the **Default rule** to a different holiday. Once you **Review and save** the flag, the **LaunchDogly** app will display the new background color.
