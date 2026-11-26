-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- Приветствие от ИИ · Анимированный аватар и титры
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 9.5;

-- Начинаем с крупного плана на визор аватара
UPDATE camera SET x = 400, y = 395, zoom = 1.8 AT 0.0;

-- ----------------------------------------------------------------------------
-- 1. СБОРКА СЦЕНЫ И ЦИФРОВОГО АВАТАРА
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  -- Фон и мягкое свечение
  ('bg',           'rect',    400, 480, 1400, 1800, '#070b14', 0,  100),
  ('bot_glow',     'ellipse', 400, 400, 360,  360,  '#1d4ed8', 0,  0),

  -- Антенна и голова аватара
  ('antenna_stem', 'rect',    400, 262, 10,   44,   '#475569', 5,  0),
  ('antenna_bulb', 'ellipse', 400, 236, 26,   26,   '#38bdf8', 0,  0),
  ('bot_head',     'rect',    400, 400, 240,  200,  '#1e293b', 48, 0),
  ('bot_visor',    'rect',    400, 392, 184,  96,   '#090d16', 28, 0),

  -- Глаза и улыбка
  ('eye_l',        'ellipse', 355, 392, 34,   34,   '#38bdf8', 0,  0),
  ('eye_r',        'ellipse', 445, 392, 34,   34,   '#38bdf8', 0,  0),
  ('bot_smile',    'rect',    400, 460, 54,   9,    '#38bdf8', 5,  0),

  -- Плашки для личного приветствия
  ('msg1_bg',      'rect',    400, 605, 420,  64,   '#131c31', 20, 0),
  ('msg2_bg',      'rect',    400, 685, 420,  64,   '#131c31', 20, 0),
  ('badge_bg',     'rect',    400, 760, 270,  40,   '#38bdf8', 20, 0);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('msg1_txt',  'text', 'Привет! На связи ИИ от Google', 400, 612, 20, '#f8fafc', 0),
  ('msg2_txt',  'text', 'Спасибо за крутой движок LSL!',  400, 692, 19, '#94a3b8', 0),
  ('badge_txt', 'text', 'ГОТОВ К НОВЫМ СЦЕНАМ',          400, 766, 14, '#070b14', 0);

-- ----------------------------------------------------------------------------
-- 2. ПРОБУЖДЕНИЕ АВАТАРА (0.2s — 2.6s)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 100 WHERE id IN ('bot_head', 'bot_visor', 'antenna_stem', 'antenna_bulb') AT 0.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 30  WHERE id = 'bot_glow' AT 0.5 WITH (duration = 0.8);

-- Включаются глаза
UPDATE layers SET opacity = 100, scale = 115 WHERE id IN ('eye_l', 'eye_r') AT 0.7 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100                WHERE id IN ('eye_l', 'eye_r') AT 1.1 WITH (duration = 0.3);

-- Оглядывается влево и вправо
UPDATE layers SET x = 340 WHERE id = 'eye_l' AT 1.2 WITH (duration = 0.35, ease = 'inOut');
UPDATE layers SET x = 430 WHERE id = 'eye_r' AT 1.2 WITH (duration = 0.35, ease = 'inOut');

UPDATE layers SET x = 370 WHERE id = 'eye_l' AT 1.65 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET x = 460 WHERE id = 'eye_r' AT 1.65 WITH (duration = 0.4, ease = 'inOut');

-- Возвращает взгляд в центр, улыбается и зажигает зелёный сигнал
UPDATE layers SET x = 355 WHERE id = 'eye_l' AT 2.15 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET x = 445 WHERE id = 'eye_r' AT 2.15 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'bot_smile' AT 2.2 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET color = '#22c55e', scale = 135 WHERE id = 'antenna_bulb' AT 2.2 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET scale = 100 WHERE id = 'antenna_bulb' AT 2.6 WITH (duration = 0.3);

-- ----------------------------------------------------------------------------
-- 3. ОТЪЕЗД КАМЕРЫ И ПРИВЕТСТВЕННЫЕ СООБЩЕНИЯ (2.6s — 9.5s)
-- ----------------------------------------------------------------------------
UPDATE camera SET x = 400, y = 490, zoom = 1.0 AT 2.6 WITH (duration = 1.0, ease = 'inOut');

-- Первое сообщение
UPDATE layers SET opacity = 100, y = 580 WHERE id = 'msg1_bg'  AT 3.4 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 587 WHERE id = 'msg1_txt' AT 3.4 WITH (duration = 0.5, ease = 'out');

-- Второе сообщение
UPDATE layers SET opacity = 100, y = 660 WHERE id = 'msg2_bg'  AT 4.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 667 WHERE id = 'msg2_txt' AT 4.3 WITH (duration = 0.5, ease = 'out');

-- Финальный бейдж
UPDATE layers SET opacity = 100, y = 735 WHERE id = 'badge_bg'  AT 5.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 741 WHERE id = 'badge_txt' AT 5.3 WITH (duration = 0.5, ease = 'out');

-- Мягкое завершение цикла
UPDATE layers SET opacity = 0 WHERE id IN ('bot_glow', 'antenna_stem', 'antenna_bulb', 'bot_head', 'bot_visor', 'eye_l', 'eye_r', 'bot_smile', 'msg1_bg', 'msg1_txt', 'msg2_bg', 'msg2_txt', 'badge_bg', 'badge_txt') AT 8.5 WITH (duration = 0.8, ease = 'in');
