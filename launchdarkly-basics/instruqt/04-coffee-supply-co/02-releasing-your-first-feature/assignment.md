---
slug: releasing-your-first-feature
id: vtx152wasy0z
type: challenge
title: Releasing Your First Feature
teaser: Wire the flag into the application and ship the slider
notes:
- type: text
  contents: |-
    Now that the flag exists, it's time to connect it to the application.
    You'll edit the Node.js server code to evaluate the flag and pass its
    value to the template — no framework magic, just a plain function call.
tabs:
- id: rymmpuesx9qa
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: nz4ebc7tlhu3
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
- id: fv9ygnnpxi9o
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 1200
enhanced_loading: null
---

# Lab 2

# Dark-Launching the Slider

The flag is on in LaunchDarkly, but the application has no idea it exists yet. To connect them, you need to:

1. **Evaluate** the flag on the server side.
2. **Pass** the result to the template so it can show or hide the slider.

# Edit the Code

1. Open the [Code Editor](#tab-2) and navigate to `/opt/ld/ld-sample-app-node/app.js`.
2. Find the home route — the block that starts with `app.get('/', ...`.
3. Add the following line **inside the route handler, before `res.render`**:

```js
var homePageSlider = await ldclient.variation('release-home-page-slider', context, false);
```

4. Update the `res.render` call to pass the value to the template:

```js
res.render('index.html', {
    currentRouteRule: currentRouteRule,
    homePageSlider: homePageSlider
});
```

5. Save the file.
6. Restart the application so the changes take effect:

```bash
pm2 restart ld-sample-app-node
```

# Flags in Action

Switch to the [Coffee Supply Co.](#tab-1) tab — the page looks exactly the same because the flag is still **off**.

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.

Now switch back to [Coffee Supply Co.](#tab-1) and reload the page — the slider is live!

1. Switch back to [LaunchDarkly](#tab-0).
1. Toggle the flag **Off** and save.
1. Reload [Coffee Supply Co.](#tab-1) — the slider is gone.

You've just dark-launched a feature: the code was deployed but completely inert until you chose to enable it. In the next lab, you'll learn how to release it only to a specific group of users.
