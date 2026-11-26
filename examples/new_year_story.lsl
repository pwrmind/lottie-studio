-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- Новогодняя сказка: Дед Мороз, лес, наряженная ёлка, эльфы, звери и салют
-- Формат: 540x960 (9:16), 60 FPS, 12.5 секунд
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 12.5;

-- Камера стартует в левой части зимнего леса, где появляются сани Деда Мороза
UPDATE camera SET x = 350, y = 520, zoom = 1.15 AT 0.0;

-- ----------------------------------------------------------------------------
-- 1. ЗИМНИЙ ЛЕС, СУГРОБЫ, СНЕГОПАД И НАРЯЖЕННАЯ ЁЛКА (Поляна x = 1650)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  -- Ночное зимнее небо, луна и снежные сугробы
  ('night_sky',    'rect',    1100, 480, 2800, 1800, '#070e24', 0,  100),
  ('moon',         'ellipse', 1820, 210, 110,  110,  '#fef08a', 0,  85),
  ('snow_ground',  'rect',    1100, 810, 2800, 340,  '#e2e8f0', 0,  100),
  ('snow_hill',    'ellipse', 1650, 680, 950,  160,  '#f8fafc', 0,  100),

  -- Задний план: силуэты заснеженных елей в лесу
  ('bg_tree_1',    'ellipse', 260,  560, 130,  280,  '#0f293a', 0,  100),
  ('bg_tree_2',    'ellipse', 620,  540, 150,  320,  '#13334c', 0,  100),
  ('bg_tree_3',    'ellipse', 980,  570, 120,  250,  '#0f293a', 0,  100),
  ('bg_tree_4',    'ellipse', 1320, 530, 160,  340,  '#13334c', 0,  100),
  ('bg_tree_5',    'ellipse', 2020, 550, 150,  310,  '#0f293a', 0,  100),

  -- Главная наряженная Ёлка на поляне (x = 1650)
  ('tree_trunk',   'rect',    1650, 625, 36,   70,   '#78350f', 6,  100),
  ('tree_tier_1',  'ellipse', 1650, 555, 250,  140,  '#15803d', 0,  100),
  ('tree_tier_2',  'ellipse', 1650, 470, 195,  130,  '#16a34a', 0,  100),
  ('tree_tier_3',  'ellipse', 1650, 390, 135,  115,  '#22c55e', 0,  100),
  ('tree_star',    'ellipse', 1650, 322, 42,   42,   '#facc15', 0,  100),

  -- Мигающие гирлянды и шары на ёлке
  ('garland_1',    'ellipse', 1600, 560, 18,   18,   '#ef4444', 0,  100),
  ('garland_2',    'ellipse', 1650, 575, 18,   18,   '#38bdf8', 0,  100),
  ('garland_3',    'ellipse', 1705, 555, 18,   18,   '#facc15', 0,  100),
  ('garland_4',    'ellipse', 1615, 480, 16,   16,   '#a855f7', 0,  100),
  ('garland_5',    'ellipse', 1685, 485, 16,   16,   '#ef4444', 0,  100),
  ('garland_6',    'ellipse', 1650, 410, 16,   16,   '#38bdf8', 0,  100),

  -- --------------------------------------------------------------------------
  -- 2. ЭЛЬФЫ И ЛЕСНЫЕ ЗВЕРИ У ЁЛКИ (x = 1790 .. 1920)
  -- --------------------------------------------------------------------------
  -- Эльф 1 (в зелёном кафтане и красном колпаке)
  ('elf1_body',    'rect',    1790, 615, 34,   54,   '#16a34a', 12, 100),
  ('elf1_head',    'ellipse', 1790, 575, 30,   30,   '#fed7aa', 0,  100),
  ('elf1_hat',     'ellipse', 1790, 555, 32,   22,   '#ef4444', 0,  100),

  -- Эльф 2 (в синем кафтане и жёлтом колпаке)
  ('elf2_body',    'rect',    1845, 618, 32,   50,   '#2563eb', 12, 100),
  ('elf2_head',    'ellipse', 1845, 580, 28,   28,   '#fed7aa', 0,  100),
  ('elf2_hat',     'ellipse', 1845, 561, 30,   20,   '#facc15', 0,  100),

  -- Зайчик (белый, с длинными ушками)
  ('bunny_body',   'ellipse', 1895, 632, 28,   34,   '#ffffff', 0,  100),
  ('bunny_ear1',   'ellipse', 1890, 605, 8,    24,   '#ffffff', 0,  100),
  ('bunny_ear2',   'ellipse', 1900, 605, 8,    24,   '#fbcfe8', 0,  100),

  -- Лисёнок (рыжий, с пушистым хвостом)
  ('fox_tail',     'ellipse', 1952, 632, 28,   16,   '#fb923c', 0,  100),
  ('fox_body',     'ellipse', 1935, 628, 32,   36,   '#ea580c', 0,  100),
  ('fox_head',     'ellipse', 1932, 606, 26,   24,   '#f97316', 0,  100),

  -- --------------------------------------------------------------------------
  -- 3. САНИ ДЕДА МОРОЗА С МЕШКОМ ПОДАРКОВ (Стартуют на x = 260)
  -- --------------------------------------------------------------------------
  ('sled_runner',  'rect',    260,  646, 190,  8,    '#facc15', 4,  100),
  ('sled_body',    'rect',    260,  622, 170,  42,   '#dc2626', 14, 100),
  ('gift_sack',    'ellipse', 215,  592, 68,   64,   '#b91c1c', 0,  100),
  ('gift_box1',    'rect',    200,  575, 26,   26,   '#38bdf8', 4,  100),
  ('gift_box2',    'rect',    230,  580, 24,   24,   '#facc15', 4,  100),

  -- Дед Мороз в санях
  ('santa_coat',   'rect',    290,  588, 52,   54,   '#ef4444', 18, 100),
  ('santa_head',   'ellipse', 292,  550, 34,   34,   '#fed7aa', 0,  100),
  ('santa_beard',  'ellipse', 298,  564, 34,   26,   '#ffffff', 0,  100),
  ('santa_hat',    'ellipse', 288,  532, 36,   22,   '#dc2626', 0,  100),
  ('santa_pom',    'ellipse', 270,  534, 12,   12,   '#ffffff', 0,  100),

  -- --------------------------------------------------------------------------
  -- 4. ПАДАЮЩИЕ СНЕЖИНКИ, ФЕЙЕРВЕРК И ХЛОПУШКА С ПОЗДРАВЛЕНИЕМ
  -- --------------------------------------------------------------------------
  ('snow_1',       'ellipse', 320,  120, 12,   12,   '#ffffff', 0,  80),
  ('snow_2',       'ellipse', 780,  80,  14,   14,   '#ffffff', 0,  80),
  ('snow_3',       'ellipse', 1240, 140, 12,   12,   '#ffffff', 0,  80),
  ('snow_4',       'ellipse', 1580, 90,  14,   14,   '#ffffff', 0,  80),
  ('snow_5',       'ellipse', 1820, 130, 12,   12,   '#ffffff', 0,  80),

  -- Залпы фейерверка в ночном небе над ёлкой
  ('fw_1',         'ellipse', 1520, 230, 24,   24,   '#f43f5e', 0,  0),
  ('fw_2',         'ellipse', 1780, 210, 24,   24,   '#38bdf8', 0,  0),
  ('fw_3',         'ellipse', 1650, 170, 28,   28,   '#facc15', 0,  0),

  -- Хлопушка и финальная праздничная открытка
  ('popper_body',  'rect',    1510, 310, 28,   48,   '#f59e0b', 8,  0),
  ('conf_1',       'ellipse', 1560, 260, 16,   16,   '#ef4444', 0,  0),
  ('conf_2',       'ellipse', 1620, 230, 16,   16,   '#22c55e', 0,  0),
  ('conf_3',       'ellipse', 1710, 240, 16,   16,   '#38bdf8', 0,  0),
  ('conf_4',       'ellipse', 1770, 275, 16,   16,   '#a855f7', 0,  0),

  ('final_card',   'rect',    1680, 260, 450,  175,  '#0f172a', 26, 0),
  ('final_pill',   'rect',    1680, 185, 210,  30,   '#ef4444', 15, 0);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_pill',   'text', 'ВОЛШЕБСТВО НАЧИНАЕТСЯ',   1680, 190, 12, '#ffffff', 0),
  ('t_ny1',    'text', 'С Новым Годом!',          1680, 245, 38, '#facc15', 0),
  ('t_ny2',    'text', 'Счастья, чудес и подарков!', 1680, 295, 20, '#f8fafc', 0);

-- ----------------------------------------------------------------------------
-- 5. АКТ I: ПОЕЗДКА ДЕДА МОРОЗА ЧЕРЕЗ ЗИМНИЙ ЛЕС К ЁЛКЕ (0.3s — 5.2s)
-- ----------------------------------------------------------------------------
-- Падает снег на протяжении всей сцены
UPDATE layers SET y = 760 WHERE id IN ('snow_1', 'snow_3', 'snow_5') AT 0.0 WITH (duration = 11.5, ease = 'linear');
UPDATE layers SET y = 780 WHERE id IN ('snow_2', 'snow_4')           AT 0.0 WITH (duration = 11.5, ease = 'linear');

-- Камера плавно отъезжает и сопровождает сани от x = 350 до поляны x = 1680
UPDATE camera SET x = 1680, y = 470, zoom = 0.96 AT 0.4 WITH (duration = 4.8, ease = 'inOut');

-- Сани Деда Мороза едут по лесной дороге и останавливаются слева от ёлки (x = 1480)
UPDATE layers SET x = 1480 WHERE id = 'sled_runner' AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1480 WHERE id = 'sled_body'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1435 WHERE id = 'gift_sack'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1420 WHERE id = 'gift_box1'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1450 WHERE id = 'gift_box2'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1510 WHERE id = 'santa_coat'  AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1512 WHERE id = 'santa_head'  AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1518 WHERE id = 'santa_beard' AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1508 WHERE id = 'santa_hat'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');
UPDATE layers SET x = 1490 WHERE id = 'santa_pom'   AT 0.4 WITH (duration = 4.6, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- 6. АКТ II: ВСТРЕЧА У ЁЛКИ, МИГАЮЩИЕ ГИРЛЯНДЫ И РАДОСТЬ ЗВЕРЕЙ (5.0s — 7.2s)
-- ----------------------------------------------------------------------------
-- Эльфы и зверята радостно подпрыгивают при появлении Деда Мороза
UPDATE layers SET y = 595 WHERE id = 'elf1_body'  AT 5.0 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET y = 555 WHERE id = 'elf1_head'  AT 5.0 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET y = 535 WHERE id = 'elf1_hat'   AT 5.0 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET y = 615 WHERE id = 'elf1_body'  AT 5.25 WITH (duration = 0.25, ease = 'in');
UPDATE layers SET y = 575 WHERE id = 'elf1_head'  AT 5.25 WITH (duration = 0.25, ease = 'in');
UPDATE layers SET y = 555 WHERE id = 'elf1_hat'   AT 5.25 WITH (duration = 0.25, ease = 'in');

UPDATE layers SET y = 608 WHERE id = 'bunny_body' AT 5.2 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET y = 581 WHERE id IN ('bunny_ear1', 'bunny_ear2') AT 5.2 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET y = 632 WHERE id = 'bunny_body' AT 5.45 WITH (duration = 0.25, ease = 'in');
UPDATE layers SET y = 605 WHERE id IN ('bunny_ear1', 'bunny_ear2') AT 5.45 WITH (duration = 0.25, ease = 'in');

-- Мигание гирлянд и звезды на ёлке (волна переключения цветов и масштаба)
UPDATE layers SET scale = 145, color = '#ffffff' WHERE id = 'tree_star' AT 5.2 WITH (duration = 0.3);
UPDATE layers SET scale = 100, color = '#facc15' WHERE id = 'tree_star' AT 5.6 WITH (duration = 0.3);
UPDATE layers SET scale = 145, color = '#ffffff' WHERE id = 'tree_star' AT 6.2 WITH (duration = 0.3);
UPDATE layers SET scale = 100, color = '#facc15' WHERE id = 'tree_star' AT 6.6 WITH (duration = 0.3);
UPDATE layers SET scale = 150, color = '#facc15' WHERE id IN ('garland_1', 'garland_4', 'garland_6') AT 5.3 WITH (duration = 0.35);
UPDATE layers SET scale = 100, color = '#ef4444' WHERE id IN ('garland_1', 'garland_4', 'garland_6') AT 5.8 WITH (duration = 0.35);
UPDATE layers SET scale = 150, color = '#22c55e' WHERE id IN ('garland_2', 'garland_3', 'garland_5') AT 5.8 WITH (duration = 0.35);
UPDATE layers SET scale = 100, color = '#38bdf8' WHERE id IN ('garland_2', 'garland_3', 'garland_5') AT 6.3 WITH (duration = 0.35);
-- 7. АКТ III: ФЕЙЕРВЕРК, ХЛОПУШКА И ПОЗДРАВЛЕНИЕ (6.4s — 12.5s)
-- Залпы салюта в небе (расширяются и растворяются)
UPDATE layers SET opacity = 100, scale = 420 WHERE id = 'fw_1' AT 6.4 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 0,   scale = 520 WHERE id = 'fw_1' AT 7.0 WITH (duration = 0.4);
UPDATE layers SET opacity = 100, scale = 450 WHERE id = 'fw_2' AT 6.8 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 0,   scale = 550 WHERE id = 'fw_2' AT 7.4 WITH (duration = 0.4);
UPDATE layers SET opacity = 100, scale = 500 WHERE id = 'fw_3' AT 7.2 WITH (duration = 0.7, ease = 'out');
UPDATE layers SET opacity = 0,   scale = 620 WHERE id = 'fw_3' AT 7.9 WITH (duration = 0.4);
-- Хлопушка выстреливает конфетти и открывает поздравительную карточку!
UPDATE layers SET opacity = 100, rotation = -35 WHERE id = 'popper_body' AT 7.5 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100, scale = 140   WHERE id IN ('conf_1', 'conf_2', 'conf_3', 'conf_4') AT 7.6 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET y = 340, opacity = 0         WHERE id IN ('conf_1', 'conf_2', 'conf_3', 'conf_4') AT 8.4 WITH (duration = 0.8, ease = 'in');
UPDATE layers SET opacity = 95,  y = 240 WHERE id = 'final_card' AT 7.8 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 100, y = 165 WHERE id = 'final_pill' AT 8.1 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 170 WHERE id = 't_pill'     AT 8.1 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 225 WHERE id = 't_ny1'      AT 8.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 275 WHERE id = 't_ny2'      AT 8.5 WITH (duration = 0.5, ease = 'out');
-- Лёгкий финальный наезд камеры на общую праздничную картину
UPDATE camera SET x = 1680, y = 440, zoom = 1.02 AT 8.2 WITH (duration = 2.5, ease = 'inOut');
-- Мягкое затухание финальной открытки перед новым циклом
UPDATE layers SET opacity = 0 WHERE id IN ('popper_body', 'final_card', 'final_pill', 't_pill', 't_ny1', 't_ny2') AT 11.5 WITH (duration = 0.8, ease = 'in');
