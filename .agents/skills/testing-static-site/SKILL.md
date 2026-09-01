---
name: testing-static-site
description: How to run and test this static portfolio site locally (CSP, fonts, iframe, copy/right-click behavior), including how to diff the branch against main in the browser.
---

# Testing nursude355.github.io locally

Plain static site: no build, no package manager, no credentials. Just `index.html`, `index.css`, `images/`.

## Serving

`file://` does NOT exercise `<meta http-equiv="Content-Security-Policy">` the same way as
an http origin (`'self'` resolves differently), so always serve over HTTP:

```bash
cd /path/to/repo && python3 -m http.server 8123
```

To compare against another branch in the same browser session, use a worktree on a second port:

```bash
git worktree add /tmp/site-main main
cd /tmp/site-main && python3 -m http.server 8124
```

Then open `localhost:8123` (branch) and `localhost:8124` (baseline) in tabs.

## Gotchas found while testing

- **Body background is CSS-loaded, not an `<img>`.** `index.css` sets `body { background-image: url(...) }`.
  A CSP `img-src` directive governs it, so a policy that omits the image's origin silently degrades the page
  to a flat `#F08080` with no artwork — easy to miss because no element is "missing". Always scroll past the
  header (the top sections have opaque backgrounds that cover the body background) before judging it.
- **Scrolling over the magicplan iframe zooms the 3D model instead of scrolling the page.** Scroll with the
  cursor in the left/right page margin (e.g. x≈70) to reach the footer.
- **Expect two pre-existing 404s** from `3d.magicplan.app` (`electricalpanel2.obj`, `annotationrectangle.obj`,
  initiator `vendors.js`). They come from inside the third-party iframe and appear on `main` too — check the
  baseline port before blaming a change for them.
- **Console filtering for CSP is unreliable** in DevTools here; the `N hidden` counter can mislead. Search the
  console for `Refused` and also compare the message list against the baseline port.
- **Verifying `copy` is (un)blocked:** there is no editable field on the page. Put a known sentinel in the
  clipboard first (type it into the address bar, Ctrl+A, Ctrl+C), then select page text, Ctrl+C, and paste back
  into the address bar. If the sentinel is still there, the page's `copy` handler blocked the copy.
- A `referrer` meta of `strict-origin-when-cross-origin` matches Chrome's default, so it produces no observable
  runtime difference — do not claim it was verified by browsing.

## Devin Secrets Needed

None.
