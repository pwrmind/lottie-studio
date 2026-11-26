-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- Персональное приветствие для Владислава
-- Формат: 540x960 (9:16), 60 FPS, 10.0 секунд
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 10.0;

-- Камера стартует в левой точке маршрута (x = 300) с крупным зумом
UPDATE camera SET x = 300, y = 480, zoom = 1.4 AT 0.0;

-- ----------------------------------------------------------------------------
-- 1. ДЕКОРАЦИИ И ОБЪЕКТЫ БОЛЬШОГО МИРА (Ширина 2200px)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  -- Глубокий фон
  ('bg',          'rect',    1100, 480, 2600, 1600, '#060a14', 0,   100),

  -- Зона 1 (x = 300): Точка запуска сигнала
  ('radar_outer', 'ellipse', 300,  480, 220,  220,  '#1e293b', 0,   45),
  ('pulse',       'ellipse', 300,  480, 46,   46,   '#f59e0b', 0,   0),

  -- Промежуточные маяки на пути сигнала
  ('beacon_1',    'ellipse', 750,  420, 22,   22,   '#334155', 0,   70),
  ('beacon_2',    'ellipse', 1150, 540, 22,   22,   '#334155', 0,   70),

  -- Зона 2 (x = 1650): Главная сцена приветствия
  ('halo',        'ellipse', 1650, 470, 440,  440,  '#d97706', 0,   0),
  ('card',        'rect',    1650, 510, 450,  310,  '#111827', 34,  0),
  ('accent_bar',  'rect',    1650, 355, 140,  8,    '#f59e0b', 4,   0),
  ('badge',       'rect',    1650, 405, 180,  34,   '#f59e0b', 17,  0),
  ('online_dot',  'ellipse', 1505, 585, 14,   14,   '#22c55e', 0,   0);

-- Текстовые слои
INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_signal', 'text', 'ВХОДЯЩИЙ СИГНАЛ...',      300,  625, 16, '#94a3b8', 0),
  ('t_badge',  'text', 'СПЕЦИАЛЬНЫЙ ВЫПУСК',      1650, 411, 13, '#060a14', 0),
  ('t_hi',     'text', 'Привет, Владислав!',      1650, 475, 36, '#f8fafc', 0),
  ('t_msg',    'text', 'Рад знакомству! Лови салют', 1650, 525, 19, '#cbd5e1', 0),
  ('t_sign',   'text', 'Передано через LSL Studio', 1650, 591, 14, '#4ade80', 0);

-- ----------------------------------------------------------------------------
-- 2. АКТ I: ЗАПУСК И ПОЛЁТ СИГНАЛА (0.0s — 3.4s)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100, scale = 125 WHERE id = 'pulse'    AT 0.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100              WHERE id = 't_signal' AT 0.4 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100                WHERE id = 'pulse'    AT 0.8 WITH (duration = 0.3);

-- Сигнал летит через маяки к главной сцене (x = 1650), камера плавно следует за ним
UPDATE layers SET opacity = 0 WHERE id = 't_signal' AT 1.1 WITH (duration = 0.25);
UPDATE layers SET x = 750,  y = 420 WHERE id = 'pulse' AT 1.2 WITH (duration = 0.7, ease = 'in');
UPDATE layers SET color = '#f59e0b', scale = 140 WHERE id = 'beacon_1' AT 1.85 WITH (duration = 0.25, ease = 'out');

UPDATE layers SET x = 1150, y = 540 WHERE id = 'pulse' AT 1.9 WITH (duration = 0.7, ease = 'linear');
UPDATE layers SET color = '#f59e0b', scale = 140 WHERE id = 'beacon_2' AT 2.55 WITH (duration = 0.25, ease = 'out');

UPDATE layers SET x = 1650, y = 470, width = 70, height = 70 WHERE id = 'pulse' AT 2.6 WITH (duration = 0.8, ease = 'out');
UPDATE camera SET x = 1650, y = 480, zoom = 1.0              AT 1.2 WITH (duration = 2.2, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- 3. АКТ II: ВСПЫШКА И РАСКРЫТИЕ ПРИВЕТСТВИЯ (3.4s — 9.5s)
-- ----------------------------------------------------------------------------
-- Импульс растворяется и зажигает тёплое золотистое свечение вокруг карточки
UPDATE layers SET opacity = 0, scale = 180   WHERE id = 'pulse' AT 3.4 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 22, scale = 115  WHERE id = 'halo'  AT 3.4 WITH (duration = 0.8, ease = 'out');

-- Появление карточки и акцентной полоски
UPDATE layers SET opacity = 100, y = 480 WHERE id = 'card'       AT 3.5 WITH (duration = 0.7, ease = 'out');
UPDATE layers SET opacity = 100, y = 335 WHERE id = 'accent_bar' AT 3.8 WITH (duration = 0.5, ease = 'out');

-- Бейдж и главное имя
UPDATE layers SET opacity = 100, y = 385 WHERE id = 'badge'   AT 4.0 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 391 WHERE id = 't_badge' AT 4.0 WITH (duration = 0.5, ease = 'out');

UPDATE layers SET opacity = 100, y = 455 WHERE id = 't_hi'    AT 4.3 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 505 WHERE id = 't_msg'   AT 4.6 WITH (duration = 0.6, ease = 'out');

-- Лёгкий акцентный наезд камеры на приветствие
UPDATE camera SET x = 1650, y = 480, zoom = 1.12 AT 4.4 WITH (duration = 2.2, ease = 'inOut');

-- Подпись внизу карточки
UPDATE layers SET opacity = 100 WHERE id IN ('online_dot', 't_sign') AT 5.2 WITH (duration = 0.5, ease = 'out');

-- Мягкое затухание в конце
UPDATE layers SET opacity = 0 WHERE id IN ('halo', 'card', 'accent_bar', 'badge', 't_badge', 't_hi', 't_msg', 'online_dot', 't_sign') AT 8.9 WITH (duration = 0.9, ease = 'in');
