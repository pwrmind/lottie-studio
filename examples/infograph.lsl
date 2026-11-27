-- ============================================================================
-- 📊 ИНФОГРАФИКА: «Сколько резюме приходится на одну вакансию» (hh.индекс)
-- Сцена 1 (x=270): График по сферам + крупный проезд камеры сверху вниз
-- Сцена 2 (x=1120): Динамика по РФ, шкала hh.индекса и вывод для бизнеса
--
-- ПАЛИТРА:
--   фон холста   #F7F5F0 · карточки #EFECE4 · ось #CFCBC2
--   текст        #1C1B19 основной · #4A4741 вторичный · #8A867E мета
--   акценты      #D95338 дефицит / IT · #B8B4AC норма · #5C7A67 шкала
-- ШРИФТЫ: Montserrat (заголовки и текст) · JetBrains Mono (цифры и индексы)
-- ФОРМАТ: 540x960 (9:16), 60 fps, длительность 28.5 с
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 28.5;

-- Стартовая камера: Сцена 1
UPDATE camera SET x = 270, y = 480, zoom = 1.0 AT 0.0;

-- ============================================================================
-- 1. ОБЩИЙ ХОЛСТ И ШАПКА СЦЕНЫ 1
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
  ('bg',        'rect',    700, 560, 1600, 1400, '#F7F5F0', 0, 100, 100, false),
  ('logo_ring', 'ellipse', 56,  92,  24,   24,   '#9E9A92', 0, 100, 100, false),
  ('logo_hole', 'ellipse', 56,  92,  10,   10,   '#F7F5F0', 0, 100, 100, false),
  ('logo_bar',  'rect',    56,  111, 24,   5,    '#9E9A92', 0, 100, 100, false);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
  ('src_txt',  'text', 'Данные: HeadHunter · октябрь',             'Montserrat',     402, 95,  13, '#8A867E', 0, 100, false),
  ('title_1',  'text', 'Сколько резюме приходится',                'Montserrat',     252, 162, 26, '#1C1B19', 0, 100, false),
  ('title_2',  'text', 'на одну вакансию в сферах',                'Montserrat',     246, 196, 26, '#1C1B19', 0, 100, false),
  ('sub_note', 'text', 'hh.индекс: активные резюме на 1 вакансию', 'JetBrains Mono', 214, 228, 12, '#8A867E', 0, 100, false);

UPDATE layers SET opacity = 100 WHERE id IN ('src_txt', 'title_1', 'title_2', 'sub_note') AT 0.2 WITH (duration = 0.5, ease = 'out');

-- Вертикальная ось отсчёта (x_axis = 266)
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
  ('axis_y', 'rect', 266, 555, 2, 600, '#CFCBC2', 0, 0, 100, false);

UPDATE layers SET opacity = 100 WHERE id = 'axis_y' AT 0.4 WITH (duration = 0.4, ease = 'out');

-- ============================================================================
-- 2. КАТЕГОРИИ, БАРЫ И ЦИФРЫ (Сцена 1)
-- ============================================================================
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
  ('lbl_1',  'text', 'Розничная торговля',        'Montserrat', 175, 276, 14, '#D95338', 0, 100, false),
  ('lbl_2',  'text', 'Рабочий персонал',          'Montserrat', 182, 316, 14, '#3A3834', 0, 100, false),
  ('lbl_3',  'text', 'Медицина, фармацевтика',    'Montserrat', 162, 356, 14, '#3A3834', 0, 100, false),
  ('lbl_4',  'text', 'Строительство',             'Montserrat', 197, 396, 14, '#3A3834', 0, 100, false),
  ('lbl_5',  'text', 'Автомобильный бизнес',      'Montserrat', 169, 436, 14, '#3A3834', 0, 100, false),
  ('lbl_6',  'text', 'Добыча сырья',              'Montserrat', 201, 476, 14, '#3A3834', 0, 100, false),
  ('lbl_7',  'text', 'Спорт, салоны красоты',     'Montserrat', 166, 516, 14, '#3A3834', 0, 100, false),
  ('lbl_8',  'text', 'Финансы, бухгалтерия',      'Montserrat', 169, 556, 14, '#3A3834', 0, 100, false),
  ('lbl_9',  'text', 'Наука, образование',        'Montserrat', 176, 596, 14, '#3A3834', 0, 100, false),
  ('lbl_10', 'text', 'Управление персоналом',     'Montserrat', 163, 636, 14, '#3A3834', 0, 100, false),
  ('lbl_11', 'text', 'Юристы',                    'Montserrat', 225, 676, 14, '#3A3834', 0, 100, false),
  ('lbl_12', 'text', 'Информационные технологии', 'Montserrat', 148, 716, 14, '#D95338', 0, 100, false),
  ('lbl_13', 'text', 'Маркетинг, реклама, PR',    'Montserrat', 163, 756, 14, '#3A3834', 0, 100, false),
  ('lbl_14', 'text', 'Стратегия, консалтинг',     'Montserrat', 169, 796, 14, '#3A3834', 0, 100, false),
  ('lbl_15', 'text', 'Искусство, массмедиа',      'Montserrat', 172, 836, 14, '#3A3834', 0, 100, false);

UPDATE layers SET opacity = 100 WHERE id LIKE 'lbl_%' AT 0.5 WITH (duration = 0.45, ease = 'out');

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
  ('bar_1',  'rect', 267, 272, 2, 16, '#D95338', 2, 100, 100, false),
  ('bar_2',  'rect', 267, 312, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_3',  'rect', 267, 352, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_4',  'rect', 267, 392, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_5',  'rect', 267, 432, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_6',  'rect', 267, 472, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_7',  'rect', 267, 512, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_8',  'rect', 267, 552, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_9',  'rect', 267, 592, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_10', 'rect', 267, 632, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_11', 'rect', 267, 672, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_12', 'rect', 267, 712, 2, 16, '#D95338', 2, 100, 100, false),
  ('bar_13', 'rect', 267, 752, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_14', 'rect', 267, 792, 2, 16, '#B8B4AC', 2, 100, 100, false),
  ('bar_15', 'rect', 267, 832, 2, 16, '#B8B4AC', 2, 100, 100, false);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
  ('val_1',  'text', '0,0', 'JetBrains Mono', 288, 277, 14, '#D95338', 0, 100, false),
  ('val_2',  'text', '0,0', 'JetBrains Mono', 288, 317, 14, '#1C1B19', 0, 100, false),
  ('val_3',  'text', '0,0', 'JetBrains Mono', 288, 357, 14, '#1C1B19', 0, 100, false),
  ('val_4',  'text', '0,0', 'JetBrains Mono', 288, 397, 14, '#1C1B19', 0, 100, false),
  ('val_5',  'text', '0,0', 'JetBrains Mono', 288, 437, 14, '#1C1B19', 0, 100, false),
  ('val_6',  'text', '0,0', 'JetBrains Mono', 288, 477, 14, '#1C1B19', 0, 100, false),
  ('val_7',  'text', '0,0', 'JetBrains Mono', 288, 517, 14, '#1C1B19', 0, 100, false),
  ('val_8',  'text', '0,0', 'JetBrains Mono', 288, 557, 14, '#1C1B19', 0, 100, false),
  ('val_9',  'text', '0,0', 'JetBrains Mono', 288, 597, 14, '#1C1B19', 0, 100, false),
  ('val_10', 'text', '0,0', 'JetBrains Mono', 288, 637, 14, '#1C1B19', 0, 100, false),
  ('val_11', 'text', '0,0', 'JetBrains Mono', 288, 677, 14, '#1C1B19', 0, 100, false),
  ('val_12', 'text', '0,0', 'JetBrains Mono', 288, 717, 14, '#D95338', 0, 100, false),
  ('val_13', 'text', '0,0', 'JetBrains Mono', 288, 757, 14, '#1C1B19', 0, 100, false),
  ('val_14', 'text', '0,0', 'JetBrains Mono', 288, 797, 14, '#1C1B19', 0, 100, false),
  ('val_15', 'text', '0,0', 'JetBrains Mono', 288, 837, 14, '#1C1B19', 0, 100, false);

UPDATE layers SET opacity = 100 WHERE id LIKE 'val_%' AT 0.7 WITH (duration = 0.3, ease = 'out');

-- Наполнение баров и обновление цифр [0.8 — 7.2 с]
UPDATE layers SET width = 10,  x = 271.0 WHERE id = 'bar_1' AT 0.80 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 298.0              WHERE id = 'val_1' AT 0.80 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '0,8'           WHERE id = 'val_1' AT 1.05;
UPDATE layers SET text = '1,7'           WHERE id = 'val_1' AT 1.35;
UPDATE layers SET text = '2,4'           WHERE id = 'val_1' AT 1.70;

UPDATE layers SET width = 17,  x = 274.5 WHERE id = 'bar_2' AT 0.95 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 305.0              WHERE id = 'val_2' AT 0.95 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '1,5'           WHERE id = 'val_2' AT 1.25;
UPDATE layers SET text = '3,2'           WHERE id = 'val_2' AT 1.55;
UPDATE layers SET text = '4,6'           WHERE id = 'val_2' AT 1.85;

UPDATE layers SET width = 20,  x = 276.0 WHERE id = 'bar_3' AT 1.10 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 308.0              WHERE id = 'val_3' AT 1.10 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '1,9'           WHERE id = 'val_3' AT 1.40;
UPDATE layers SET text = '3,8'           WHERE id = 'val_3' AT 1.70;
UPDATE layers SET text = '5,4'           WHERE id = 'val_3' AT 2.00;

UPDATE layers SET width = 22,  x = 277.0 WHERE id = 'bar_4' AT 1.25 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 310.0              WHERE id = 'val_4' AT 1.25 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '2,1'           WHERE id = 'val_4' AT 1.55;
UPDATE layers SET text = '4,1'           WHERE id = 'val_4' AT 1.85;
UPDATE layers SET text = '5,8'           WHERE id = 'val_4' AT 2.15;

UPDATE layers SET width = 26,  x = 279.0 WHERE id = 'bar_5' AT 1.40 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 314.0              WHERE id = 'val_5' AT 1.40 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '2,4'           WHERE id = 'val_5' AT 1.70;
UPDATE layers SET text = '4,9'           WHERE id = 'val_5' AT 2.00;
UPDATE layers SET text = '7,0'           WHERE id = 'val_5' AT 2.30;

UPDATE layers SET width = 32,  x = 282.0 WHERE id = 'bar_6' AT 1.95 WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 320.0              WHERE id = 'val_6' AT 1.95 WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '3,0'           WHERE id = 'val_6' AT 2.25;
UPDATE layers SET text = '6,1'           WHERE id = 'val_6' AT 2.60;
UPDATE layers SET text = '8,5'           WHERE id = 'val_6' AT 2.95;

UPDATE layers SET width = 42,  x = 287.0 WHERE id = 'bar_7' AT 2.15 WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 334.0              WHERE id = 'val_7' AT 2.15 WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '4,2'           WHERE id = 'val_7' AT 2.45;
UPDATE layers SET text = '8,1'           WHERE id = 'val_7' AT 2.80;
UPDATE layers SET text = '11,4'          WHERE id = 'val_7' AT 3.15;
UPDATE layers SET width = 62,  x = 297.0 WHERE id = 'bar_8' AT 2.35 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 354.0              WHERE id = 'val_8' AT 2.35 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '5,8'           WHERE id = 'val_8' AT 2.70;
UPDATE layers SET text = '11,9'          WHERE id = 'val_8' AT 3.10;
UPDATE layers SET text = '16,8'          WHERE id = 'val_8' AT 3.45;
UPDATE layers SET width = 70,  x = 301.0 WHERE id = 'bar_9' AT 2.55 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 362.0              WHERE id = 'val_9' AT 2.55 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '6,4'           WHERE id = 'val_9' AT 2.90;
UPDATE layers SET text = '13,2'          WHERE id = 'val_9' AT 3.30;
UPDATE layers SET text = '18,9'          WHERE id = 'val_9' AT 3.65;
UPDATE layers SET width = 84,  x = 308.0 WHERE id = 'bar_10' AT 2.75 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 376.0              WHERE id = 'val_10' AT 2.75 WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '7,9'           WHERE id = 'val_10' AT 3.10;
UPDATE layers SET text = '16,0'          WHERE id = 'val_10' AT 3.50;
UPDATE layers SET text = '22,6'          WHERE id = 'val_10' AT 3.85;
UPDATE layers SET width = 90,  x = 311.0 WHERE id = 'bar_11' AT 4.00 WITH (duration = 1.3, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 382.0              WHERE id = 'val_11' AT 4.00 WITH (duration = 1.3, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '8,5'           WHERE id = 'val_11' AT 4.35;
UPDATE layers SET text = '17,4'          WHERE id = 'val_11' AT 4.80;
UPDATE layers SET text = '24,4'          WHERE id = 'val_11' AT 5.25;
UPDATE layers SET width = 110, x = 321.0 WHERE id = 'bar_12' AT 4.30 WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 402.0              WHERE id = 'val_12' AT 4.30 WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '9,4'           WHERE id = 'val_12' AT 4.65;
UPDATE layers SET text = '18,6'          WHERE id = 'val_12' AT 5.05;
UPDATE layers SET text = '25,1'          WHERE id = 'val_12' AT 5.45;
UPDATE layers SET text = '29,8'          WHERE id = 'val_12' AT 5.75;
UPDATE layers SET width = 125, x = 328.5 WHERE id = 'bar_13' AT 4.60 WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 417.0              WHERE id = 'val_13' AT 4.60 WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '11,2'          WHERE id = 'val_13' AT 4.95;
UPDATE layers SET text = '22,8'          WHERE id = 'val_13' AT 5.40;
UPDATE layers SET text = '33,7'          WHERE id = 'val_13' AT 6.00;
UPDATE layers SET width = 200, x = 366.0 WHERE id = 'bar_14' AT 5.00 WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 492.0              WHERE id = 'val_14' AT 5.00 WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '14,8'          WHERE id = 'val_14' AT 5.35;
UPDATE layers SET text = '29,5'          WHERE id = 'val_14' AT 5.80;
UPDATE layers SET text = '43,2'          WHERE id = 'val_14' AT 6.25;
UPDATE layers SET text = '54,0'          WHERE id = 'val_14' AT 6.75;
UPDATE layers SET width = 200, x = 366.0 WHERE id = 'bar_15' AT 5.30 WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET x = 492.0              WHERE id = 'val_15' AT 5.30 WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET text = '15,1'          WHERE id = 'val_15' AT 5.65;
UPDATE layers SET text = '30,4'          WHERE id = 'val_15' AT 6.10;
UPDATE layers SET text = '44,6'          WHERE id = 'val_15' AT 6.55;
UPDATE layers SET text = '54,0'          WHERE id = 'val_15' AT 7.05;
-- ============================================================================
-- 3. КРУПНЫЙ ПРОЕЗД КАМЕРЫ СВЕРХУ ВНИЗ ПО ВСЕМ ПОЗИЦИЯМ [7.4 — 16.6 с]
-- ============================================================================
UPDATE camera SET x = 285, y = 276, zoom = 1.48 AT 7.4 WITH (duration = 1.2, ease = 'inOut');
UPDATE camera SET x = 285, y = 836, zoom = 1.48 AT 8.6 WITH (duration = 8.0, ease = 'linear');
-- ============================================================================
-- 4. СЦЕНА 2 (x = 1120): КОНТЕКСТ, ШКАЛА HH.ИНДЕКСА И ВЫВОДЫ [16.8 — 28.5 с]
-- ============================================================================
UPDATE camera SET x = 1120, y = 480, zoom = 1.0 AT 16.8 WITH (duration = 1.4, ease = 'inOut');
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
('s2_tag',   'text', 'Обзор рынка труда · HeadHunter', 'JetBrains Mono', 1120, 118, 13, '#8A867E', 0, 100, false),
('s2_head1', 'text', 'Что стоят за этими',            'Montserrat',     1120, 162, 28, '#1C1B19', 0, 100, false),
('s2_head2', 'text', 'цифрами на рынке',              'Montserrat',     1120, 196, 28, '#1C1B19', 0, 100, false);
UPDATE layers SET opacity = 100 WHERE id IN ('s2_tag', 's2_head1', 's2_head2') AT 18.0 WITH (duration = 0.45, ease = 'out');
-- Карточка 1: Динамика за 2 года и IT
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
('s2_c1_bg', 'rect', 1120, 310, 460, 156, '#EFECE4', 14, 0, 96, false);
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
('s2_c1_t1', 'text', 'В целом по России индекс — 9,0',       'Montserrat',     1120, 264, 17, '#1C1B19', 0, 96, false),
('s2_c1_t2', 'text', 'год назад 7,3  ·  два года назад 3,9', 'JetBrains Mono', 1120, 294, 13, '#5A564E', 0, 96, false),
('s2_c1_t3', 'text', 'Москва: 10,8   ·   Петербург: 11,2',   'JetBrains Mono', 1120, 322, 13, '#5A564E', 0, 96, false),
('s2_c1_t4', 'text', 'В IT за год: вакансий −33%, резюме +12%', 'Montserrat',   1120, 358, 15, '#D95338', 0, 96, false);
UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c1_%' AT 18.4 WITH (duration = 0.5, ease = 'out');
-- Карточка 2: Шкала hh.индекса
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
('s2_c2_bg', 'rect', 1120, 520, 460, 210, '#EFECE4', 14, 0, 96, false);
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
('s2_c2_hd', 'text', 'Шкала конкуренции HeadHunter',     'Montserrat',     1120, 444, 17, '#1C1B19', 0, 96, false),
('s2_sc_1',  'text', 'до 1,9    острый дефицит соискателей', 'JetBrains Mono', 1120, 480, 13, '#D95338', 0, 96, false),
('s2_sc_2',  'text', '2,0–3,9   дефицит (розница, повара)',  'JetBrains Mono', 1120, 508, 13, '#D95338', 0, 96, false),
('s2_sc_3',  'text', '4,0–7,9   умеренная конкуренция',      'JetBrains Mono', 1120, 536, 13, '#4A4741', 0, 96, false),
('s2_sc_4',  'text', '8,0–11,9  высокая конкуренция',        'JetBrains Mono', 1120, 564, 13, '#4A4741', 0, 96, false),
('s2_sc_5',  'text', 'от 12,0   крайне высокая (IT, маркетинг)', 'JetBrains Mono', 1120, 592, 13, '#1C1B19', 0, 96, false);
UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s2_c2_bg', 's2_c2_hd', 's2_sc_1', 's2_sc_2', 's2_sc_3', 's2_sc_4', 's2_sc_5') AT 19.6 WITH (duration = 0.5, ease = 'out');
-- Карточка 3: Вывод
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale, fixed) VALUES
('s2_c3_bg', 'rect', 1120, 725, 460, 146, '#1C1B19', 14, 0, 96, false);
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale, fixed) VALUES
('s2_c3_t1', 'text', 'Продавцов, поваров и электриков\nстоит удерживать — свободных мало.', 'Montserrat', 1120, 692, 15, '#F7F5F0', 0, 96, false),
('s2_c3_t2', 'text', 'В IT, маркетинге и у юристов на место\nдесятки резюме — время уйдёт на отбор.', 'Montserrat', 1120, 752, 15, '#D95338', 0, 96, false);
UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c3_%' AT 21.2 WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);
