// Builds VENDORS.md from AmmoFinder/Data.lua. Run from tests: npm run vendors
const fs = require('fs');
const path = require('path');
const root = path.join(__dirname, '..');
const [src, out] = [path.join(root, 'AmmoFinder', 'Data.lua'), path.join(root, 'VENDORS.md')];
const text = fs.readFileSync(src, 'utf8');

const ammo = {}, type = {}, levels = [];
for (const m of text.matchAll(/\{ id = (\d+), type = "(\w+)", level = (\d+), name = "([^"]+)" \}/g)) {
  ammo[m[1]] = m[4]; type[m[1]] = m[2]; levels.push(`${m[4]} (level ${m[3]})`);
}

const capitals = new Set(['Stormwind City', 'Ironforge', 'Darnassus', 'Orgrimmar', 'Thunder Bluff', 'Undercity']);
const zones = [];
let zone = null;
for (const line of text.split(/\r?\n/)) {
  let m = line.match(/^\s*\[(\d+)\] = \{ -- (.+)$/);
  if (m) { zone = { map: m[1], name: m[2].trim(), vendors: [] }; zones.push(zone); continue; }
  m = line.match(/^\s*\["([^"]+)"\] = \{\s*$/); // Forever's new zones, by name
  if (m) { zone = { map: null, name: m[1], isNew: true, vendors: [] }; zones.push(zone); continue; }
  if (!zone || !line.includes('name = "')) continue;
  const get = (k) => { const r = line.match(new RegExp(k + ' = "([^"]*)"')); return r ? r[1] : null; };
  const num = (k) => { const r = line.match(new RegExp('\\b' + k + ' = ([\\d.]+)')); return r ? Number(r[1]) : null; };
  const items = (line.match(/items = \{([^}]*)\}/) || [, ''])[1].split(',').map(s => s.trim()).filter(Boolean);
  zone.vendors.push({ name: get('name'), subzone: get('subzone'), x: num('x'), y: num('y'),
    faction: get('faction'), id: num('id'), items, title: get('title') });
}

const fmt = (n) => (Number.isInteger(n) ? n.toFixed(0) : String(n));
const factionLabel = (f) => f === 'Alliance' ? 'Alliance' : f === 'Horde' ? 'Horde' : 'Both (neutral)';
const sorted = [...zones].sort((a, b) => (capitals.has(b.name) - capitals.has(a.name)) || a.name.localeCompare(b.name));
const all = zones.flatMap(z => z.vendors);
const count = (f) => all.filter(v => (v.faction || null) === f).length;

let md = `# Ammo vendors

Every ammo vendor built into AmmoFinder, from \`AmmoFinder/Data.lua\`: ${all.length} vendors in ${zones.length} zones.
${count('Alliance')} sell only to the Alliance, ${count('Horde')} only to the Horde, and ${count(null)} in neutral places sell to both.

- **Coords** are map coordinates (0-100) on the zone's map, the same numbers \`/ammo where\` prints. They come from WoW Forever's own game data (outof.games, 1.60.1), so they fit Forever's reshaped maps too.
- **Title** is what they are called under their name. Weapon merchants also sell some ammo, but AmmoFinder only sends you to one when no bowyer, gunsmith or general goods vendor there sells what you want.
- **Faction** is who can buy from them. AmmoFinder never announces a vendor from the other faction.
- **Arrows** and **Bullets** are the vendor ammo they stock in WoW Forever. Bows and crossbows shoot arrows, guns shoot bullets. Lowest tier first: ${levels.join(', ')}.

This file is generated from \`Data.lua\`: change the data there, then run \`npm run vendors\` in \`tests\`.

`;
md += '## Zones\n\n' + sorted.map(z => `[${z.name}](#${z.name.toLowerCase().replace(/[^a-z0-9 -]/g, '').replace(/ /g, '-')})`).join(' · ') + '\n\n';
for (const z of sorted) {
  md += `## ${z.name}\n\n${capitals.has(z.name) ? 'Capital city. ' : ''}${z.isNew ? "New in WoW Forever. AmmoFinder finds it in game by the zone's name." : `Map id ${z.map}.`}\n\n`;
  md += '| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |\n| --- | --- | --- | --- | --- | --- | --- |\n';
  const vs = [...z.vendors].sort((a, b) => (a.subzone || '').localeCompare(b.subzone || '') || a.name.localeCompare(b.name));
  for (const v of vs) {
    const link = v.id ? `[${v.name}](https://outof.games/realms/forever/npc/${v.id}/)` : v.name;
    const coords = v.x != null ? `${fmt(v.x)}, ${fmt(v.y)}` : '-';
    const list = (t) => v.items.filter(i => type[i] === t).map(i => ammo[i]).join(', ') || '-';
    md += `| ${link} | ${v.title || '-'} | ${v.subzone || '-'} | ${coords} | ${factionLabel(v.faction)} | ${list('arrow')} | ${list('bullet')} |\n`;
  }
  md += '\n';
}
fs.writeFileSync(out, md);
console.log(`${all.length} vendors, ${zones.length} zones, A ${count('Alliance')} H ${count('Horde')} N ${count(null)}`);
