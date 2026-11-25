# Focus Manager

Personal daily dashboard: ideas, projects and tasks as one kind of item, with subtasks nested as deep as you like. Static page (`index.html`) plus a Supabase database with email/password login. Live at https://joaofsov.github.io/focus-manager/

## Features
- **One kind of item, three states:** idea, active, stalled. Every task and every subtask has its own state pill; click it to cycle. Changing one never changes another.
- **Nested subtasks** (up to 6 levels). Click a task or subtask to open it, see what is inside and type the next one; click again to close. Hold (or double-click) the text, or use the pencil, to edit it.
- **Closing:** a subtask with children is done when all its children are; the main task closes when all its subtasks are. Ticking a parent ticks everything inside it.
- **Counters:** each task shows `done/total` of its direct subtasks (green/red). The four cards on top show the numbers per level (N1 = main tasks, N2 = subtasks, N3 = their subtasks, ...).
- **Containers** (Work, Personal, ...) to group items, with an Inbox for the rest. Edit renames or deletes a container (its items go back to the Inbox).
- **Filters:** Open, Active, Stalled, Ideas, Done. Finished items can be reopened as idea, active or stalled.
- **Voice input** with the microphone button (browser speech recognition, Portuguese).
- Works on phone and desktop; the open/closed state of tasks is remembered per device.

## Files
- `index.html`: the whole app.
- `config.js`: your Supabase URL and anon key.
- `schema.sql`: table `focus_items` (prefixed so other apps can share the same Supabase project), row-level security (each user only sees their own rows) and the grants for the `authenticated` role. Subtasks live in the `subs` JSON column (nested, each with `id`, `t`, `done`, optional `st` and `c`), so no schema change is needed for nesting.
- `migration_containers.sql`: table `focus_containers` and the `container_id` column; run it after `schema.sql`.
- `seed.sql`: optional starter items.

## Setup
1. Create a free project at supabase.com.
2. SQL Editor: run `schema.sql`, then `migration_containers.sql`.
3. Authentication -> Users -> Add user: your email and a strong password.
4. Authentication -> Sign In / Providers: turn off "Allow new users to sign up" (single-user app).
5. Optional: run `seed.sql` to load the starter items.
6. Project Settings -> API: copy the Project URL and the publishable (anon) key into `config.js`.
7. Host the folder on GitHub Pages (Settings -> Pages -> deploy from branch `main`) and open the address from anywhere.

The publishable/anon key is public by design. The protection is the login plus the row-level security policy in `schema.sql`. Never put the `service_role` key in `config.js`.

## Moving the database to a home server later
All database access is in one block of `index.html` (`dbLoad`, `dbAdd`, `dbUpdate`, `dbDelete` and the `dbCont*` functions for containers).
- Supabase is open source and self-hostable (Docker Compose). Dump the cloud database with `pg_dump`, restore it into the self-hosted Postgres, then change the two values in `config.js`. The page code stays as is.
- Reaching it from work needs the server exposed with HTTPS (Cloudflare Tunnel or similar), or a VPN such as Tailscale on the devices you use.
- If a lighter backend is wanted (for example PocketBase), only those functions and the login calls change.
