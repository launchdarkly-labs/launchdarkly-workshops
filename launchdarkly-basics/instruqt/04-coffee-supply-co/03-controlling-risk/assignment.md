---
slug: controlling-risk
id: ysn0tmp40dnm
type: challenge
title: Controlling Risk With Release Targeting
teaser: Release to your developers first, not the whole world
notes:
- type: text
  contents: |-
    You can release to everyone at once — but why would you? Targeting lets
    you release to a specific group first, validate the feature in production,
    and then expand the audience when you're confident it works.
tabs:
- id: 2lqxs9era5x0
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: gwvno5yjefgb
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
- id: 3jleaesvfmaf
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 3

# Create a Segment

A *segment* is a reusable group of users or contexts that share a common attribute. By targeting a segment, you can control which users receive a new feature without touching the application code.

Let's create a **Developers** segment that targets internal users by their role.

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click **Segments** in the left navigation menu.
1. Click **Create segment**, then select **Rule-based segment**.
1. For **Name**, enter:
```
Developers
```
5. Click **Save segment**.

Now add a targeting rule to the segment:

1. For **Rule 1**, select the following values:
   - **Context kind**: `user`
   - **Attribute**: `role`
   - **Operator**: `is one of`
   - **Values**: `developer` *\<Enter\>*
1. Click **Save changes**, then **Save changes** again.

# Update the Flag

With the segment in place, update `release-home-page-slider` to only serve the slider to developers.

1. Click **Flags** in the left navigation menu.
1. Click **Release Home Page Slider**.
1. Under Targeting Configuration for Test, click **View targeting rules**.
1. Click **+ Add rule** and choose **Target segments**.
1. Set the following values:
   - **Segments**: `Developers`
   - **Rollout**: `Slider Visible`
1. Under **Default rule**, click **Edit** and set **Serve** to `Slider Hidden`.
1. Make sure the flag toggle is **On** in the upper left.
1. Click **Review and save**, then **Save changes**.

# See It in Action

Switch to [Coffee Supply Co.](#tab-1) and reload — the slider is visible because the app's context has `role: developer`, placing Miriam Wilson in the Developers segment.

In a real application with multiple user types, anyone outside the Developers segment would see the default (slider hidden), giving you a safe, targeted production test before a full rollout.
