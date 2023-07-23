# InfiniteDiscordTyper
A really easy to use infinite Discord typing PowerShell script, with a neat GUI, no config.json required.

# How to use
Make sure Developer Mode is enabled, by going to Settings > App Settings > Advanced > Developer Mode.

Now, login to Discord in your favorite web browser. Once you're in, you'll need to get your Authorization token, which can be done by entering DevTools(F12 or CTRL-SHIFT-I on most browsers), going to Console, and pasting the following:

```(webpackChunkdiscord_app.push([[''],{},e=>{m=[];for(let c in e.c)m.push(e.c[c])}]),m).find(m=>m?.exports?.default?.getToken!==void 0).exports.default.getToken()```

which should return a long string of letters. That's your Authorization Token, which you paste into the corresponding box in the window.

Now that the hard part's out of the way, you'll now need your Channel ID. Right click on the channel you want to infinitely type in, and click "Copy Channel ID". Paste it into the Channel ID box.

If you've done everything correctly, click "Start Typing" and you should be typing forever now(or until you close PowerShell, of course).
