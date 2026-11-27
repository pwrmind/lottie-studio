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
AT 0.0 UPDATE camera SET x = 270, y = 480, zoom = 1.0;

-- ============================================================================
-- 1. ОБЩИЙ ХОЛСТ И ШАПКА СЦЕНЫ 1 (префикс s1_ для массовой очистки DOM)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('bg',           'rect',    false, 700, 560, 1600, 1400, '#F7F5F0', 0, 100, 100),
  ('s1_logo_ring', 'ellipse', false, 56,  92,  24,   24,   '#9E9A92', 0, 100, 100),
  ('s1_logo_hole', 'ellipse', false, 56,  92,  10,   10,   '#F7F5F0', 0, 100, 100),
  ('s1_logo_bar',  'rect',    false, 56,  111, 24,   5,    '#9E9A92', 0, 100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_src_txt',  'text', false, 'Данные: HeadHunter · октябрь',             'Montserrat',     402, 95,  13, '#8A867E', 0, 100),
  ('s1_title_1',  'text', false, 'Сколько резюме приходится',                'Montserrat',     252, 162, 26, '#1C1B19', 0, 100),
  ('s1_title_2',  'text', false, 'на одну вакансию в сферах',                'Montserrat',     246, 196, 26, '#1C1B19', 0, 100),
  ('s1_sub_note', 'text', false, 'hh.индекс: активные резюме на 1 вакансию', 'JetBrains Mono', 214, 228, 12, '#8A867E', 0, 100);

AT 0.2 UPDATE layers SET opacity = 100 WHERE id IN ('s1_src_txt', 's1_title_1', 's1_title_2', 's1_sub_note') WITH (duration = 0.5, ease = 'out');

-- Вертикальная ось отсчёта (x_axis = 266)
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s1_axis_y', 'rect', false, 266, 555, 2, 600, '#CFCBC2', 0, 0, 100);

AT 0.4 UPDATE layers SET opacity = 100 WHERE id = 's1_axis_y' WITH (duration = 0.4, ease = 'out');

-- ============================================================================
-- 2. КАТЕГОРИИ, БАРЫ И ЦИФРЫ (Сцена 1: 45 слоёв)
-- ============================================================================
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('lbl_1',  'text', false, 'Розничная торговля',        'Montserrat', 175, 276, 14, '#D95338', 0, 100),
  ('lbl_2',  'text', false, 'Рабочий персонал',          'Montserrat', 182, 316, 14, '#3A3834', 0, 100),
  ('lbl_3',  'text', false, 'Медицина, фармацевтика',    'Montserrat', 162, 356, 14, '#3A3834', 0, 100),
  ('lbl_4',  'text', false, 'Строительство',             'Montserrat', 197, 396, 14, '#3A3834', 0, 100),
  ('lbl_5',  'text', false, 'Автомобильный бизнес',      'Montserrat', 169, 436, 14, '#3A3834', 0, 100),
  ('lbl_6',  'text', false, 'Добыча сырья',              'Montserrat', 201, 476, 14, '#3A3834', 0, 100),
  ('lbl_7',  'text', false, 'Спорт, салоны красоты',     'Montserrat', 166, 516, 14, '#3A3834', 0, 100),
  ('lbl_8',  'text', false, 'Финансы, бухгалтерия',      'Montserrat', 169, 556, 14, '#3A3834', 0, 100),
  ('lbl_9',  'text', false, 'Наука, образование',        'Montserrat', 176, 596, 14, '#3A3834', 0, 100),
  ('lbl_10', 'text', false, 'Управление персоналом',     'Montserrat', 163, 636, 14, '#3A3834', 0, 100),
  ('lbl_11', 'text', false, 'Юристы',                    'Montserrat', 225, 676, 14, '#3A3834', 0, 100),
  ('lbl_12', 'text', false, 'Информационные технологии', 'Montserrat', 148, 716, 14, '#D95338', 0, 100),
  ('lbl_13', 'text', false, 'Маркетинг, реклама, PR',    'Montserrat', 163, 756, 14, '#3A3834', 0, 100),
  ('lbl_14', 'text', false, 'Стратегия, консалтинг',     'Montserrat', 169, 796, 14, '#3A3834', 0, 100),
  ('lbl_15', 'text', false, 'Искусство, массмедиа',      'Montserrat', 172, 836, 14, '#3A3834', 0, 100);

AT 0.5 UPDATE layers SET opacity = 100 WHERE id LIKE 'lbl_%' WITH (duration = 0.45, ease = 'out');

INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('bar_1',  'rect', false, 267, 272, 2, 16, '#D95338', 2, 100, 100),
  ('bar_2',  'rect', false, 267, 312, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_3',  'rect', false, 267, 352, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_4',  'rect', false, 267, 392, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_5',  'rect', false, 267, 432, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_6',  'rect', false, 267, 472, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_7',  'rect', false, 267, 512, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_8',  'rect', false, 267, 552, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_9',  'rect', false, 267, 592, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_10', 'rect', false, 267, 632, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_11', 'rect', false, 267, 672, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_12', 'rect', false, 267, 712, 2, 16, '#D95338', 2, 100, 100),
  ('bar_13', 'rect', false, 267, 752, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_14', 'rect', false, 267, 792, 2, 16, '#B8B4AC', 2, 100, 100),
  ('bar_15', 'rect', false, 267, 832, 2, 16, '#B8B4AC', 2, 100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('val_1',  'text', false, '0,0', 'JetBrains Mono', 288, 277, 14, '#D95338', 0, 100),
  ('val_2',  'text', false, '0,0', 'JetBrains Mono', 288, 317, 14, '#1C1B19', 0, 100),
  ('val_3',  'text', false, '0,0', 'JetBrains Mono', 288, 357, 14, '#1C1B19', 0, 100),
  ('val_4',  'text', false, '0,0', 'JetBrains Mono', 288, 397, 14, '#1C1B19', 0, 100),
  ('val_5',  'text', false, '0,0', 'JetBrains Mono', 288, 437, 14, '#1C1B19', 0, 100),
  ('val_6',  'text', false, '0,0', 'JetBrains Mono', 288, 477, 14, '#1C1B19', 0, 100),
  ('val_7',  'text', false, '0,0', 'JetBrains Mono', 288, 517, 14, '#1C1B19', 0, 100),
  ('val_8',  'text', false, '0,0', 'JetBrains Mono', 288, 557, 14, '#1C1B19', 0, 100),
  ('val_9',  'text', false, '0,0', 'JetBrains Mono', 288, 597, 14, '#1C1B19', 0, 100),
  ('val_10', 'text', false, '0,0', 'JetBrains Mono', 288, 637, 14, '#1C1B19', 0, 100),
  ('val_11', 'text', false, '0,0', 'JetBrains Mono', 288, 677, 14, '#1C1B19', 0, 100),
  ('val_12', 'text', false, '0,0', 'JetBrains Mono', 288, 717, 14, '#D95338', 0, 100),
  ('val_13', 'text', false, '0,0', 'JetBrains Mono', 288, 757, 14, '#1C1B19', 0, 100),
  ('val_14', 'text', false, '0,0', 'JetBrains Mono', 288, 797, 14, '#1C1B19', 0, 100),
  ('val_15', 'text', false, '0,0', 'JetBrains Mono', 288, 837, 14, '#1C1B19', 0, 100);

AT 0.7 UPDATE layers SET opacity = 100 WHERE id LIKE 'val_%' WITH (duration = 0.3, ease = 'out');

-- Наполнение баров и обновление цифр [0.8 — 7.2 с]
AT 0.80 UPDATE layers SET width = 10, x = 271.0 WHERE id = 'bar_1' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 0.80 UPDATE layers SET x = 298.0             WHERE id = 'val_1' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.05 UPDATE layers SET text = '0,8'          WHERE id = 'val_1';
AT 1.35 UPDATE layers SET text = '1,7'          WHERE id = 'val_1';
AT 1.70 UPDATE layers SET text = '2,4'          WHERE id = 'val_1';

AT 0.95 UPDATE layers SET width = 17, x = 274.5 WHERE id = 'bar_2' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 0.95 UPDATE layers SET x = 305.0             WHERE id = 'val_2' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.25 UPDATE layers SET text = '1,5'          WHERE id = 'val_2';
AT 1.55 UPDATE layers SET text = '3,2'          WHERE id = 'val_2';
AT 1.85 UPDATE layers SET text = '4,6'          WHERE id = 'val_2';

AT 1.10 UPDATE layers SET width = 20, x = 276.0 WHERE id = 'bar_3' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.10 UPDATE layers SET x = 308.0             WHERE id = 'val_3' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.40 UPDATE layers SET text = '1,9'          WHERE id = 'val_3';
AT 1.70 UPDATE layers SET text = '3,8'          WHERE id = 'val_3';
AT 2.00 UPDATE layers SET text = '5,4'          WHERE id = 'val_3';

AT 1.25 UPDATE layers SET width = 22, x = 277.0 WHERE id = 'bar_4' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.25 UPDATE layers SET x = 310.0             WHERE id = 'val_4' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.55 UPDATE layers SET text = '2,1'          WHERE id = 'val_4';
AT 1.85 UPDATE layers SET text = '4,1'          WHERE id = 'val_4';
AT 2.15 UPDATE layers SET text = '5,8'          WHERE id = 'val_4';

AT 1.40 UPDATE layers SET width = 26, x = 279.0 WHERE id = 'bar_5' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.40 UPDATE layers SET x = 314.0             WHERE id = 'val_5' WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 1.70 UPDATE layers SET text = '2,4'          WHERE id = 'val_5';
AT 2.00 UPDATE layers SET text = '4,9'          WHERE id = 'val_5';
AT 2.30 UPDATE layers SET text = '7,0'          WHERE id = 'val_5';

AT 1.95 UPDATE layers SET width = 32, x = 282.0 WHERE id = 'bar_6' WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
AT 1.95 UPDATE layers SET x = 320.0             WHERE id = 'val_6' WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
AT 2.25 UPDATE layers SET text = '3,0'          WHERE id = 'val_6';
AT 2.60 UPDATE layers SET text = '6,1'          WHERE id = 'val_6';
AT 2.95 UPDATE layers SET text = '8,5'          WHERE id = 'val_6';

AT 2.15 UPDATE layers SET width = 42, x = 287.0 WHERE id = 'bar_7' WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
AT 2.15 UPDATE layers SET x = 334.0             WHERE id = 'val_7' WITH (duration = 1.1, ease = [0.22, 1, 0.36, 1]);
AT 2.45 UPDATE layers SET text = '4,2'          WHERE id = 'val_7';
AT 2.80 UPDATE layers SET text = '8,1'          WHERE id = 'val_7';
AT 3.15 UPDATE layers SET text = '11,4'         WHERE id = 'val_7';
AT 2.35 UPDATE layers SET width = 62, x = 297.0 WHERE id = 'bar_8' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 2.35 UPDATE layers SET x = 354.0             WHERE id = 'val_8' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 2.70 UPDATE layers SET text = '5,8'          WHERE id = 'val_8';
AT 3.10 UPDATE layers SET text = '11,9'         WHERE id = 'val_8';
AT 3.45 UPDATE layers SET text = '16,8'         WHERE id = 'val_8';
AT 2.55 UPDATE layers SET width = 70, x = 301.0 WHERE id = 'bar_9' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 2.55 UPDATE layers SET x = 362.0             WHERE id = 'val_9' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 2.90 UPDATE layers SET text = '6,4'          WHERE id = 'val_9';
AT 3.30 UPDATE layers SET text = '13,2'         WHERE id = 'val_9';
AT 3.65 UPDATE layers SET text = '18,9'         WHERE id = 'val_9';
AT 2.75 UPDATE layers SET width = 84, x = 308.0 WHERE id = 'bar_10' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 2.75 UPDATE layers SET x = 376.0             WHERE id = 'val_10' WITH (duration = 1.2, ease = [0.22, 1, 0.36, 1]);
AT 3.10 UPDATE layers SET text = '7,9'          WHERE id = 'val_10';
AT 3.50 UPDATE layers SET text = '16,0'         WHERE id = 'val_10';
AT 3.85 UPDATE layers SET text = '22,6'         WHERE id = 'val_10';
AT 4.00 UPDATE layers SET width = 90, x = 311.0 WHERE id = 'bar_11' WITH (duration = 1.3, ease = [0.22, 1, 0.36, 1]);
AT 4.00 UPDATE layers SET x = 382.0             WHERE id = 'val_11' WITH (duration = 1.3, ease = [0.22, 1, 0.36, 1]);
AT 4.35 UPDATE layers SET text = '8,5'          WHERE id = 'val_11';
AT 4.80 UPDATE layers SET text = '17,4'         WHERE id = 'val_11';
AT 5.25 UPDATE layers SET text = '24,4'         WHERE id = 'val_11';
AT 4.30 UPDATE layers SET width = 110, x = 321.0 WHERE id = 'bar_12' WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
AT 4.30 UPDATE layers SET x = 402.0              WHERE id = 'val_12' WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
AT 4.65 UPDATE layers SET text = '9,4'           WHERE id = 'val_12';
AT 5.05 UPDATE layers SET text = '18,6'          WHERE id = 'val_12';
AT 5.45 UPDATE layers SET text = '25,1'          WHERE id = 'val_12';
AT 5.75 UPDATE layers SET text = '29,8'          WHERE id = 'val_12';
AT 4.60 UPDATE layers SET width = 125, x = 328.5 WHERE id = 'bar_13' WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
AT 4.60 UPDATE layers SET x = 417.0              WHERE id = 'val_13' WITH (duration = 1.5, ease = [0.22, 1, 0.36, 1]);
AT 4.95 UPDATE layers SET text = '11,2'          WHERE id = 'val_13';
AT 5.40 UPDATE layers SET text = '22,8'          WHERE id = 'val_13';
AT 6.00 UPDATE layers SET text = '33,7'          WHERE id = 'val_13';
AT 5.00 UPDATE layers SET width = 200, x = 366.0 WHERE id = 'bar_14' WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
AT 5.00 UPDATE layers SET x = 492.0              WHERE id = 'val_14' WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
AT 5.35 UPDATE layers SET text = '14,8'          WHERE id = 'val_14';
AT 5.80 UPDATE layers SET text = '29,5'          WHERE id = 'val_14';
AT 6.25 UPDATE layers SET text = '43,2'          WHERE id = 'val_14';
AT 6.75 UPDATE layers SET text = '54,0'          WHERE id = 'val_14';
AT 5.30 UPDATE layers SET width = 200, x = 366.0 WHERE id = 'bar_15' WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
AT 5.30 UPDATE layers SET x = 492.0              WHERE id = 'val_15' WITH (duration = 1.8, ease = [0.22, 1, 0.36, 1]);
AT 5.65 UPDATE layers SET text = '15,1'          WHERE id = 'val_15';
AT 6.10 UPDATE layers SET text = '30,4'          WHERE id = 'val_15';
AT 6.55 UPDATE layers SET text = '44,6'          WHERE id = 'val_15';
AT 7.05 UPDATE layers SET text = '54,0'          WHERE id = 'val_15';
-- ============================================================================
-- 3. КРУПНЫЙ ПРОЕЗД КАМЕРЫ СВЕРХУ ВНИЗ ПО ВСЕМ ПОЗИЦИЯМ [7.4 — 16.6 с]
-- ============================================================================
AT 7.4 UPDATE camera SET x = 285, y = 276, zoom = 1.48 WITH (duration = 1.2, ease = 'inOut');
AT 8.6 UPDATE camera SET x = 285, y = 836, zoom = 1.48 WITH (duration = 8.0, ease = 'linear');
-- ============================================================================
-- 4. СЦЕНА 2 (x = 1120): КОНТЕКСТ, ШКАЛА HH.ИНДЕКСА И ВЫВОДЫ [16.8 — 28.5 с]
-- ============================================================================
AT 16.8 UPDATE camera SET x = 1120, y = 480, zoom = 1.0 WITH (duration = 1.4, ease = 'inOut');
-- Удаляем все 54 слоя 1-й сцены из DOM сразу после завершения переезда камеры
AT 18.2 DELETE FROM layers WHERE id LIKE 's1_%' OR id LIKE 'lbl_%' OR id LIKE 'bar_%' OR id LIKE 'val_%';
-- Создаём элементы 2-й сцены ровно к моменту появления в кадре (ip = 17.8 с)
AT 17.8 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_tag',   'text', false, 'Обзор рынка труда · HeadHunter', 'JetBrains Mono', 1120, 118, 13, '#8A867E', 0, 100),
('s2_head1', 'text', false, 'Что стоят за этими',            'Montserrat',     1120, 162, 28, '#1C1B19', 0, 100),
('s2_head2', 'text', false, 'цифрами на рынке',              'Montserrat',     1120, 196, 28, '#1C1B19', 0, 100);
AT 18.0 UPDATE layers SET opacity = 100 WHERE id IN ('s2_tag', 's2_head1', 's2_head2') WITH (duration = 0.45, ease = 'out');
-- Карточка 1: Динамика за 2 года и IT
AT 18.2 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s2_c1_bg', 'rect', false, 1120, 310, 460, 156, '#EFECE4', 14, 0, 96);
AT 18.2 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_c1_t1', 'text', false, 'В целом по России индекс — 9,0',          'Montserrat',     1120, 264, 17, '#1C1B19', 0, 96),
('s2_c1_t2', 'text', false, 'год назад 7,3  ·  два года назад 3,9',    'JetBrains Mono', 1120, 294, 13, '#5A564E', 0, 96),
('s2_c1_t3', 'text', false, 'Москва: 10,8   ·   Петербург: 11,2',      'JetBrains Mono', 1120, 322, 13, '#5A564E', 0, 96),
('s2_c1_t4', 'text', false, 'В IT за год: вакансий −33%, резюме +12%', 'Montserrat',     1120, 358, 15, '#D95338', 0, 96);
AT 18.4 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c1_%' WITH (duration = 0.5, ease = 'out');
-- Карточка 2: Шкала hh.индекса
AT 19.4 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s2_c2_bg', 'rect', false, 1120, 520, 460, 210, '#EFECE4', 14, 0, 96);
AT 19.4 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_c2_hd', 'text', false, 'Шкала конкуренции HeadHunter',           'Montserrat',     1120, 444, 17, '#1C1B19', 0, 96),
('s2_sc_1',  'text', false, 'до 1,9    острый дефицит соискателей',   'JetBrains Mono', 1120, 480, 13, '#D95338', 0, 96),
('s2_sc_2',  'text', false, '2,0–3,9   дефицит (розница, повара)',    'JetBrains Mono', 1120, 508, 13, '#D95338', 0, 96),
('s2_sc_3',  'text', false, '4,0–7,9   умеренная конкуренция',        'JetBrains Mono', 1120, 536, 13, '#4A4741', 0, 96),
('s2_sc_4',  'text', false, '8,0–11,9  высокая конкуренция',          'JetBrains Mono', 1120, 564, 13, '#4A4741', 0, 96),
('s2_sc_5',  'text', false, 'от 12,0   крайне высокая (IT, маркетинг)', 'JetBrains Mono', 1120, 592, 13, '#1C1B19', 0, 96);
AT 19.6 UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s2_c2_bg', 's2_c2_hd', 's2_sc_1', 's2_sc_2', 's2_sc_3', 's2_sc_4', 's2_sc_5') WITH (duration = 0.5, ease = 'out');
-- Карточка 3: Вывод
AT 21.0 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s2_c3_bg', 'rect', false, 1120, 725, 460, 146, '#1C1B19', 14, 0, 96);
AT 21.0 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_c3_t1', 'text', false, 'Продавцов, поваров и электриков\nстоит удерживать — свободных мало.',      'Montserrat', 1120, 692, 15, '#F7F5F0', 0, 96),
('s2_c3_t2', 'text', false, 'В IT, маркетинге и у юристов на место\nдесятки резюме — время уйдёт на отбор.', 'Montserrat', 1120, 752, 15, '#D95338', 0, 96);
AT 21.2 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c3_%' WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);
