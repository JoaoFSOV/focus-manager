-- Optional. Run after you created your user (Authentication -> Users -> Add user).
-- Loads the items that were in the Claude-hosted version.
insert into public.items (user_id, title, status, next, created_at)
select u.id, v.title, v.status, v.next, now() - (v.n || ' minutes')::interval
from (select id from auth.users order by created_at limit 1) u,
(values
  (1, 'Food truck / van', 'active', ''),
  (2, 'Naval MMO game', 'active', ''),
  (3, 'Jarvis personal assistant', 'active', ''),
  (4, 'Finance manager skill', 'active', 'Excel template first, then the skill'),
  (5, 'Skill: health and training', 'idea', ''),
  (6, 'Skill: food (cut fast food and sweets)', 'idea', ''),
  (7, 'Skill: career (Azure designer/architect)', 'idea', ''),
  (8, 'Skill: purchases and moves', 'idea', '')
) as v(n, title, status, next);
