# Life Sim — Android build setup (Codespaces + Capacitor)

Everything in this folder is pre-configured. You're mostly tapping through
GitHub's website in Chrome on your phone, then pasting a handful of
commands. No computer needed — this all runs in the cloud, and since you're
building and testing on the **same Android phone**, there's no file
transfer step at the end either.

---

## Step 1 — Create the GitHub repo

1. Open **Chrome** on your phone, go to **github.com**, sign in (or create
   an account — it's free).
2. Tap the **+** in the top right → **New repository**.
3. Name it whatever you like, e.g. `lifesim-app`. Keep it **Private** if
   you'd rather nobody else see the source while you're building it.
4. Create the repository (leave it empty — no README, no .gitignore).

## Step 2 — Upload this folder into it

1. Download `lifesim-android-setup.zip` from this chat — it'll land in your
   phone's **Downloads** folder.
2. Open your Files app, tap the zip to extract it. You'll see one folder
   called **lifesim-app** — open it.
   ⚠️ **Important:** go *inside* that folder first. You should now see these
   items sitting side by side: `.devcontainer`, `www`, `SETUP.md`,
   `package.json`, `capacitor.config.json`. On the repo page, tap **Add
   file → Upload files**, then select **those items** — not the outer
   `lifesim-app` folder itself. If GitHub shows a `lifesim-app` folder
   inside your repo afterward, that's one level too deep and Codespaces
   won't find the setup script — go back and re-upload from inside that
   folder instead.
3. Commit the upload (the default commit message is fine).

## Step 3 — Open a Codespace

1. On the repo page, tap the green **Code** button → **Codespaces** tab →
   **Create codespace on main**.
2. Wait for it to open — it'll launch a VS Code interface with a terminal at
   the bottom, right there in Chrome. The **first time** you open it, it'll
   automatically run a setup script that installs Java and the Android
   SDK — this takes a few minutes. You'll see it printing progress in the
   terminal; let it finish.

## Step 4 — Install the Capacitor Android project

In the terminal at the bottom of the Codespace, paste these one at a time:

```bash
npm install
npx cap add android
npx cap sync
```

`npx cap add android` creates a new `android/` folder — this is the actual
native Android project, generated automatically. You won't need to touch it
by hand for now.

## Step 5 — Build a debug APK

```bash
cd android
./gradlew assembleDebug
```

This takes a couple of minutes the first time. When it finishes, your APK is
at:

```
android/app/build/outputs/apk/debug/app-debug.apk
```

## Step 6 — Install it on your phone

In the Codespace's file explorer (left sidebar), find that `app-debug.apk`
file and tap it → **Download**. Since you're already on your phone, it just
drops straight into your **Downloads** folder — open it from there.

Android will ask permission to install from this source the first time —
allow it, then install. You may need to enable "Install unknown apps" for
Chrome (or whichever app you used) — Android will prompt you through that
automatically.

**At this stage the app has no ads wired in yet** — it's just your game,
wrapped as a real installable Android app, to confirm the whole pipeline
works end to end before we add AdMob on top. Open it, play a bit, confirm
it feels right.

---

## If something goes wrong

Copy the exact error text from the terminal and send it to me — paste the
whole thing, don't summarize it. Most failures at this stage are either the
SDK setup script (Step 3) not finishing before you tried Step 4/5, or a
typo in a pasted command. Both are easy to fix once I can see the actual
error.

## What's next, once this works

Once you've got the plain app installed and running on your phone, next
we'll:
1. Set up an AdMob account and create the ad units (Rewarded + Interstitial)
2. Add the Capacitor AdMob plugin and wire it into the game's existing
   `window.showRewardedAd` / `window.showInterstitialAd` hooks
3. Add the Remove Ads in-app purchase
4. Rebuild, reinstall on your phone, and test the real ads for real

We're doing this in stages on purpose — confirming each piece works before
adding the next, rather than debugging five new things at once.

