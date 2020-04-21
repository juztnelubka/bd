use paladins;

create or replace view profile_page as
select u.nickname, u.id,  p.created_at, p.photo_id
from users as u
join profiles as p on u.id = p.user_id
;
-- select * from profile_page where id = insert id




create or replace view last_10_games as
select u.match_id, c.name as champion, u.kills, u.deaths, u.assists, m.game_type_id, m.duration, u.team, u.user_id,
if(m.blue_win = u.team, 'win', 'lose') as result
from matches m, users_matches u
left join champions c on u.champion_id = c.id
where u.match_id = m.id;
-- select * from last_10_games when user_id = insert id
