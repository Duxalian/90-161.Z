// Render assets/logo/*.svg to PNG (headless Chromium via Playwright). Run after scripts/build_logo.py:
//   node scripts/render_logo.js
const {chromium} = require('playwright'); const fs = require('fs'); const path = require('path');
const dir = path.join(__dirname, '..', 'assets', 'logo');
(async () => {
  const b = await chromium.launch();
  // PNG names follow the gov-device rule 90161Z-T<NN>-<slug>-r<N>: go.md task 14 links them.
  for (const [svg, size, out] of [['90161Z-mark.svg', 512, '90161Z-T14-site-logo-r2.png'],
                                  ['90161Z-mark.svg', 64, '90161Z-T14-site-logo-small-r2.png'],
                                  ['90161Z-mark-navy.svg', 512, '90161Z-T14-site-logo-thumb-r2.png']]) {
    const p = await b.newPage({viewport: {width: size, height: size}});
    const s = fs.readFileSync(path.join(dir, svg), 'utf8').replace('width="512" height="512"', `width="${size}" height="${size}"`);
    await p.setContent(`<html><body style="margin:0;background:transparent">${s}</body></html>`);
    await p.screenshot({path: path.join(dir, out), omitBackground: true, clip: {x: 0, y: 0, width: size, height: size}});
    await p.close();
  }
  await b.close();
})();
