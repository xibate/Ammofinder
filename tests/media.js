// Draws the textures in AmmoFinder/Media as 32-bit TGA files: the waypoint arrow, the map pin and the dot of the map
// line. Run from tests: npm run media
const fs = require('fs');
const path = require('path');
const out = path.join(__dirname, '..', 'AmmoFinder', 'Media');
fs.mkdirSync(out, { recursive: true });

function writeTGA(file, size, pixel) {
    const SS = 4; // supersampling per axis, for smooth edges
    const header = Buffer.alloc(18);
    header[2] = 2; // uncompressed true colour
    header.writeUInt16LE(size, 12);
    header.writeUInt16LE(size, 14);
    header[16] = 32;
    header[17] = 0x28; // top-left origin, 8 alpha bits
    const data = Buffer.alloc(size * size * 4);
    for (let py = 0; py < size; py++) {
        for (let px = 0; px < size; px++) {
            let r = 0, g = 0, b = 0, a = 0;
            for (let sy = 0; sy < SS; sy++) {
                for (let sx = 0; sx < SS; sx++) {
                    // -1..1 across the image, y down
                    const u = ((px + (sx + 0.5) / SS) / size) * 2 - 1;
                    const v = ((py + (sy + 0.5) / SS) / size) * 2 - 1;
                    const c = pixel(u, v);
                    if (c) { r += c[0] * c[3]; g += c[1] * c[3]; b += c[2] * c[3]; a += c[3]; }
                }
            }
            const i = (py * size + px) * 4;
            const n = SS * SS;
            if (a > 0) {
                data[i] = Math.round((b / a) * 255);
                data[i + 1] = Math.round((g / a) * 255);
                data[i + 2] = Math.round((r / a) * 255);
            }
            data[i + 3] = Math.round((a / n) * 255);
        }
    }
    fs.writeFileSync(path.join(out, file), Buffer.concat([header, data]));
}

// Signed distance to a polygon: negative inside
function polygon(points) {
    return (u, v) => {
        let inside = false, best = Infinity;
        for (let i = 0, j = points.length - 1; i < points.length; j = i++) {
            const [xi, yi] = points[i], [xj, yj] = points[j];
            if ((yi > v) !== (yj > v) && u < ((xj - xi) * (v - yi)) / (yj - yi) + xi) inside = !inside;
            const dx = xj - xi, dy = yj - yi;
            const t = Math.max(0, Math.min(1, ((u - xi) * dx + (v - yi) * dy) / (dx * dx + dy * dy)));
            best = Math.min(best, Math.hypot(u - (xi + t * dx), v - (yi + t * dy)));
        }
        return inside ? -best : best;
    };
}

const mix = (a, b, t) => a.map((x, i) => x + (b[i] - x) * t);

// The arrow: a navigation arrow pointing up, lit from the left, with a dark outline. Drawn white-gold so the addon can
// tint it (amber, green when you face the vendor)
const arrow = polygon([[0, -0.92], [0.7, 0.78], [0, 0.42], [-0.7, 0.78]]);
writeTGA('Arrow.tga', 64, (u, v) => {
    const d = arrow(u, v);
    if (d > 0) return null;
    if (d > -0.07) return [0.08, 0.05, 0.02, 1]; // outline
    const shade = u < 0 ? 1 : 0.72; // two facets
    const top = mix([1, 0.97, 0.88], [0.92, 0.86, 0.72], (v + 0.92) / 1.7);
    return [top[0] * shade, top[1] * shade, top[2] * shade, 1];
});

// The pin: a ring with a dark outline and a bright centre, tinted by the addon
writeTGA('Pin.tga', 32, (u, v) => {
    const r = Math.hypot(u, v);
    if (r > 0.92) return null;
    if (r > 0.8) return [0.08, 0.05, 0.02, 1];
    if (r > 0.42) return [1, 0.95, 0.85, 1];
    if (r > 0.3) return [0.08, 0.05, 0.02, 1];
    return [1, 1, 1, 1];
});

// The dot of the map line: a soft white disc with a dark rim, tinted by the addon
writeTGA('Dot.tga', 16, (u, v) => {
    const r = Math.hypot(u, v);
    if (r > 0.95) return null;
    if (r > 0.7) return [0.08, 0.05, 0.02, 0.9];
    return [1, 1, 1, 1];
});
console.log('Wrote Arrow.tga, Pin.tga, Dot.tga to ' + out);
