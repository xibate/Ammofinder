// Draws the addon's icon in AmmoFinder/Media/ and the README icon, in the line style of Crescendo's and Easy Delete's
// logos: an amber arrow in a ring on the dark of the settings window.
//
// - AmmoFinder/Media/Icon.tga: the AddOns list and settings icon, 64x64
// - .github/icon.png: the README icon, 256x256
//
// Run: node tools/gen_icons.js   (no packages needed)
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const root = path.join(__dirname, '..');
const AMBER = [245, 179, 56];
const DARK = [23, 20, 16];
const SAMPLES = 4; // 4x4 samples per pixel, so the lines are smooth

// Distance from point p to the segment a-b
function segment(px, py, ax, ay, bx, by) {
    const dx = bx - ax, dy = by - ay;
    const t = Math.max(0, Math.min(1, ((px - ax) * dx + (py - ay) * dy) / (dx * dx + dy * dy)));
    return Math.hypot(px - (ax + t * dx), py - (ay + t * dy));
}

function inTriangle(px, py, [a, b, c]) {
    const s = (p, q, r) => (p[0] - r[0]) * (q[1] - r[1]) - (q[0] - r[0]) * (p[1] - r[1]);
    const p = [px, py];
    const d1 = s(p, a, b), d2 = s(p, b, c), d3 = s(p, c, a);
    return !((d1 < 0 || d2 < 0 || d3 < 0) && (d1 > 0 || d2 > 0 || d3 > 0));
}

// The arrow, in a 0-1 view box with y down: a shaft from bottom left to top right, a head and two pairs of feathers
const LINE = 0.055;
const shaft = [[0.28, 0.72], [0.60, 0.40]];
const head = [[0.73, 0.27], [0.53, 0.35], [0.65, 0.47]];
const feathers = [];
for (const [x, y] of [[0.28, 0.72], [0.36, 0.64]]) {
    feathers.push([[x, y], [x - 0.08, y]], [[x, y], [x, y + 0.08]]);
}

// The colour of one sample, or null when it is outside the icon
function sample(x, y) {
    const r = Math.hypot(x - 0.5, y - 0.5);
    const outer = 0.47, ring = 0.05;
    if (r > outer) return null;
    if (r > outer - ring) return AMBER;
    if (inTriangle(x, y, head)) return AMBER;
    for (const [a, b] of [shaft, ...feathers]) {
        if (segment(x, y, a[0], a[1], b[0], b[1]) <= LINE / 2) return AMBER;
    }
    return DARK;
}

// RGBA rows, top row first
function draw(size) {
    const pixels = Buffer.alloc(size * size * 4);
    for (let py = 0; py < size; py++) {
        for (let px = 0; px < size; px++) {
            let r = 0, g = 0, b = 0, a = 0;
            for (let sy = 0; sy < SAMPLES; sy++) {
                for (let sx = 0; sx < SAMPLES; sx++) {
                    const c = sample((px + (sx + 0.5) / SAMPLES) / size, (py + (sy + 0.5) / SAMPLES) / size);
                    if (c) { r += c[0]; g += c[1]; b += c[2]; a++; }
                }
            }
            const i = (py * size + px) * 4;
            pixels[i] = a ? Math.round(r / a) : 0;
            pixels[i + 1] = a ? Math.round(g / a) : 0;
            pixels[i + 2] = a ? Math.round(b / a) : 0;
            pixels[i + 3] = Math.round(255 * a / (SAMPLES * SAMPLES));
        }
    }
    return pixels;
}

// Uncompressed 32-bit TGA, bottom row first, as the game reads it
function tga(size, pixels) {
    const header = Buffer.alloc(18);
    header[2] = 2;
    header.writeUInt16LE(size, 12);
    header.writeUInt16LE(size, 14);
    header[16] = 32;
    header[17] = 8;
    const body = Buffer.alloc(size * size * 4);
    for (let y = 0; y < size; y++) {
        for (let x = 0; x < size; x++) {
            const from = ((size - 1 - y) * size + x) * 4, to = (y * size + x) * 4;
            body[to] = pixels[from + 2];
            body[to + 1] = pixels[from + 1];
            body[to + 2] = pixels[from];
            body[to + 3] = pixels[from + 3];
        }
    }
    return Buffer.concat([header, body]);
}

const CRC_TABLE = Array.from({ length: 256 }, (_, n) => {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    return c >>> 0;
});
function crc32(buffer) {
    let c = 0xffffffff;
    for (const byte of buffer) c = CRC_TABLE[(c ^ byte) & 0xff] ^ (c >>> 8);
    return (c ^ 0xffffffff) >>> 0;
}

function png(size, pixels) {
    const chunk = (type, data) => {
        const length = Buffer.alloc(4);
        length.writeUInt32BE(data.length);
        const body = Buffer.concat([Buffer.from(type), data]);
        const crc = Buffer.alloc(4);
        crc.writeUInt32BE(crc32(body));
        return Buffer.concat([length, body, crc]);
    };
    const ihdr = Buffer.alloc(13);
    ihdr.writeUInt32BE(size, 0);
    ihdr.writeUInt32BE(size, 4);
    ihdr[8] = 8; // bit depth
    ihdr[9] = 6; // RGBA
    const raw = Buffer.alloc(size * (size * 4 + 1));
    for (let y = 0; y < size; y++) {
        pixels.copy(raw, y * (size * 4 + 1) + 1, y * size * 4, (y + 1) * size * 4);
    }
    return Buffer.concat([
        Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
        chunk('IHDR', ihdr),
        chunk('IDAT', zlib.deflateSync(raw)),
        chunk('IEND', Buffer.alloc(0)),
    ]);
}

fs.mkdirSync(path.join(root, 'AmmoFinder', 'Media'), { recursive: true });
fs.mkdirSync(path.join(root, '.github'), { recursive: true });
fs.writeFileSync(path.join(root, 'AmmoFinder', 'Media', 'Icon.tga'), tga(64, draw(64)));
fs.writeFileSync(path.join(root, '.github', 'icon.png'), png(256, draw(256)));
console.log('Wrote AmmoFinder/Media/Icon.tga and .github/icon.png');
