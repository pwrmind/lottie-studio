-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- Игровой гоночный заезд · Привет сыну!
-- Формат: 540x960 (9:16), 60 FPS, 10.5 секунд
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 10.5;

-- Камера на стартовой линии с крупным зумом на спорткар и светофор
UPDATE camera SET x = 350, y = 470, zoom = 1.45 AT 0.0;

-- ----------------------------------------------------------------------------
-- 1. НОЧНАЯ ТРАССА, СВЕТОФОР, СПОРТКАР И ИГРОВОЙ ИНТЕРФЕЙС (HUD)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  -- Ночное небо и асфальт трассы (ширина 3000px)
  ('sky_bg',      'rect',    1500, 480, 3600, 1800, '#070913', 0,  100),
  ('road',        'rect',    1500, 560, 3600, 140,  '#1e293b', 0,  100),
  ('road_line',   'rect',    1500, 560, 3600, 6,    '#38bdf8', 0,  50),

  -- Стартовый светофор (x = 460)
  ('tl_box',      'rect',    460,  340, 46,   118,  '#0f172a', 12, 100),
  ('tl_red',      'ellipse', 460,  304, 24,   24,   '#334155', 0,  100),
  ('tl_yel',      'ellipse', 460,  340, 24,   24,   '#334155', 0,  100),
  ('tl_grn',      'ellipse', 460,  376, 24,   24,   '#334155', 0,  100),

  -- Чекпоинты на трассе
  ('cp_1',        'rect',    1150, 450, 12,   110,  '#a855f7', 6,  80),
  ('cp_2',        'rect',    1850, 450, 12,   110,  '#38bdf8', 6,  80),

  -- Финишная арка (x = 2500)
  ('finish_post', 'rect',    2500, 440, 18,   160,  '#22c55e', 8,  100),
  ('finish_glow', 'ellipse', 2500, 480, 420,  420,  '#22c55e', 0,  0),

  -- Спорткар (состоит из неонового свечения, кузова, кабины, спойлера и колёс)
  ('car_neon',    'ellipse', 300,  525, 190,  44,   '#38bdf8', 0,  65),
  ('car_spoiler', 'rect',    232,  482, 24,   10,   '#f43f5e', 3,  100),
  ('car_body',    'rect',    300,  502, 156,  34,   '#f43f5e', 12, 100),
  ('car_cabin',   'rect',    292,  482, 82,   24,   '#0f172a', 10, 100),
  ('wheel_b',     'ellipse', 254,  520, 32,   32,   '#090d16', 0,  100),
  ('wheel_f',     'ellipse', 346,  520, 32,   32,   '#090d16', 0,  100),

  -- Игровая финальная карточка в зоне финиша (x = 2500)
  ('win_card',    'rect',    2500, 330, 440,  230,  '#0f172a', 28, 0),
  ('win_badge',   'rect',    2500, 245, 220,  32,   '#22c55e', 16, 0);

-- Тексты старта, чекпоинтов и финальной победы
INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_start',   'text', 'READY...',               350,  240, 28, '#f8fafc', 100),
  ('t_cp1',     'text', 'TURBO x2!',              1150, 375, 22, '#c084fc', 0),
  ('t_cp2',     'text', 'MAX SPEED!',             1850, 375, 22, '#38bdf8', 0),
  ('t_badge',   'text', 'PLAYER 1 · NEW RECORD!', 2500, 250, 13, '#052e16', 0),
  ('t_hi',      'text', 'Привет, чемпион!',       2500, 308, 36, '#f8fafc', 0),
  ('t_sub1',    'text', 'Крутых машин, побед в играх', 2500, 355, 19, '#cbd5e1', 0),
  ('t_sub2',    'text', 'и всегда полный газ!',   2500, 385, 19, '#4ade80', 0);

-- ----------------------------------------------------------------------------
-- 2. АКТ I: СТАРТОВЫЙ СВЕТОФОР (0.0s — 2.2s)
-- ----------------------------------------------------------------------------
UPDATE layers SET color = '#ef4444', scale = 120 WHERE id = 'tl_red' AT 0.4 WITH (duration = 0.2);
UPDATE layers SET scale = 100                    WHERE id = 'tl_red' AT 0.6 WITH (duration = 0.2);

UPDATE layers SET color = '#f59e0b', scale = 120 WHERE id = 'tl_yel' AT 1.1 WITH (duration = 0.2);
UPDATE layers SET scale = 100                    WHERE id = 'tl_yel' AT 1.3 WITH (duration = 0.2);

-- ЗЕЛЁНЫЙ! СТАРТ!
UPDATE layers SET color = '#22c55e', scale = 135 WHERE id = 'tl_grn' AT 1.8 WITH (duration = 0.2);
UPDATE layers SET opacity = 0                    WHERE id = 't_start' AT 1.8 WITH (duration = 0.2);

-- ----------------------------------------------------------------------------
-- 3. АКТ II: РАЗГОН ПО ТРАССЕ И ЧЕКПОИНТЫ (1.9s — 5.6s)
-- ----------------------------------------------------------------------------
-- Камера плавно отъезжает и летит вдоль трассы до финиша (x = 2500)
UPDATE camera SET x = 2500, y = 440, zoom = 1.0 AT 1.9 WITH (duration = 3.6, ease = 'inOut');

-- Спорткар срывается с места и мчится к финишу (x = 2500)
UPDATE layers SET x = 2500 WHERE id = 'car_neon'    AT 1.9 WITH (duration = 3.5, ease = 'in');
UPDATE layers SET x = 2432 WHERE id = 'car_spoiler' AT 1.9 WITH (duration = 3.5, ease = 'in');
UPDATE layers SET x = 2500 WHERE id = 'car_body'    AT 1.9 WITH (duration = 3.5, ease = 'in');
UPDATE layers SET x = 2492 WHERE id = 'car_cabin'   AT 1.9 WITH (duration = 3.5, ease = 'in');
UPDATE layers SET x = 2454 WHERE id = 'wheel_b'     AT 1.9 WITH (duration = 3.5, ease = 'in');
UPDATE layers SET x = 2546 WHERE id = 'wheel_f'     AT 1.9 WITH (duration = 3.5, ease = 'in');

-- Вспышка первого чекпоинта (x = 1150)
UPDATE layers SET opacity = 100, y = 355 WHERE id = 't_cp1' AT 3.4 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET color = '#f43f5e'      WHERE id = 'car_neon' AT 3.4 WITH (duration = 0.3);

-- Вспышка второго чекпоинта (x = 1850)
UPDATE layers SET opacity = 100, y = 355 WHERE id = 't_cp2' AT 4.5 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET color = '#22c55e'      WHERE id = 'car_neon' AT 4.5 WITH (duration = 0.3);

-- ----------------------------------------------------------------------------
-- 4. АКТ III: ФИНИШ И ПРИВЕТСТВИЕ ЧЕМПИОНУ (5.4s — 10.5s)
-- ----------------------------------------------------------------------------
UPDATE layers SET opacity = 28, scale = 115  WHERE id = 'finish_glow' AT 5.4 WITH (duration = 0.7, ease = 'out');
UPDATE layers SET opacity = 100, y = 310     WHERE id = 'win_card'    AT 5.6 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 225     WHERE id = 'win_badge'   AT 5.9 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 230     WHERE id = 't_badge'     AT 5.9 WITH (duration = 0.5, ease = 'out');

UPDATE layers SET opacity = 100, y = 288     WHERE id = 't_hi'        AT 6.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 335     WHERE id = 't_sub1'      AT 6.5 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 365     WHERE id = 't_sub2'      AT 6.7 WITH (duration = 0.5, ease = 'out');

-- Лёгкий наезд камеры на финальную карточку и машину
UPDATE camera SET x = 2500, y = 415, zoom = 1.08 AT 6.4 WITH (duration = 2.5, ease = 'inOut');

-- Плавное завершение цикла
UPDATE layers SET opacity = 0 WHERE id IN ('finish_glow', 'win_card', 'win_badge', 't_badge', 't_hi', 't_sub1', 't_sub2', 'car_neon', 'car_spoiler', 'car_body', 'car_cabin', 'wheel_b', 'wheel_f') AT 9.5 WITH (duration = 0.8, ease = 'in');
