---
slug: progressive-rollouts
id: r4wewloeeyhs
type: challenge
title: Use Progressive Rollouts
teaser: Automatically increase the amount of traffic to a specific flag variation
  over time
notes:
- type: text
  contents: Using progressive rollouts allows you to release your application a little
    at a time in order to limit your blast radius as you release.
tabs:
- id: cmfpxcy215of
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: 3walacaymmta
  title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- id: gb8b9lfdsuen
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---
# Lab 8

Whether we are releasing to everyone, or targeting a specific audience, we still may want to release gradually over time. In the event errors begin ocurring, we can quickly rollback while maintaining a small blast radius.

To create a progressive rollout:

1. Click **Brand New Rollout Feature**
2.  Turn the flag **On**
3.  Click **Edit** for Default Rule
4. In the dropdown for **Serve**  - ** Click **Progressive rollout****

By default, we'll rollout to a larger audience every 6 hours until we reach 100%. Let's add one more step.

4. On the 3rd step (at 25%), click the **+** to the right on that line.
5. Click **Add step below**
6. Change the percentage from **37.5%** to **40%**.
7. Click **Review and save**, then **Save changes**

If at any time the new feature begins failing, the rollout can quickly and easily be stopped and the changes will be automatically rolled back.

1. Under **Rules**, click **Stop** to the far right of the **Default rule**
2. From the **Serve** dropdown, select **Unavailable**
3. Click **Next**, then **Save changes**

Why did we rollback our progressive rollout? We'll say it was due to a bug in this particular release. And as it turns out, this release missed going through QA altogether!
