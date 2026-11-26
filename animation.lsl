-- Окно вывода камеры (вертикальный кадр 540x960)
UPDATE composition SET width = 540, height = 960, fps = 60, duration = 9.0;

-- Начальная позиция камеры (смотрит на Сцену 1 в координате x = 350)
UPDATE camera SET x = 350, y = 480, zoom = 1.0 AT 0.0;

-- Наполнение большого виртуального мира (шириной > 2000px)
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('world_bg', 'rect',    1100, 480, 2600, 1400, '#070a14', 0,  100),
  ('zone1',    'rect',    350,  480, 460,  760,  '#131b2e', 32, 100),
  ('zone2',    'rect',    1100, 480, 460,  760,  '#1e1633', 32, 100),
  ('zone3',    'rect',    1850, 480, 460,  760,  '#0f292e', 32, 100),
  ('actor',    'ellipse', 350,  540, 72,   72,   '#38bdf8', 0,  100),
  ('target',   'rect',    1100, 520, 140,  140,  '#a855f7', 24, 100),
  ('finish',   'ellipse', 1850, 520, 110,  110,  '#22c55e', 0,  100);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('lbl1', 'text', 'СЦЕНА 1 · СТАРТ',    350,  220, 24, '#94a3b8', 100),
  ('lbl2', 'text', 'СЦЕНА 2 · НАЕЗД',    1100, 220, 24, '#c084fc', 100),
  ('lbl3', 'text', 'СЦЕНА 3 · КАТ',      1850, 220, 24, '#4ade80', 100);

-- 1. Герой начинает движение из Сцены 1 в Сцену 2, камера плавно ведёт его
UPDATE layers SET x = 1100                         WHERE id = 'actor'  AT 0.8 WITH (duration = 2.4, ease = 'inOut');
UPDATE camera SET x = 1100, y = 480, zoom = 1.0    AT 0.8 WITH (duration = 2.4, ease = 'inOut');

-- 2. Наезд (зум) камеры на объект в Сцене 2 и его вращение
UPDATE camera SET x = 1100, y = 520, zoom = 1.65   AT 3.3 WITH (duration = 0.8, ease = 'out');
UPDATE layers SET rotation = 180, scale = 120      WHERE id = 'target' AT 3.4 WITH (duration = 0.9, ease = 'inOut');

-- 3. Отъезд камеры обратно на общий план
UPDATE camera SET x = 1100, y = 480, zoom = 0.85   AT 4.6 WITH (duration = 0.8, ease = 'inOut');

-- 4. Мгновенный монтажный КАТ (duration = 0) в Сцену 3 + телепорт героя
UPDATE layers SET x = 1850, y = 640, color = '#22c55e' WHERE id = 'actor' AT 5.8;
UPDATE camera SET x = 1850, y = 480, zoom = 1.0        AT 5.8;

-- 5. Финальный плавный наезд на Сцену 3
UPDATE camera SET x = 1850, y = 520, zoom = 1.35   AT 6.2 WITH (duration = 1.5, ease = 'inOut');