# Focus Manager

Personal daily dashboard: ideas, projects and tasks as one kind of item (status: idea, active, stalled), each with subtasks. When every subtask is ticked the parent closes. Static page (`index.html`) plus a Supabase database with email/password login.

## Files
- `index.html`: the whole app.
- `config.js`: your Supabase URL and anon key.
- `schema.sql`: table and row-level security (each user only sees their own rows).
- `seed.sql`: optional starter items.

## Setup
1. Create a free project at supabase.com.
2. SQL Editor: run `schema.sql`.
3. Authentication -> Users -> Add user: your email and a strong password.
4. Authentication -> Sign In / Providers: turn off "Allow new users to sign up" (single-user app).
5. Optional: run `seed.sql` to load the starter items.
6. Project Settings -> API: copy the Project URL and the `anon` public key into `config.js`.
7. Host the folder on GitHub Pages or Netlify (static hosting) and open the address from anywhere.

The anon key is public by design. The protection is the login plus the row-level security policy in `schema.sql`. Never put the `service_role` key in `config.js`.

## Moving the database to a home server later
All database access is in one block of `index.html` (`dbLoad`, `dbAdd`, `dbUpdate`, `dbDelete`).
- Supabase is open source and self-hostable (Docker Compose). Dump the cloud database with `pg_dump`, restore it into the self-hosted Postgres, then change the two values in `config.js`. The page code stays as is.
- Reaching it from work needs the server exposed with HTTPS (Cloudflare Tunnel or similar), or a VPN such as Tailscale on the devices you use.
- If a lighter backend is wanted (for example PocketBase), only those four functions and the login calls change.
