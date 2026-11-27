-- ============================================================================
-- 🕯️ ДУХОВНЫЙ ДНЕВНИК РОЖДЕСТВЕНСКОГО ПОСТА (Журнал «Фома»)
-- Референс: Календарь поста + День 15 (12 декабря)
-- Формат: 540x960 (9:16), 60 fps, длительность 26.0 с
--
-- СЦЕНА 1 (x = 270): Календарь Рождественского поста [0.0 — 15.6 с]
--   • Поочерёдное заполнение цветных баров под днями (от 28.11 до 12.12)
--   • Крупный плавный проход камеры по неделям до ячейки 12.12
-- СЦЕНА 2 (x = 1120): Детальный экран дня 12.12 [15.6 — 26.0 с]
--   • Этап 2 «Обетование» · День 15 (12 декабря) · «Путешествие братьев Иосифа в Египет»
--   • Чтение дня: Книга Бытия 28:10–22 · Вопрос для размышления
--
-- ПАЛИТРА РЕФЕРЕНСА:
--   фон листа    #FCFBF7 · рамки и сетка #8C8881 · плашки #F3EFE6
--   заголовки    #2A5699 (синий этапа 1) · #783324 (терракотовый этапа 2)
--   текст        #3A3834 основной · #78746C второстепенный · #A61C1C логотип «Фома»
--   бары этапов  #6B8CBE (начало) · #8E4A3B (обетование)
-- ШРИФТЫ: Playfair Display (антиква заголовков) · Montserrat (текст и даты)
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 26.0;

-- Стартовая камера: общий план календаря
AT 0.0 UPDATE camera SET x = 270, y = 480, zoom = 1.0;

-- ============================================================================
-- 1. ОБЩИЙ ФОН И ШАПКА КАЛЕНДАРЯ (Сцена 1: x = 270)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('world_bg',     'rect',    false, 700, 480, 1600, 1100, '#FCFBF7', 0,  100, 100),
  ('s1_leaf_l',    'ellipse', false, 150, 35,  140,  46,   '#D4AF6A', 0,  35,  100),
  ('s1_leaf_r',    'ellipse', false, 390, 35,  140,  46,   '#D4AF6A', 0,  35,  100),
  ('s1_star_top',  'ellipse', false, 270, 36,  24,   24,   '#E6C27A', 0,  90,  100),
  ('s1_foma_bg',   'ellipse', false, 486, 54,  46,   46,   '#9E2A2B', 0,  100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_foma_sub', 'text', false, 'ЖУРНАЛ',              'Montserrat',       486, 44,  7,  '#F3EFE6', 100, 100),
  ('s1_foma_txt', 'text', false, 'ФОМА',                'Playfair Display', 486, 61,  13, '#FFFFFF', 100, 100),
  ('s1_kicker',   'text', false, 'календарь',           'Montserrat',       270, 92,  16, '#4A4741', 0,   100),
  ('s1_title',    'text', false, 'Рождественского поста','Playfair Display',270, 134, 34, '#2A5699', 0,   100);

AT 0.2 UPDATE layers SET opacity = 100 WHERE id IN ('s1_kicker', 's1_title') WITH (duration = 0.5, ease = 'out');

-- ============================================================================
-- 2. СЕТКА КАЛЕНДАРЯ И ЗАГОЛОВКИ ДНЕЙ НЕДЕЛИ (7 колонок: x = 78..462, шаг 64)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s1_grid_top', 'rect', false, 270, 168, 448, 2,   '#8C8881', 0, 100, 100),
  ('s1_grid_h0',  'rect', false, 270, 214, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h1',  'rect', false, 270, 304, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h2',  'rect', false, 270, 394, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h3',  'rect', false, 270, 484, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h4',  'rect', false, 270, 574, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h5',  'rect', false, 270, 664, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_h6',  'rect', false, 270, 754, 448, 1.5, '#8C8881', 0, 100, 100),
  ('s1_grid_bot', 'rect', false, 270, 844, 448, 2,   '#8C8881', 0, 100, 100);

INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s1_v0', 'rect', false, 46,  506, 1.5, 676, '#8C8881', 0, 100, 100),
  ('s1_v1', 'rect', false, 110, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v2', 'rect', false, 174, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v3', 'rect', false, 238, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v4', 'rect', false, 302, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v5', 'rect', false, 366, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v6', 'rect', false, 430, 506, 1,   676, '#B5B0A8', 0, 100, 100),
  ('s1_v7', 'rect', false, 494, 506, 1.5, 676, '#8C8881', 0, 100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_dow_1', 'text', false, 'ПН', 'Playfair Display', 78,  198, 22, '#6E6A63', 100, 100),
  ('s1_dow_2', 'text', false, 'BT', 'Playfair Display', 142, 198, 22, '#6E6A63', 100, 100),
  ('s1_dow_3', 'text', false, 'СР', 'Playfair Display', 206, 198, 22, '#6E6A63', 100, 100),
  ('s1_dow_4', 'text', false, 'ЧТ', 'Playfair Display', 270, 198, 22, '#6E6A63', 100, 100),
  ('s1_dow_5', 'text', false, 'ПТ', 'Playfair Display', 334, 198, 22, '#6E6A63', 100, 100),
  ('s1_dow_6', 'text', false, 'СБ', 'Playfair Display', 398, 198, 22, '#6E6A63', 100, 100),
  ('s1_dow_7', 'text', false, 'ВС', 'Playfair Display', 462, 198, 22, '#6E6A63', 100, 100);

-- ============================================================================
-- 3. ДАТЫ КАЛЕНДАРЯ И ЗАПОЛНЯЕМЫЕ БАРЫ ПОД ДНЯМИ (28.11 — 12.12 + обзор сетки)
-- ============================================================================

-- Неделя 1: СБ 28.11 (x=398), ВС 29.11 (x=462), y строки = 214..304
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_ico_d1', 'text', false, '🫙🐟', 'Montserrat', 398, 240, 13, '#8C8881', 100, 100),
  ('s1_ico_d2', 'text', false, '🫙🐟', 'Montserrat', 462, 240, 13, '#8C8881', 100, 100),
  ('s1_d1',     'text', false, '28.11', 'Montserrat', 398, 286, 18, '#5A564E', 100, 100),
  ('s1_d2',     'text', false, '29.11', 'Montserrat', 462, 286, 18, '#5A564E', 100, 100);

-- Неделя 2: 30.11 — 6.12 (y строки = 304..394, нижний бар этапа «начало» y = 391)
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_ico_d3', 'text', false, '🫙🐟',   'Montserrat', 78,  330, 13, '#8C8881', 100, 100),
  ('s1_ico_d4', 'text', false, '🫙🐟',   'Montserrat', 142, 330, 13, '#8C8881', 100, 100),
  ('s1_ico_d5', 'text', false, '🫙',     'Montserrat', 206, 330, 13, '#8C8881', 100, 100),
  ('s1_ico_d6', 'text', false, '🫙🐟',   'Montserrat', 270, 330, 13, '#8C8881', 100, 100),
  ('s1_ico_d7', 'text', false, '🫙🐟',   'Montserrat', 334, 326, 12, '#8C8881', 100, 100),
  ('s1_praz_4', 'text', false, 'Введение во храм', 'Montserrat', 334, 344, 7, '#5A564E', 100, 100),
  ('s1_ico_d8', 'text', false, '🫙🐟',   'Montserrat', 398, 330, 13, '#8C8881', 100, 100),
  ('s1_ico_d9', 'text', false, '🫙🐟',   'Montserrat', 462, 330, 13, '#8C8881', 100, 100),
  ('s1_d3',     'text', false, '30.11',  'Montserrat', 78,  376, 18, '#5A564E', 100, 100),
  ('s1_d4',     'text', false, '1.12',   'Montserrat', 142, 376, 18, '#5A564E', 100, 100),
  ('s1_d5',     'text', false, '2.12',   'Montserrat', 206, 376, 18, '#5A564E', 100, 100),
  ('s1_d6',     'text', false, '3.12',   'Montserrat', 270, 376, 18, '#5A564E', 100, 100),
  ('s1_d7',     'text', false, '4.12',   'Montserrat', 334, 376, 18, '#5A564E', 100, 100),
  ('s1_d8',     'text', false, '5.12',   'Montserrat', 398, 376, 18, '#5A564E', 100, 100),
  ('s1_d9',     'text', false, '6.12',   'Montserrat', 462, 376, 18, '#5A564E', 100, 100);

-- Неделя 3: 7.12 — 13.12 (y строки = 394..484, нижний бар этапа «обетование» y = 481)
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_ico_d10', 'text', false, '🫙🐟', 'Montserrat', 78,  420, 13, '#8C8881', 100, 100),
  ('s1_ico_d11', 'text', false, '🫙🐟', 'Montserrat', 142, 420, 13, '#8C8881', 100, 100),
  ('s1_ico_d12', 'text', false, '🫙',   'Montserrat', 206, 420, 13, '#8C8881', 100, 100),
  ('s1_ico_d13', 'text', false, '🫙🐟', 'Montserrat', 270, 420, 13, '#8C8881', 100, 100),
  ('s1_ico_d14', 'text', false, '🫙',   'Montserrat', 334, 420, 13, '#8C8881', 100, 100),
  ('s1_ico_d15', 'text', false, '🫙🐟', 'Montserrat', 398, 420, 13, '#8C8881', 100, 100),
  ('s1_ico_d16', 'text', false, '🫙🐟', 'Montserrat', 462, 420, 13, '#8C8881', 100, 100),
  ('s1_d10',     'text', false, '7.12',  'Montserrat', 78,  466, 18, '#5A564E', 100, 100),
  ('s1_d11',     'text', false, '8.12',  'Montserrat', 142, 466, 18, '#5A564E', 100, 100),
  ('s1_d12',     'text', false, '9.12',  'Montserrat', 206, 466, 18, '#5A564E', 100, 100),
  ('s1_d13',     'text', false, '10.12', 'Montserrat', 270, 466, 18, '#5A564E', 100, 100),
  ('s1_d14',     'text', false, '11.12', 'Montserrat', 334, 466, 18, '#5A564E', 100, 100),
  ('s1_d15',     'text', false, '12.12', 'Montserrat', 398, 466, 18, '#783324', 100, 100),
  ('s1_d16',     'text', false, '13.12', 'Montserrat', 462, 466, 18, '#5A564E', 100, 100);

-- Нижние недели календаря (для полноты сетки на общем плане)
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_w4', 'text', false, '14.12     15.12     16.12     17.12     18.12     19.12     20.12', 'Montserrat', 270, 556, 17, '#78746C', 100, 100),
  ('s1_w5', 'text', false, '21.12     22.12     23.12     24.12     25.12     26.12     27.12', 'Montserrat', 270, 646, 17, '#78746C', 100, 100),
  ('s1_w6', 'text', false, '28.12     29.12     30.12     31.12      1.01       2.01      3.01',  'Montserrat', 270, 736, 17, '#78746C', 100, 100),
  ('s1_w7', 'text', false, ' 4.01       5.01       6.01',                                      'Montserrat', 142, 826, 17, '#78746C', 100, 100);

INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s1_xmas_bg', 'rect', false, 270, 799, 64, 90, '#2A5699', 0, 100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s1_xmas_t', 'text', false, 'Рождество', 'Montserrat', 270, 800, 9,  '#FFFFFF', 100, 100),
('s1_xmas_d', 'text', false, '7.01',      'Montserrat', 270, 826, 18, '#FFFFFF', 100, 100),
('s1_leg',    'text', false, '🫙 с маслом   🍲 без масла   🐟 рыба   🥛 не вкушается', 'Montserrat', 270, 886, 12, '#5A564E', 100, 100);
-- Бары прогресса под каждым днём (растут слева направо внутри своей ячейки шириной 64 px)
-- Этап 1 «Начало» (#6B8CBE): 28.11 — 4.12 (дни 1..7)
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s1_bar_1',  'rect', false, 366, 301, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_2',  'rect', false, 430, 301, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_3',  'rect', false, 46,  391, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_4',  'rect', false, 110, 391, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_5',  'rect', false, 174, 391, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_6',  'rect', false, 238, 391, 1, 6, '#6B8CBE', 0, 0, 100),
('s1_bar_7',  'rect', false, 302, 391, 1, 6, '#6B8CBE', 0, 0, 100),
-- Этап 2 «Обетование» (#8E4A3B): 5.12 — 12.12 (дни 8..15)
('s1_bar_8',  'rect', false, 366, 391, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_9',  'rect', false, 430, 391, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_10', 'rect', false, 46,  481, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_11', 'rect', false, 110, 481, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_12', 'rect', false, 174, 481, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_13', 'rect', false, 238, 481, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_14', 'rect', false, 302, 481, 1, 6, '#8E4A3B', 0, 0, 100),
('s1_bar_15', 'rect', false, 366, 481, 1, 6, '#8E4A3B', 0, 0, 100);
-- Рамка подсветки целевого дня 12.12 (ячейка x=398, y=439, w=64, h=90)
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s1_focus_12', 'rect', false, 398, 439, 64, 90, '#8E4A3B', 4, 0, 100);
-- Поочерёдное заполнение баров под днями [0.6 — 11.4 с] (шаг 0.65 с на день)
AT 0.60 UPDATE layers SET opacity = 100, width = 64, x = 398 WHERE id = 's1_bar_1'  WITH (duration = 0.60, ease = 'out');
AT 1.25 UPDATE layers SET opacity = 100, width = 64, x = 462 WHERE id = 's1_bar_2'  WITH (duration = 0.60, ease = 'out');
AT 1.90 UPDATE layers SET opacity = 100, width = 64, x = 78  WHERE id = 's1_bar_3'  WITH (duration = 0.60, ease = 'out');
AT 2.55 UPDATE layers SET opacity = 100, width = 64, x = 142 WHERE id = 's1_bar_4'  WITH (duration = 0.60, ease = 'out');
AT 3.20 UPDATE layers SET opacity = 100, width = 64, x = 206 WHERE id = 's1_bar_5'  WITH (duration = 0.60, ease = 'out');
AT 3.85 UPDATE layers SET opacity = 100, width = 64, x = 270 WHERE id = 's1_bar_6'  WITH (duration = 0.60, ease = 'out');
AT 4.50 UPDATE layers SET opacity = 100, width = 64, x = 334 WHERE id = 's1_bar_7'  WITH (duration = 0.60, ease = 'out');
AT 5.15 UPDATE layers SET opacity = 100, width = 64, x = 398 WHERE id = 's1_bar_8'  WITH (duration = 0.60, ease = 'out');
AT 5.80 UPDATE layers SET opacity = 100, width = 64, x = 462 WHERE id = 's1_bar_9'  WITH (duration = 0.60, ease = 'out');
AT 6.45 UPDATE layers SET opacity = 100, width = 64, x = 78  WHERE id = 's1_bar_10' WITH (duration = 0.60, ease = 'out');
AT 7.10 UPDATE layers SET opacity = 100, width = 64, x = 142 WHERE id = 's1_bar_11' WITH (duration = 0.60, ease = 'out');
AT 7.75 UPDATE layers SET opacity = 100, width = 64, x = 206 WHERE id = 's1_bar_12' WITH (duration = 0.60, ease = 'out');
AT 8.40 UPDATE layers SET opacity = 100, width = 64, x = 270 WHERE id = 's1_bar_13' WITH (duration = 0.60, ease = 'out');
AT 9.05 UPDATE layers SET opacity = 100, width = 64, x = 334 WHERE id = 's1_bar_14' WITH (duration = 0.60, ease = 'out');
AT 9.70 UPDATE layers SET opacity = 100, width = 64, x = 398 WHERE id = 's1_bar_15' WITH (duration = 0.70, ease = 'out');
-- Движение камеры за заполняющимися днями:
-- 1) Наезд на первую неделю (28.11–29.11)
AT 0.5  UPDATE camera SET x = 410, y = 265, zoom = 1.65 WITH (duration = 1.1, ease = 'inOut');
-- 2) Проезд по второй неделе (30.11 -> 6.12)
AT 1.8  UPDATE camera SET x = 140, y = 355, zoom = 1.65 WITH (duration = 1.1, ease = 'inOut');
AT 2.9  UPDATE camera SET x = 410, y = 355, zoom = 1.65 WITH (duration = 3.2, ease = 'linear');
-- 3) Переход на третью неделю и остановка крупно на ячейке 12.12 (x = 398, y = 439)
AT 6.3  UPDATE camera SET x = 140, y = 442, zoom = 1.65 WITH (duration = 1.1, ease = 'inOut');
AT 7.4  UPDATE camera SET x = 385, y = 442, zoom = 1.85 WITH (duration = 3.2, ease = 'inOut');
-- Пульсирующий акцент на выбранной ячейке 12.12 [10.6 — 12.4 с]
AT 10.6 UPDATE layers SET opacity = 22 WHERE id = 's1_focus_12' WITH (duration = 0.45, ease = 'out', repeat = 1, yoyo = true);
-- ============================================================================
-- 4. ПЛАВНЫЙ ПЕРЕЕЗД КАМЕРЫ НА ЭКРАН ДНЯ 12.12 (x = 1120) [12.4 — 26.0 с]
-- ============================================================================
AT 12.4 UPDATE camera SET x = 1120, y = 480, zoom = 1.0 WITH (duration = 1.5, ease = 'inOut');
-- Выгружаем все слои Сцены 1 из DOM сразу после переезда камеры
AT 14.0 DELETE FROM layers WHERE id LIKE 's1_%';
-- Создаём детальный экран дня 15 (12 декабря) ровно к началу переезда камеры
AT 12.2 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s2_page',     'rect',    false, 1120, 480, 500, 900, '#FCFBF7', 16, 100, 100),
('s2_foma_bg',  'ellipse', false, 1330, 62,  46,  46,  '#9E2A2B', 0,  100, 100),
('s2_branch',   'ellipse', false, 1050, 118, 96,  24,  '#C99E57', 0,  55,  100),
('s2_div_v',    'rect',    false, 1186, 118, 1.5, 34,  '#8C8881', 0,  100, 100),
('s2_line_1',   'rect',    false, 945,  256, 86,  1.5, '#8E4A3B', 0,  100, 100),
('s2_line_2',   'rect',    false, 1120, 314, 430, 1,   '#8C8881', 0,  100, 100),
('s2_line_3a',  'rect',    false, 956,  354, 104, 1,   '#8C8881', 0,  100, 100),
('s2_line_3b',  'rect',    false, 1284, 354, 104, 1,   '#8C8881', 0,  100, 100),
('s2_q_card',   'rect',    false, 1120, 436, 436, 112, '#F4EFE4', 12, 0,   96),
('s2_notes_bg', 'rect',    false, 1120, 626, 436, 224, '#FFFFFF', 12, 0,   98),
('s2_candle_g', 'ellipse', false, 1120, 818, 68,  68,  '#F5D076', 0,  35,  100),
('s2_candle_b', 'rect',    false, 1120, 846, 36,  30,  '#E8D9B5', 6,  100, 100),
('s2_flame',    'ellipse', false, 1120, 816, 10,  22,  '#F59E0B', 0,  100, 100);
AT 12.2 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_top_k',   'text', false, 'духовный дневник рождественского поста', 'Montserrat',       1085, 58,  11, '#5A564E', 100, 100),
('s2_foma_s',  'text', false, 'ЖУРНАЛ',                                'Montserrat',       1330, 52,  7,  '#F3EFE6', 100, 100),
('s2_foma_t',  'text', false, 'ФОМА',                                  'Playfair Display', 1330, 69,  13, '#FFFFFF', 100, 100),
('s2_etap_l',  'text', false, 'этап 2',                                'Montserrat',       945,  108, 12, '#5A564E', 100, 100),
('s2_etap_n',  'text', false, 'Обетование',                            'Playfair Display', 945,  130, 18, '#783324', 100, 100),
('s2_day_n',   'text', false, 'день 15',                               'Montserrat',       1142, 108, 12, '#5A564E', 100, 100),
('s2_day_d',   'text', false, '12 декабря',                            'Montserrat',       1142, 130, 14, '#1C1B19', 100, 100),
('s2_food_i',  'text', false, '🫙🐟',                                  'Montserrat',       1224, 124, 18, '#783324', 100, 100),
('s2_food_t1', 'text', false, 'горячая пища',                          'Montserrat',       1304, 108, 12, '#3A3834', 100, 100),
('s2_food_t2', 'text', false, 'с маслом и рыба',                       'Montserrat',       1304, 128, 12, '#3A3834', 100, 100),
('s2_h1',      'text', false, 'Путешествие братьев',                   'Playfair Display', 1120, 184, 30, '#783324', 0,   96),
('s2_h2',      'text', false, 'Иосифа в Египет',                       'Playfair Display', 1120, 220, 30, '#783324', 0,   96),
('s2_read_l',  'text', false, 'чтение дня',                            'Montserrat',       945,  260, 13, '#783324', 0,   100),
('s2_read_v',  'text', false, 'Книга Бытия 28:10–22',                  'Playfair Display', 1244, 260, 16, '#783324', 0,   100),
('s2_m_lbl',   'text', false, 'главная мысль из чтения',               'Montserrat',       1120, 318, 13, '#3A3834', 0,   100),
('s2_q_lbl',   'text', false, 'вопрос для размышления',                'Montserrat',       1120, 358, 13, '#3A3834', 0,   100),
('s2_q_t1',    'text', false, 'Что обычно мешает мне сделать первый шаг', 'Playfair Display', 1120, 412, 17, '#3A3834', 0, 96),
('s2_q_t2',    'text', false, 'к примирению с человеком,',             'Playfair Display', 1120, 438, 17, '#3A3834', 0,   96),
('s2_q_t3',    'text', false, 'который меня обидел?',                  'Playfair Display', 1120, 464, 17, '#3A3834', 0,   96),
('s2_dots_1',  'text', false, '..........................................................................', 'Montserrat', 1120, 548, 12, '#B5B0A8', 0, 100),
('s2_dots_2',  'text', false, '..........................................................................', 'Montserrat', 1120, 584, 12, '#B5B0A8', 0, 100),
('s2_dots_3',  'text', false, '..........................................................................', 'Montserrat', 1120, 620, 12, '#B5B0A8', 0, 100),
('s2_dots_4',  'text', false, '..........................................................................', 'Montserrat', 1120, 656, 12, '#B5B0A8', 0, 100),
('s2_dots_5',  'text', false, '..........................................................................', 'Montserrat', 1120, 692, 12, '#B5B0A8', 0, 100);
-- Поочерёдное проявление блоков разворота дневника [13.7 — 17.5 с]
AT 13.7 UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s2_h1', 's2_h2') WITH (duration = 0.55, ease = 'out');
AT 14.1 UPDATE layers SET opacity = 100              WHERE id IN ('s2_read_l', 's2_read_v', 's2_m_lbl') WITH (duration = 0.45, ease = 'out');
AT 14.6 UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s2_q_lbl', 's2_q_card', 's2_q_t1', 's2_q_t2', 's2_q_t3') WITH (duration = 0.6, ease = [0.22, 1, 0.36, 1]);
AT 15.2 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_notes%' OR id LIKE 's2_dots%' WITH (duration = 0.5, ease = 'out');
-- Живое мерцание свечи внизу страницы до конца ролика [14.0 — 25.0 с]
AT 14.0 UPDATE layers SET scale = 118, opacity = 55 WHERE id = 's2_candle_g' WITH (duration = 1.4, ease = 'inOut', repeat = 7, yoyo = true);
AT 14.0 UPDATE layers SET scale = 110               WHERE id = 's2_flame'    WITH (duration = 0.9, ease = 'inOut', repeat = 11, yoyo = true);
-- Мягкий акцентный наезд камеры на вопрос для размышления [17.0 — 23.5 с]
AT 17.0 UPDATE camera SET x = 1120, y = 415, zoom = 1.07 WITH (duration = 2.2, ease = 'inOut');
AT 22.0 UPDATE camera SET x = 1120, y = 480, zoom = 1.0  WITH (duration = 2.0, ease = 'inOut');
