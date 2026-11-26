-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- Тёплое приветствие для мамы · Светлая цветочная открытка
-- Формат: 540x960 (9:16), 60 FPS, 10.0 секунд
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 10.0;

-- Начинаем с крупного плана на бутон главного цветка
UPDATE camera SET x = 400, y = 370, zoom = 1.65 AT 0.0;

-- ----------------------------------------------------------------------------
-- 1. СВЕТЛЫЙ ФОН, СТЕБЛИ, ЛИСТЬЯ, ЛЕПЕСТКИ И ОТКРЫТКА
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  -- Тёплый кремово-солнечный фон и мягкое сияние
  ('bg',           'rect',    400, 480, 1400, 1800, '#fffbeb', 0,   100),
  ('sun_glow',     'ellipse', 400, 360, 420,  420,  '#fde68a', 0,   0),

  -- Стебель и зелёные листочки главного цветка
  ('stem_main',    'rect',    400, 465, 10,   170,  '#22c55e', 5,   0),
  ('leaf_l',       'ellipse', 368, 475, 56,   26,   '#4ade80', 0,   0),
  ('leaf_r',       'ellipse', 432, 455, 56,   26,   '#16a34a', 0,   0),

  -- 6 нежных розово-коралловых лепестков вокруг центра (x = 400, y = 360)
  ('petal_top',    'ellipse', 400, 312, 54,   74,   '#fb7185', 0,   0),
  ('petal_bot',    'ellipse', 400, 408, 54,   74,   '#fb7185', 0,   0),
  ('petal_tl',     'ellipse', 358, 336, 68,   54,   '#f43f5e', 0,   0),
  ('petal_tr',     'ellipse', 442, 336, 68,   54,   '#f43f5e', 0,   0),
  ('petal_bl',     'ellipse', 358, 384, 68,   54,   '#fda4af', 0,   0),
  ('petal_br',     'ellipse', 442, 384, 68,   54,   '#fda4af', 0,   0),

  -- Солнечная сердцевина цветка
  ('flower_core',  'ellipse', 400, 360, 52,   52,   '#f59e0b', 0,   0),

  -- Маленькие боковые цветочки-акценты
  ('mini_fl_l',    'ellipse', 255, 420, 34,   34,   '#f472b6', 0,   0),
  ('mini_core_l',  'ellipse', 255, 420, 14,   14,   '#fbbf24', 0,   0),
  ('mini_fl_r',    'ellipse', 545, 410, 38,   38,   '#fb923c', 0,   0),
  ('mini_core_r',  'ellipse', 545, 410, 16,   16,   '#fef08a', 0,   0),

  -- Светлая праздничная карточка с нежной тенью
  ('card_shadow',  'rect',    400, 688, 444,  230,  '#fde68a', 32,  0),
  ('card',         'rect',    400, 680, 440,  230,  '#ffffff', 30,  0),
  ('pill',         'rect',    400, 595, 190,  32,   '#ffe4e6', 16,  0);

-- Тёплые поздравительные надписи
INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_pill',   'text', 'С ЛЮБОВЬЮ И ТЕПЛОМ',       400, 600, 13, '#e11d48', 0),
  ('t_title',  'text', 'Привет, моя любовь!',         400, 665, 36, '#1e293b', 0),
  ('t_msg1',   'text', 'Пусть каждый день дарит',   400, 715, 20, '#475569', 0),
  ('t_msg2',   'text', 'улыбки, солнце и радость!', 400, 745, 20, '#475569', 0);

-- ----------------------------------------------------------------------------
-- 2. АКТ I: РАСКРЫТИЕ ЦВЕТКА (0.2s — 3.0s)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 45, scale = 115  WHERE id = 'sun_glow'    AT 0.2 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET opacity = 100              WHERE id = 'stem_main'   AT 0.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, rotation = -25 WHERE id = 'leaf_l'   AT 0.5 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, rotation = 25  WHERE id = 'leaf_r'   AT 0.6 WITH (duration = 0.5, ease = 'out');

-- Сердцевина и волна раскрытия лепестков
UPDATE layers SET opacity = 100, scale = 120 WHERE id = 'flower_core' AT 0.8 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100                WHERE id = 'flower_core' AT 1.2 WITH (duration = 0.3);

UPDATE layers SET opacity = 100, scale = 108 WHERE id IN ('petal_top', 'petal_bot') AT 1.0 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, scale = 108 WHERE id IN ('petal_tl', 'petal_tr')   AT 1.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, scale = 108 WHERE id IN ('petal_bl', 'petal_br')   AT 1.4 WITH (duration = 0.5, ease = 'out');

-- Лепестки мягко возвращаются в спокойный масштаб
UPDATE layers SET scale = 100 WHERE id IN ('petal_top', 'petal_bot', 'petal_tl', 'petal_tr', 'petal_bl', 'petal_br') AT 1.9 WITH (duration = 0.4, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- 3. АКТ II: ОТЪЕЗД КАМЕРЫ И ПОЯВЛЕНИЕ ОТКРЫТКИ (2.5s — 9.5s)
-- ----------------------------------------------------------------------------
UPDATE camera SET x = 400, y = 500, zoom = 1.0 AT 2.5 WITH (duration = 1.2, ease = 'inOut');

-- Расцветают боковые цветочки
UPDATE layers SET opacity = 100, scale = 115 WHERE id IN ('mini_fl_l', 'mini_core_l') AT 3.0 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, scale = 115 WHERE id IN ('mini_fl_r', 'mini_core_r') AT 3.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET scale = 100 WHERE id IN ('mini_fl_l', 'mini_core_l', 'mini_fl_r', 'mini_core_r') AT 3.6 WITH (duration = 0.3);

-- Всплывает светлая открытка и тёплые слова
UPDATE layers SET opacity = 80,  y = 668 WHERE id = 'card_shadow' AT 3.5 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 660 WHERE id = 'card'        AT 3.5 WITH (duration = 0.6, ease = 'out');

UPDATE layers SET opacity = 100, y = 575 WHERE id = 'pill'        AT 3.9 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 580 WHERE id = 't_pill'      AT 3.9 WITH (duration = 0.5, ease = 'out');

UPDATE layers SET opacity = 100, y = 645 WHERE id = 't_title'     AT 4.2 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 695 WHERE id = 't_msg1'      AT 4.5 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 725 WHERE id = 't_msg2'      AT 4.7 WITH (duration = 0.6, ease = 'out');

-- Нежное покачивание цветка и лёгкий наезд камеры
UPDATE layers SET rotation = 6  WHERE id = 'leaf_r' AT 5.2 WITH (duration = 1.2, ease = 'inOut');
UPDATE layers SET rotation = 25 WHERE id = 'leaf_r' AT 6.4 WITH (duration = 1.2, ease = 'inOut');
UPDATE camera SET x = 400, y = 510, zoom = 1.06     AT 5.0 WITH (duration = 2.5, ease = 'inOut');

-- Мягкое растворение в конце цикла
UPDATE layers SET opacity = 0 WHERE id IN ('sun_glow', 'stem_main', 'leaf_l', 'leaf_r', 'petal_top', 'petal_bot', 'petal_tl', 'petal_tr', 'petal_bl', 'petal_br', 'flower_core', 'mini_fl_l', 'mini_core_l', 'mini_fl_r', 'mini_core_r', 'card_shadow', 'card', 'pill', 't_pill', 't_title', 't_msg1', 't_msg2') AT 8.9 WITH (duration = 0.9, ease = 'in');
