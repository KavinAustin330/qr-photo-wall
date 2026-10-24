# QR Photo Wall

A lightweight event photo wall: guests scan a QR code, upload from camera/photo library, and approved photos appear live.

## Files
- `index.html` — event landing page + QR code
- `upload.html` — mobile upload page
- `wall.html` — realtime photo wall
- `admin.html` — moderation UI scaffold (requires secure admin auth/policies for delete)
- `config.js` — Supabase + deployment configuration
- `supabase.sql` — database/RLS policies

## 1. Create Supabase backend
1. Create a Supabase project.
2. Open **SQL Editor** and run `supabase.sql`.
3. Open **Storage** and create a bucket named `photos`; set it to **Public**.
4. In database Realtime/Replication settings, enable Realtime for the `photos` table.
5. In Project Settings/API, copy the **Project URL** and **anon/public key**. Never put a service-role key in this website.

## 2. Configure the site
Edit `config.js`:
```js
SUPABASE_URL: 'https://YOUR_PROJECT.supabase.co',
SUPABASE_ANON_KEY: 'YOUR_ANON_KEY',
SITE_URL: 'https://YOUR_USERNAME.github.io/YOUR_REPO'
```
You can also change `EVENT_NAME`, `MAX_FILE_MB`, and `MAX_FILES`.

## 3. Deploy on GitHub Pages
1. Create a GitHub repository, e.g. `qr-photo-wall`.
2. Upload all project files to the repository root.
3. Go to **Settings > Pages**.
4. Under Build and deployment choose **Deploy from a branch**, branch `main`, folder `/ (root)`.
5. Save and wait for GitHub Pages to publish.
6. Put the final GitHub Pages address into `SITE_URL` in `config.js`, commit the change, and refresh the home page. The QR code will then point to the deployed `upload.html`.

## Moderation / production security
The supplied public policies allow anonymous uploads and public reads but deliberately do NOT allow anonymous deletion. Before using `admin.html` for deletion, add Supabase Auth and an authenticated admin-only DELETE policy. For a public/high-traffic deployment, also add CAPTCHA/rate limiting and server-side file validation. If you want pre-moderation, change the `approved` default to `false` and build an authenticated approval action.

## Local preview
Because the site uses browser modules/CDN calls, preview it through a local web server rather than opening files directly. For example:
`python3 -m http.server 8080`
then open `http://localhost:8080`.
