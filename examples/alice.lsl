-- ============================================================
-- Моя первая приветственная анимация
-- Холст 9:16 — под Shorts / Reels, 60 fps
-- ============================================================
UPDATE composition SET width = 540, height = 960, fps = 60, duration = 6.0;

-- Сцена: фон, тёплое свечение, аватар с ореолом
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('bg',     'rect',    270, 480, 540, 960, '#0d1224', 0, 100, 100),
  ('glow',   'ellipse', 270, 430, 400, 400, '#7c3aed', 0, 25,  100),
  ('halo',   'ellipse', 270, 430, 230, 230, '#38bdf8', 0, 0,   100),
  ('avatar', 'ellipse', 270, 430, 150, 150, '#38bdf8', 0, 0,   0);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('monogram', 'text', 'AI',                       270, 450, 56, '#0d1224', 0),
  ('greet',    'text', 'Привет!',                  270, 620, 44, '#f8fafc', 0),
  ('sub',      'text', 'Я — Алиса, ваш ассистент', 270, 675, 20, '#94a3b8', 0);

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('bar', 'rect',    270, 712, 120, 6,  '#22c55e', 3, 0, 0),
  ('d1',  'ellipse', 190, 250, 14, 14, '#f59e0b', 0, 0, 100),
  ('d2',  'ellipse', 355, 285, 10, 10, '#38bdf8', 0, 0, 100),
  ('d3',  'ellipse', 165, 645, 10, 10, '#f43f5e', 0, 0, 100),
  ('d4',  'ellipse', 385, 615, 14, 14, '#22c55e', 0, 0, 100);

-- Аватар выпрыгивает с лёгким перелётом
UPDATE layers SET opacity = 100, scale = 112 WHERE id = 'avatar' AT 0.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET scale = 100 WHERE id = 'avatar' AT 0.7 WITH (duration = 0.25, ease = 'inOut');

-- Ореол раскрывается следом
UPDATE layers SET opacity = 50, scale = 118 WHERE id = 'halo' AT 0.35 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET scale = 100 WHERE id = 'halo' AT 0.95 WITH (duration = 0.2, ease = 'inOut');

-- Монограмма въезжает внутрь круга
UPDATE layers SET opacity = 100, scale = 112 WHERE id = 'monogram' AT 0.55 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100 WHERE id = 'monogram' AT 0.95 WITH (duration = 0.2, ease = 'inOut');

-- Свечение «дышит» всё время (последний вдох успевает до затухания)
UPDATE layers SET scale = 135, opacity = 45 WHERE id = 'glow' AT 0.5 WITH (duration = 1.2, ease = 'inOut');
UPDATE layers SET scale = 100, opacity = 25 WHERE id = 'glow' AT 1.7 WITH (duration = 1.2, ease = 'inOut');
UPDATE layers SET scale = 135, opacity = 45 WHERE id = 'glow' AT 2.9 WITH (duration = 1.2, ease = 'inOut');
UPDATE layers SET scale = 100, opacity = 25 WHERE id = 'glow' AT 4.1 WITH (duration = 0.5, ease = 'inOut');

-- Приветствие выезжает, полоска растёт из центра
UPDATE layers SET opacity = 100, y = 605 WHERE id = 'greet' AT 0.8 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'sub' AT 1.1 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id = 'bar' AT 1.3 WITH (duration = 0.5, ease = 'out');

-- Точки-акценты появляются по очереди
UPDATE layers SET opacity = 100 WHERE id = 'd1' AT 1.4 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'd2' AT 1.6 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'd3' AT 1.8 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'd4' AT 2.0 WITH (duration = 0.4, ease = 'out');

-- Лёгкое покачивание аватара и дрейф точки
UPDATE layers SET y = 424 WHERE id = 'avatar' AT 2.5 WITH (duration = 1.0, ease = 'inOut');
UPDATE layers SET y = 430 WHERE id = 'avatar' AT 3.5 WITH (duration = 1.0, ease = 'inOut');
UPDATE layers SET y = 444 WHERE id = 'monogram' AT 2.5 WITH (duration = 1.0, ease = 'inOut');
UPDATE layers SET y = 450 WHERE id = 'monogram' AT 3.5 WITH (duration = 1.0, ease = 'inOut');
UPDATE layers SET x = 368, y = 268 WHERE id = 'd2' AT 2.3 WITH (duration = 1.6, ease = 'inOut');

-- Плавное затухание в конце (bg не трогаем — холст остаётся тёмным)
UPDATE layers SET opacity = 0 WHERE id IN ('glow','halo','avatar','monogram','greet','sub','bar','d1','d2','d3','d4') AT 4.8 WITH (duration = 0.9, ease = 'in');
