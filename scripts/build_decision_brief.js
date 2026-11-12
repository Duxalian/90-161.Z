// Builds the decision brief for wing and NGB decision makers from docs/brief/brief.json (PFM 2026-11-12:
// decisions logged, risks presented in PowerPoint). Never hand-edit the .pptx; change brief.json or this file and run:
//   NODE_PATH=$(npm root -g):$(npm root -g)/pptxgenjs/node_modules node scripts/build_decision_brief.js
// Needs pptxgenjs 3.12.0 (npm install -g pptxgenjs@3.12.0). Output name comes from brief.json "file".
const fs = require("fs");
const path = require("path");
const pptxgen = require("pptxgenjs");

const root = path.join(__dirname, "..");
const B = JSON.parse(fs.readFileSync(path.join(root, "docs/brief/brief.json"), "utf8"));

const THEME = {
  name: "90-161.Z Brief",
  headFontFace: "Cambria",
  bodyFontFace: "Calibri",
  colors: {
    dk1: "1B1F2A", lt1: "FFFFFF", dk2: "16324F", lt2: "EEF1F5",
    accent1: "16324F", accent2: "C8102E", accent3: "9A5B00", accent4: "2E7D4F",
    accent5: "5B6B7F", accent6: "8FA3B8", hlink: "1F5FA8", folHlink: "5B3A8C",
  },
};
const HEX = { navy: "16324F", red: "C8102E", amber: "9A5B00", green: "2E7D4F", slate: "5B6B7F",
  pale: "EEF1F5", ink: "1B1F2A", white: "FFFFFF", mist: "8FA3B8", line: "C9D2DC",
  redT: "F6D5DA", amberT: "F8E8C4", greenT: "D6EBDD" };

const pres = new pptxgen();
pres.layout = "LAYOUT_WIDE"; // 13.333 x 7.5 in
pres.title = B.title;
pres.subject = "Decision brief";
pres.author = "90-161.Z project";
pres.theme = { headFontFace: THEME.headFontFace, bodyFontFace: THEME.bodyFontFace };

const W = 13.333, M = 0.6;
const marking = (y) => ({ text: { text: B.marking, options: { x: 0, y, w: W, h: 0.3, align: "center", fontSize: 10, bold: true, color: HEX.ink } } });

pres.defineSlideMaster({
  title: "DARK", background: { color: HEX.navy },
  objects: [
    { text: { text: B.marking, options: { x: 0, y: 0.05, w: W, h: 0.3, align: "center", fontSize: 10, bold: true, color: HEX.white } } },
    { text: { text: B.marking, options: { x: 0, y: 7.15, w: W, h: 0.3, align: "center", fontSize: 10, bold: true, color: HEX.white } } },
    { placeholder: { options: { name: "title", type: "title", x: M, y: 2.2, w: W - 2 * M, h: 1.6, fontFace: "Cambria", fontSize: 40, bold: true, color: HEX.white, valign: "bottom" }, text: "" } },
    { placeholder: { options: { name: "body", type: "body", x: M, y: 4.0, w: W - 2 * M, h: 1.6, fontSize: 18, color: "DDE5EE", valign: "top" }, text: "" } },
  ],
});
pres.defineSlideMaster({
  title: "CONTENT", background: { color: HEX.white },
  margin: [0.9, M, 0.7, M],
  objects: [
    marking(0.05), marking(7.15),
    { placeholder: { options: { name: "title", type: "title", x: M, y: 0.4, w: W - 2 * M, h: 0.9, fontFace: "Cambria", fontSize: 30, bold: true, color: HEX.navy, valign: "middle" }, text: "" } },
    { text: { text: B.footer, options: { x: M, y: 6.85, w: 8, h: 0.3, fontSize: 10, color: HEX.slate } } },
  ],
  slideNumber: { x: W - M - 0.6, y: 6.85, w: 0.6, h: 0.3, fontSize: 10, color: HEX.slate, align: "right" },
});

let sec = "";
function slide(master, section) {
  if (section && section !== sec) { pres.addSection({ title: section }); sec = section; }
  return pres.addSlide({ masterName: master, sectionTitle: sec });
}
function txt(s, text, o) { s.addText(text, Object.assign({ isTextBox: true, fontSize: 14, color: HEX.ink, valign: "top", margin: 0.05 }, o)); }
function card(s, x, y, w, h, fill, name) {
  s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x, y, w, h, rectRadius: 0.08, fill: { color: fill }, line: { color: fill }, objectName: name });
}
const sevColor = { H: HEX.red, M: HEX.amber, L: HEX.green };
const sevTint = { H: HEX.redT, M: HEX.amberT, L: HEX.greenT };
function th(t) { return { text: t, options: { bold: true, color: HEX.white, fill: { color: HEX.navy }, fontSize: 12 } }; }
function td(t, o) { return { text: String(t), options: Object.assign({ fontSize: 12, color: HEX.ink, valign: "top" }, o) }; }

// 1. Title
{
  const s = slide("DARK", "Summary");
  s.addText(B.title, { placeholder: "title" });
  s.addText(B.subtitle, { placeholder: "body" });
  s.addNotes(B.notes.title);
}

// 2. Bottom line
{
  const s = slide("CONTENT", "Summary");
  s.addText("Bottom line", { placeholder: "title" });
  const cw = (W - 2 * M - 0.6) / 3;
  B.bottomLine.cards.forEach((c, i) => {
    const x = M + i * (cw + 0.3);
    card(s, x, 1.45, cw, 2.15, HEX.pale, "stat-" + i);
    txt(s, c.big, { x: x + 0.25, y: 1.6, w: cw - 0.5, h: 0.95, fontSize: 48, bold: true, fontFace: "Cambria", color: [HEX.navy, HEX.red, HEX.amber][i] });
    txt(s, c.label, { x: x + 0.25, y: 2.55, w: cw - 0.5, h: 0.95, fontSize: 14, color: HEX.ink });
  });
  txt(s, "What we ask of you", { x: M, y: 3.85, w: 6, h: 0.4, fontSize: 20, bold: true, color: HEX.navy });
  s.addText(B.bottomLine.asks.map((a, i, arr) => ({ text: a, options: { bullet: { type: "number" }, breakLine: i < arr.length - 1, paraSpaceAfter: 6 } })),
    { isTextBox: true, x: M, y: 4.3, w: W - 2 * M, h: 2.4, fontSize: 15, color: HEX.ink, valign: "top" });
  s.addNotes(B.notes.bottomLine);
}

// 3. What it does: stages
{
  const s = slide("CONTENT", "The product");
  s.addText("One tracked path from request to posted publication", { placeholder: "title" });
  txt(s, B.product.lead, { x: M, y: 1.35, w: W - 2 * M, h: 0.7, fontSize: 15 });
  const st = B.product.stages, n = st.length, gap = 0.08, cw = (W - 2 * M - gap * (n - 1)) / n;
  st.forEach((t, i) => {
    const x = M + i * (cw + gap);
    s.addText(String(i), { shape: pres.shapes.PENTAGON, x, y: 2.35, w: cw, h: 0.8, fill: { color: i === 3 || i === 11 ? HEX.amber : HEX.navy }, line: { color: HEX.white },
      objectName: "stage-" + i, fontSize: 18, bold: true, color: HEX.white, align: "center", valign: "middle", margin: 0 });
    txt(s, t, { x: x - 0.02, y: 3.35, w: cw + 0.04, h: 1.0, fontSize: 11, color: HEX.ink, align: "center" });
  });
  txt(s, B.product.stageKey, { x: M, y: 4.45, w: W - 2 * M, h: 0.35, fontSize: 11, color: HEX.slate, italic: true });
  const cw2 = (W - 2 * M - 0.6) / 3;
  B.product.users.forEach((u, i) => {
    const x = M + i * (cw2 + 0.3);
    card(s, x, 4.95, cw2, 1.75, HEX.pale, "user-" + i);
    txt(s, u.who, { x: x + 0.2, y: 5.05, w: cw2 - 0.4, h: 0.4, fontSize: 16, bold: true, color: HEX.navy });
    txt(s, u.does, { x: x + 0.2, y: 5.45, w: cw2 - 0.4, h: 1.2, fontSize: 13 });
  });
  s.addNotes(B.notes.product);
}

// 4. Architecture and data boundary
{
  const s = slide("CONTENT", "The product");
  s.addText("Built only on what every wing already has", { placeholder: "title" });
  // DoD365 zone
  card(s, M, 1.4, 7.7, 5.2, HEX.pale, "zone-dod365");
  txt(s, "DoD365 (government data stays here)", { x: M + 0.2, y: 1.5, w: 7.3, h: 0.4, fontSize: 15, bold: true, color: HEX.navy });
  B.arch.dod.forEach((b, i) => {
    const col = i % 2, row = Math.floor(i / 2);
    const x = M + 0.25 + col * 3.65, y = 2.0 + row * 1.5;
    s.addShape(pres.shapes.RECTANGLE, { x, y, w: 3.45, h: 1.3, fill: { color: HEX.white }, line: { color: HEX.line, width: 1 }, objectName: "dod-" + i });
    txt(s, b.name, { x: x + 0.12, y: y + 0.08, w: 3.2, h: 0.4, fontSize: 14, bold: true, color: HEX.navy });
    txt(s, b.role, { x: x + 0.12, y: y + 0.48, w: 3.2, h: 0.8, fontSize: 12 });
  });
  // Outside zone
  const ox = M + 8.0, ow = W - M - ox;
  card(s, ox, 1.4, ow, 5.2, "F7F7F7", "zone-outside");
  txt(s, "Outside DoD365 (no government data)", { x: ox + 0.2, y: 1.5, w: ow - 0.4, h: 0.4, fontSize: 15, bold: true, color: HEX.slate });
  B.arch.outside.forEach((b, i) => {
    const y = 2.0 + i * 1.5;
    s.addShape(pres.shapes.RECTANGLE, { x: ox + 0.2, y, w: ow - 0.4, h: 1.3, fill: { color: HEX.white }, line: { color: HEX.line, width: 1, dashType: "dash" }, objectName: "out-" + i });
    txt(s, b.name, { x: ox + 0.32, y: y + 0.08, w: ow - 0.64, h: 0.4, fontSize: 14, bold: true, color: HEX.slate });
    txt(s, b.role, { x: ox + 0.32, y: y + 0.48, w: ow - 0.64, h: 0.8, fontSize: 12 });
  });
  s.addNotes(B.notes.arch);
}

// 5. Setup
{
  const s = slide("CONTENT", "Install and update");
  s.addText("One person sets up a wing; setup says what is missing", { placeholder: "title" });
  const n = B.setup.parts.length, gw = (W - 2 * M - 0.3 * (n - 1)) / n;
  B.setup.parts.forEach((p, i) => {
    const x = M + i * (gw + 0.3);
    card(s, x, 1.45, gw, 2.3, HEX.pale, "part-" + i);
    txt(s, p.n, { x: x + 0.2, y: 1.55, w: gw - 0.4, h: 0.5, fontSize: 24, bold: true, fontFace: "Cambria", color: HEX.amber });
    txt(s, p.name, { x: x + 0.2, y: 2.05, w: gw - 0.4, h: 0.4, fontSize: 15, bold: true, color: HEX.navy });
    txt(s, p.does, { x: x + 0.2, y: 2.45, w: gw - 0.4, h: 1.25, fontSize: 12 });
  });
  const rows = [[th("Right the installer needs"), th("If missing, setup tells them to ask"), th("Fallback")]];
  B.setup.rights.forEach(r => rows.push([td(r[0]), td(r[1]), td(r[2])]));
  s.addTable(rows, { x: M, y: 3.95, w: W - 2 * M, colW: [4.0, 4.6, W - 2 * M - 8.6], border: { type: "solid", color: HEX.line, pt: 0.75 }, rowH: 0.3, margin: 0.05 });
  s.addNotes(B.notes.setup);
}

// 6. Updates
{
  const s = slide("CONTENT", "Install and update");
  s.addText("Wings learn of updates in the app, at start or on demand", { placeholder: "title" });
  const colW = (W - 2 * M - 0.4) / 2;
  [["Data-only update", B.updates.data, HEX.green], ["Logic update", B.updates.logic, HEX.amber]].forEach(([h, items, col], i) => {
    const x = M + i * (colW + 0.4);
    card(s, x, 1.45, colW, 2.6, HEX.pale, "upd-" + i);
    txt(s, h, { x: x + 0.25, y: 1.55, w: colW - 0.5, h: 0.45, fontSize: 18, bold: true, color: col });
    s.addText(items.map((t, k) => ({ text: t, options: { bullet: true, breakLine: k < items.length - 1, paraSpaceAfter: 4 } })),
      { isTextBox: true, x: x + 0.25, y: 2.05, w: colW - 0.5, h: 1.9, fontSize: 14, color: HEX.ink, valign: "top" });
  });
  const n = B.updates.flow.length, sw = (W - 2 * M - 0.25 * (n - 1)) / n;
  B.updates.flow.forEach((t, i) => {
    const x = M + i * (sw + 0.25);
    s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x, y: 4.35, w: sw, h: 1.25, rectRadius: 0.08, fill: { color: HEX.navy }, line: { color: HEX.navy }, objectName: "flow-" + i });
    txt(s, (i + 1) + ". " + t, { x: x + 0.12, y: 4.42, w: sw - 0.24, h: 1.12, fontSize: 13, color: HEX.white, valign: "middle" });
  });
  txt(s, B.updates.rule, { x: M, y: 5.85, w: W - 2 * M, h: 0.8, fontSize: 14, bold: true, color: HEX.navy });
  s.addNotes(B.notes.updates);
}

// 7. Decisions made
{
  const s = slide("CONTENT", "Decisions");
  s.addText(B.decided.title, { placeholder: "title" });
  card(s, M, 1.45, 3.2, 3.9, HEX.navy, "decided-stat");
  txt(s, B.decided.big, { x: M + 0.25, y: 1.7, w: 2.7, h: 1.1, fontSize: 60, bold: true, fontFace: "Cambria", color: HEX.white });
  txt(s, B.decided.bigLabel, { x: M + 0.25, y: 2.85, w: 2.7, h: 2.3, fontSize: 14, color: "DDE5EE" });
  const rows = [[th("Theme"), th("Decided (date, by the PFM unless marked)")]];
  B.decided.rows.forEach(r => rows.push([td(r[0], { bold: true, color: HEX.navy }), td(r[1])]));
  s.addTable(rows, { x: M + 3.5, y: 1.45, w: W - 2 * M - 3.5, colW: [2.1, W - 2 * M - 5.6], border: { type: "solid", color: HEX.line, pt: 0.75 }, margin: 0.06 });
  s.addNotes(B.notes.decided);
}

// 8+. Decisions needed (one slide per group)
B.needed.forEach(g => {
  const s = slide("CONTENT", "Decisions");
  s.addText(g.title, { placeholder: "title" });
  txt(s, g.lead, { x: M, y: 1.3, w: W - 2 * M, h: 0.45, fontSize: 14, color: HEX.slate });
  const rows = [[th("#"), th("Decision"), th("Options"), th("Recommendation"), th("Decider")]];
  g.items.forEach(r => rows.push([td(r.id, { bold: true }), td(r.q), td(r.opts), td(r.rec, { bold: true, color: HEX.navy }), td(r.who)]));
  s.addTable(rows, { x: M, y: 1.8, w: W - 2 * M, colW: [0.5, 3.4, 3.7, 2.9, W - 2 * M - 10.5], border: { type: "solid", color: HEX.line, pt: 0.75 }, margin: 0.05 });
  s.addNotes(g.notes || "");
});

// Risk heat map
const R = B.risks;
const lv = { L: 0, M: 1, H: 2 };
{
  const s = slide("CONTENT", "Risks");
  s.addText("Risk picture: " + R.filter(r => r.l === "H" && r.i === "H").length + " risks are likely and severe today", { placeholder: "title" });
  const gx = M + 1.0, gy = 1.45, cw = 2.55, ch = 1.5;
  const cellCol = (l, i) => (l + i >= 3 ? HEX.redT : l + i >= 2 ? HEX.amberT : HEX.greenT);
  for (let li = 0; li < 3; li++) for (let ii = 0; ii < 3; ii++) {
    const x = gx + ii * cw, y = gy + (2 - li) * ch;
    s.addShape(pres.shapes.RECTANGLE, { x, y, w: cw - 0.06, h: ch - 0.06, fill: { color: cellCol(li, ii) }, line: { color: HEX.white }, objectName: `heat-${li}-${ii}` });
    const ids = R.filter(r => lv[r.l] === li && lv[r.i] === ii).map(r => r.id);
    txt(s, ids.join("  "), { x: x + 0.1, y: y + 0.1, w: cw - 0.26, h: ch - 0.26, fontSize: 13, bold: true, color: HEX.ink, valign: "middle", align: "center" });
  }
  ["Low", "Medium", "High"].forEach((t, k) => {
    txt(s, t, { x: gx + k * cw, y: gy + 3 * ch + 0.02, w: cw, h: 0.3, fontSize: 12, align: "center", color: HEX.slate });
    txt(s, t, { x: M, y: gy + (2 - k) * ch + ch / 2 - 0.15, w: 0.95, h: 0.3, fontSize: 12, align: "right", color: HEX.slate });
  });
  txt(s, "Impact", { x: gx, y: gy + 3 * ch + 0.32, w: 3 * cw, h: 0.3, fontSize: 12, bold: true, align: "center", color: HEX.slate });
  txt(s, "Likelihood", { x: M, y: gy + 0.05, w: 0.95, h: 0.3, fontSize: 12, bold: true, align: "right", color: HEX.slate });
  const kx = gx + 3 * cw + 0.3, kw = W - M - kx;
  txt(s, "How to read it", { x: kx, y: gy, w: kw, h: 0.4, fontSize: 16, bold: true, color: HEX.navy });
  s.addText(B.riskKey.map((t, k) => ({ text: t, options: { bullet: true, breakLine: k < B.riskKey.length - 1, paraSpaceAfter: 6 } })),
    { isTextBox: true, x: kx, y: gy + 0.45, w: kw, h: 4.3, fontSize: 13, color: HEX.ink, valign: "top" });
  s.addNotes(B.notes.heat);
}

// Top risks (H rows first), 6 per slide
const order = (r) => -(lv[r.l] + lv[r.i]) * 10 - lv[r.i];
const sorted = R.slice().sort((a, b) => order(a) - order(b));
const top = sorted.filter(r => lv[r.l] + lv[r.i] >= 3);
for (let k = 0; k < top.length; k += 6) {
  const s = slide("CONTENT", "Risks");
  s.addText(`Top risks and what reduces them (${k + 1}-${Math.min(k + 6, top.length)} of ${top.length})`, { placeholder: "title" });
  const rows = [[th("ID"), th("Risk"), th("L"), th("I"), th("What reduces it"), th("Owner")]];
  top.slice(k, k + 6).forEach(r => rows.push([td(r.id, { bold: true }), td(r.risk), td(r.l, { bold: true, color: sevColor[r.l], align: "center" }),
    td(r.i, { bold: true, color: sevColor[r.i], align: "center" }), td(r.mit), td(r.owner)]));
  s.addTable(rows, { x: M, y: 1.4, w: W - 2 * M, colW: [0.6, 4.3, 0.4, 0.4, 4.4, W - 2 * M - 10.1], border: { type: "solid", color: HEX.line, pt: 0.75 }, margin: 0.05 });
}

// Sustainment options
{
  const s = slide("CONTENT", "Path forward");
  s.addText(B.sustain.title, { placeholder: "title" });
  const n = B.sustain.options.length, cw = (W - 2 * M - 0.3 * (n - 1)) / n;
  B.sustain.options.forEach((o, i) => {
    const x = M + i * (cw + 0.3), rec = !!o.rec;
    card(s, x, 1.45, cw, 4.1, rec ? HEX.navy : HEX.pale, "opt-" + i);
    const fg = rec ? HEX.white : HEX.ink, hd = rec ? HEX.white : HEX.navy;
    txt(s, o.name + (rec ? "  (recommended)" : ""), { x: x + 0.25, y: 1.6, w: cw - 0.5, h: 0.7, fontSize: 17, bold: true, color: hd });
    txt(s, o.what, { x: x + 0.25, y: 2.3, w: cw - 0.5, h: 1.1, fontSize: 13, color: fg });
    txt(s, "For: " + o.pro, { x: x + 0.25, y: 3.3, w: cw - 0.5, h: 1.15, fontSize: 13, color: fg });
    txt(s, "Against: " + o.con, { x: x + 0.25, y: 4.35, w: cw - 0.5, h: 1.3, fontSize: 13, color: fg });
  });
  txt(s, B.sustain.note, { x: M, y: 5.75, w: W - 2 * M, h: 0.5, fontSize: 13, color: HEX.slate, italic: true });
  s.addNotes(B.notes.sustain);
}

// Roadmap with gates
{
  const s = slide("CONTENT", "Path forward");
  s.addText("Roadmap: each phase opens only when its gate passes", { placeholder: "title" });
  const ph = B.roadmap, n = ph.length, pw = (W - 2 * M - 0.2 * (n - 1)) / n;
  s.addShape(pres.shapes.LINE, { x: M, y: 2.05, w: W - 2 * M, h: 0, line: { color: HEX.mist, width: 2 } });
  ph.forEach((p, i) => {
    const x = M + i * (pw + 0.2);
    s.addShape(pres.shapes.OVAL, { x: x + pw / 2 - 0.2, y: 1.85, w: 0.4, h: 0.4, fill: { color: p.state === "now" ? HEX.amber : HEX.navy }, line: { color: HEX.white, width: 2 }, objectName: "ms-" + i });
    txt(s, p.name + (p.state === "now" ? " (now)" : ""), { x, y: 2.4, w: pw, h: 0.75, fontSize: 15, bold: true, color: HEX.navy, align: "center" });
    card(s, x, 3.2, pw, 1.9, HEX.pale, "ph-" + i);
    txt(s, p.what, { x: x + 0.15, y: 3.3, w: pw - 0.3, h: 1.75, fontSize: 12 });
    txt(s, "Gate: " + p.gate, { x: x + 0.05, y: 5.25, w: pw - 0.1, h: 1.3, fontSize: 12, bold: true, color: HEX.amber });
  });
  s.addNotes(B.notes.roadmap);
}

// Close
{
  const s = slide("DARK", "Path forward");
  s.addText(B.close.title, { placeholder: "title" });
  s.addText(B.close.items.map((t, k) => ({ text: t, options: { bullet: { type: "number" }, breakLine: k < B.close.items.length - 1, paraSpaceAfter: 6 } })), { placeholder: "body" });
}

// Appendix: full risk register, considerations, sources
{
  const per = 8, byId = R.slice().sort((a, b) => a.id.localeCompare(b.id));
  for (let k = 0; k < byId.length; k += per) {
    const s = slide("CONTENT", "Appendix");
    s.addText(`Appendix A: risk register (${byId[k].id}-${byId[Math.min(k + per, byId.length) - 1].id}, by ID)`, { placeholder: "title" });
    const rows = [[th("ID"), th("Area"), th("Risk"), th("L"), th("I"), th("Response"), th("Status")]];
    byId.slice(k, k + per).forEach(r => rows.push([td(r.id, { bold: true }), td(r.area), td(r.risk), td(r.l, { color: sevColor[r.l], bold: true, align: "center" }),
      td(r.i, { color: sevColor[r.i], bold: true, align: "center" }), td(r.mit), td(r.status)]));
    s.addTable(rows, { x: M, y: 1.35, w: W - 2 * M, colW: [0.55, 1.3, 4.0, 0.35, 0.35, 4.0, W - 2 * M - 10.55], border: { type: "solid", color: HEX.line, pt: 0.75 }, margin: 0.04, fontSize: 11 });
  }
}
{
  const s = slide("CONTENT", "Appendix");
  s.addText("Appendix B: where the full record lives", { placeholder: "title" });
  const rows = [[th("Record"), th("Address (public, no government data)")]];
  B.sources.forEach(r => rows.push([td(r[0], { bold: true }), td(r[1], { fontSize: 11 })]));
  s.addTable(rows, { x: M, y: 1.4, w: W - 2 * M, colW: [3.4, W - 2 * M - 3.4], border: { type: "solid", color: HEX.line, pt: 0.75 }, margin: 0.06 });
  txt(s, B.method, { x: M, y: 5.2, w: W - 2 * M, h: 1.4, fontSize: 12, color: HEX.slate });
}

(async () => {
  const out = path.join(root, B.file);
  await pres.writeFile({ fileName: out });
  // Drop ZIP folder entries: files with them can fail to open from SharePoint or OneDrive.
  const JSZip = require("jszip");
  const zin = await JSZip.loadAsync(fs.readFileSync(out)), zout = new JSZip();
  for (const [n, f] of Object.entries(zin.files)) if (!f.dir) zout.file(n, await f.async("nodebuffer"), { createFolders: false });
  fs.writeFileSync(out, await zout.generateAsync({ type: "nodebuffer", compression: "DEFLATE", mimeType: "application/vnd.openxmlformats-officedocument.presentationml.presentation" }));
  console.log("wrote " + B.file);
})();
