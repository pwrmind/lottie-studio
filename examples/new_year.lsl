-- ============================================================================
-- LSL: «Зимняя сказка» — новогодняя открытка с ёлкой
-- 540x960 (9:16) · 60 FPS · 10.0 c
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 10.0;

-- Камера: крупный план звезды на макушке, затем плавный отъезд на всю сцену
UPDATE camera SET x = 270, y = 382, zoom = 1.7 AT 0.0;
UPDATE camera SET x = 270, y = 500, zoom = 1.0 AT 2.2 WITH (duration = 1.6, ease = 'inOut');
UPDATE camera SET x = 270, y = 515, zoom = 1.06 AT 6.0 WITH (duration = 2.2, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- 1. НОЧНОЕ НЕБО, ЛУНА, ЗВЁЗДЫ И СНЕГ ПОД НОГАМИ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('bg',        'rect',    270, 480, 1400, 1800, '#0a1128', 0, 100),
  ('moon_glow', 'ellipse', 450, 150, 150,  150,  '#fde68a', 0, 0),
  ('moon',      'ellipse', 450, 150, 74,   74,   '#fef9c3', 0, 0),
  ('star1',     'ellipse', 90,  110, 5,    5,    '#f8fafc', 0, 0),
  ('star2',     'ellipse', 200, 60,  4,    4,    '#f8fafc', 0, 0),
  ('star3',     'ellipse', 350, 90,  5,    5,    '#f8fafc', 0, 0),
  ('star4',     'ellipse', 470, 230, 4,    4,    '#f8fafc', 0, 0),
  ('star5',     'ellipse', 60,  280, 4,    4,    '#f8fafc', 0, 0),
  ('ground',    'ellipse', 270, 990, 800,  240,  '#e2e8f0', 0, 0),
  ('mound',     'ellipse', 270, 835, 330,  60,   '#f1f5f9', 0, 0),
  ('glow',      'ellipse', 270, 470, 480,  480,  '#2563eb', 0, 0);

-- ----------------------------------------------------------------------------
-- 2. ЁЛКА: СТВОЛ, ЧЕТЫРЕ ЯРУСА, ЗВЕЗДА
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('trunk',     'rect',    270, 745, 44,  90,  '#7c2d12', 8, 0, 100),
  ('tier1',     'ellipse', 270, 655, 270, 130, '#166534', 0, 0, 0),
  ('tier2',     'ellipse', 270, 575, 220, 115, '#15803d', 0, 0, 0),
  ('tier3',     'ellipse', 270, 500, 165, 100, '#16a34a', 0, 0, 0),
  ('tier4',     'ellipse', 270, 430, 115, 88,  '#22c55e', 0, 0, 0),
  ('star_glow', 'ellipse', 270, 382, 95,  95,  '#fde68a', 0, 0, 100),
  ('star',      'ellipse', 270, 382, 46,  46,  '#fbbf24', 0, 0, 0);

-- ----------------------------------------------------------------------------
-- 3. ШАРЫ НА ЁЛКЕ И ПОДАРКИ ПОД НЕЙ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('orn1', 'ellipse', 215, 575, 18, 18, '#ef4444', 0, 0, 0),
  ('orn2', 'ellipse', 325, 580, 18, 18, '#fbbf24', 0, 0, 0),
  ('orn3', 'ellipse', 195, 505, 16, 16, '#38bdf8', 0, 0, 0),
  ('orn4', 'ellipse', 340, 510, 16, 16, '#ef4444', 0, 0, 0),
  ('orn5', 'ellipse', 235, 440, 15, 15, '#fbbf24', 0, 0, 0),
  ('orn6', 'ellipse', 305, 448, 15, 15, '#38bdf8', 0, 0, 0),
  ('orn7', 'ellipse', 268, 402, 14, 14, '#f43f5e', 0, 0, 0);

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('gift1',        'rect',    185, 770, 92, 72, '#dc2626', 8, 0, 0),
  ('gift1_ribbon', 'rect',    185, 770, 12, 72, '#fbbf24', 0, 0, 0),
  ('gift1_bow',    'ellipse', 185, 728, 26, 14, '#fbbf24', 0, 0, 0),
  ('gift2',        'rect',    350, 770, 80, 62, '#2563eb', 8, 0, 0),
  ('gift2_ribbon', 'rect',    350, 770, 10, 62, '#f8fafc', 0, 0, 0),
  ('gift2_bow',    'ellipse', 350, 734, 22, 13, '#f8fafc', 0, 0, 0);

-- ----------------------------------------------------------------------------
-- 4. ПОЗДРАВИТЕЛЬНЫЕ НАДПИСИ НА СНЕГУ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_title', 'text', 'С Новым годом!',            270, 920, 38, '#0f172a', 0),
  ('t_msg',   'text', 'и с Рождеством! Пусть 2026-й будет волшебным', 270, 965, 18, '#475569', 0);

-- ----------------------------------------------------------------------------
-- 5. ПАДАЮЩАЯ ЗВЕЗДА И СНЕГ (8 дальних + 2 ближних «боке»)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('shoot', 'ellipse', -30, 200, 26, 10, '#f8fafc', 5, 0);

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s1',  'ellipse', 60,  -40, 10, 10, '#f8fafc', 0, 80),
  ('s2',  'ellipse', 140, -60, 8,  8,  '#f8fafc', 0, 70),
  ('s3',  'ellipse', 230, -30, 12, 12, '#f8fafc', 0, 85),
  ('s4',  'ellipse', 320, -70, 9,  9,  '#f8fafc', 0, 75),
  ('s5',  'ellipse', 410, -45, 11, 11, '#f8fafc', 0, 80),
  ('s6',  'ellipse', 480, -80, 8,  8,  '#f8fafc', 0, 70),
  ('s7',  'ellipse', 100, -50, 14, 14, '#f8fafc', 0, 60),
  ('s8',  'ellipse', 380, -35, 7,  7,  '#f8fafc', 0, 90),
  ('s9',  'ellipse', 90,  -80, 24, 24, '#f8fafc', 0, 25),
  ('s10', 'ellipse', 460, -60, 20, 20, '#f8fafc', 0, 25);

-- ----------------------------------------------------------------------------
-- АКТ I: СЦЕНА ПРОЯВЛЯЕТСЯ (0.0 — 1.2)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100 WHERE id IN ('ground', 'mound') AT 0.15 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 20, scale = 115 WHERE id = 'glow'      AT 0.3 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET opacity = 25  WHERE id = 'moon_glow'             AT 0.4 WITH (duration = 0.8, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'moon'                  AT 0.4 WITH (duration = 0.8, ease = 'out');
UPDATE layers SET opacity = 80  WHERE id = 'star1'                 AT 0.5 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 80  WHERE id = 'star2'                 AT 0.55 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 80  WHERE id = 'star3'                 AT 0.6 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 80  WHERE id = 'star4'                 AT 0.65 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 80  WHERE id = 'star5'                 AT 0.7 WITH (duration = 0.4, ease = 'out');

-- ----------------------------------------------------------------------------
-- АКТ II: ЁЛКА СОБИРАЕТСЯ ЯРУС ЗА ЯРУСОМ (0.6 — 1.6)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100 WHERE id = 'trunk' AT 0.6 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id = 'tier1' AT 0.6 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id = 'tier2' AT 0.8 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id = 'tier3' AT 1.0 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id = 'tier4' AT 1.2 WITH (duration = 0.4, ease = 'out');

-- ----------------------------------------------------------------------------
-- АКТ III: ЗВЕЗДА ЗАГОРАЕТСЯ (1.8 — 2.5)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100, scale = 135 WHERE id = 'star' AT 1.8 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 30                WHERE id = 'star_glow' AT 1.8 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100 WHERE id = 'star' AT 2.2 WITH (duration = 0.3, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- АКТ IV: ШАРЫ И ПОДАРКИ (2.4 — 4.3)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn1' AT 2.4 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn2' AT 2.55 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn3' AT 2.7 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn4' AT 2.85 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn5' AT 3.0 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn6' AT 3.15 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id = 'orn7' AT 3.3 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET scale = 100 WHERE id IN ('orn1', 'orn2', 'orn3', 'orn4', 'orn5', 'orn6', 'orn7') AT 3.4 WITH (duration = 0.3, ease = 'inOut');

UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('gift1', 'gift1_ribbon', 'gift1_bow') AT 3.6 WITH (duration = 0.45, ease = 'out');
UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('gift2', 'gift2_ribbon', 'gift2_bow') AT 3.85 WITH (duration = 0.45, ease = 'out');

-- ----------------------------------------------------------------------------
-- АКТ V: ПОЗДРАВЛЕНИЕ, ПУЛЬС СВЕЧЕНИЯ, ПАДАЮЩАЯ ЗВЕЗДА (4.2 — 5.9)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100, y = 900 WHERE id = 't_title' AT 4.2 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 945 WHERE id = 't_msg'   AT 4.6 WITH (duration = 0.6, ease = 'out');

UPDATE layers SET scale = 118, opacity = 32 WHERE id = 'glow' AT 4.5 WITH (duration = 1.4, ease = 'inOut');
UPDATE layers SET scale = 100, opacity = 20 WHERE id = 'glow' AT 5.9 WITH (duration = 1.4, ease = 'inOut');

UPDATE layers SET scale = 130, opacity = 45 WHERE id = 'star_glow' AT 5.0 WITH (duration = 0.5, ease = 'inOut');
UPDATE layers SET scale = 100, opacity = 30 WHERE id = 'star_glow' AT 6.2 WITH (duration = 0.5, ease = 'inOut');
UPDATE layers SET scale = 130, opacity = 45 WHERE id = 'star_glow' AT 7.2 WITH (duration = 0.5, ease = 'inOut');

UPDATE layers SET opacity = 100 WHERE id = 'shoot' AT 5.2 WITH (duration = 0.15, ease = 'out');
UPDATE layers SET x = 590, y = 300 WHERE id = 'shoot' AT 5.2 WITH (duration = 0.7, ease = 'out');
UPDATE layers SET opacity = 0 WHERE id = 'shoot' AT 5.75 WITH (duration = 0.2, ease = 'in');

-- ----------------------------------------------------------------------------
-- АКТ VI: СНЕГ ИДЁТ ВСЁ ВРЕМЯ (с 0.0)
-- ----------------------------------------------------------------------------
UPDATE layers SET y = 1060 WHERE id = 's1'  AT 0.0 WITH (duration = 10.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's2'  AT 0.0 WITH (duration = 9.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's3'  AT 0.0 WITH (duration = 11.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's4'  AT 0.0 WITH (duration = 9.5, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's5'  AT 0.0 WITH (duration = 10.5, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's6'  AT 0.0 WITH (duration = 8.5, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's7'  AT 0.0 WITH (duration = 12.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's8'  AT 0.0 WITH (duration = 8.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's9'  AT 0.0 WITH (duration = 7.0, ease = 'linear');
UPDATE layers SET y = 1060 WHERE id = 's10' AT 0.0 WITH (duration = 8.5, ease = 'linear');

UPDATE layers SET x = 270 WHERE id = 's3' AT 2.0 WITH (duration = 4.0, ease = 'inOut');
UPDATE layers SET x = 440 WHERE id = 's6' AT 3.0 WITH (duration = 4.0, ease = 'inOut');

UPDATE layers SET opacity = 40 WHERE id = 'star1' AT 3.0 WITH (duration = 0.3, ease = 'inOut');
UPDATE layers SET opacity = 80 WHERE id = 'star1' AT 3.6 WITH (duration = 0.3, ease = 'inOut');
UPDATE layers SET opacity = 40 WHERE id = 'star3' AT 3.3 WITH (duration = 0.3, ease = 'inOut');
UPDATE layers SET opacity = 80 WHERE id = 'star3' AT 3.9 WITH (duration = 0.3, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- ФИНАЛ: МЯГКОЕ РАСТВОРЕНИЕ (9.0 — 9.9), ФОН ОСТАЁТСЯ
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 0 WHERE id IN ('moon_glow', 'moon', 'star1', 'star2', 'star3', 'star4', 'star5', 'ground', 'mound', 'glow', 'trunk', 'tier1', 'tier2', 'tier3', 'tier4', 'star', 'star_glow', 'orn1', 'orn2', 'orn3', 'orn4', 'orn5', 'orn6', 'orn7', 'gift1', 'gift1_ribbon', 'gift1_bow', 'gift2', 'gift2_ribbon', 'gift2_bow', 't_title', 't_msg', 's1', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9', 's10') AT 9.0 WITH (duration = 0.9, ease = 'in');
