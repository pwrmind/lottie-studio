-- ============================================================================
-- LOTTIE SCENARIO LANGUAGE (*.lsl)
-- «Дорога к родителям» — камера ведёт зрителя от зимнего леса к родному дому
-- Формат: 540x960 (9:16), 60 FPS, 12.0 секунд
-- Мир широкий (2600 px): лес слева -> дорога -> дом с воротами справа
-- Камера: следящий кадр за машиной, широкий reveal дома, финальный push-in
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 12.0;

-- КАДР 1 (0.0): крупный план — машина ждёт на заснеженной лесной дороге
UPDATE camera SET x = 280, y = 500, zoom = 1.28 AT 0.0;
-- КАДР 2 (1.0): камера сопровождает машину через весь лес до ворот (follow)
UPDATE camera SET x = 1700, y = 490, zoom = 1.12 AT 1.0 WITH (duration = 4.4, ease = 'inOut');
-- КАДР 3 (5.6): отъезд — открывается дом, ворота и ждущие родители (reveal)
UPDATE camera SET x = 1850, y = 470, zoom = 1.0 AT 5.6 WITH (duration = 1.2, ease = 'inOut');
-- КАДР 4 (8.4): медленный наезд на дом и открытку (push-in)
UPDATE camera SET x = 1950, y = 420, zoom = 1.07 AT 8.4 WITH (duration = 2.2, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- 1. НЕБО, СОЛНЦЕ, ОБЛАКА, ДОРОГА И СНЕЖНЫЕ ОТКОСЫ (мир 2600 px)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('bg',       'rect',    1200, 480, 2600, 1800, '#c7def2', 0, 100),
  ('sun_glow', 'ellipse', 2150, 165, 170,  170,  '#fde68a', 0, 0),
  ('sun',      'ellipse', 2150, 165, 62,   62,   '#fef08a', 0, 0),
  ('cloud1',   'ellipse', 620,  120, 130,  40,   '#ffffff', 0, 0),
  ('cloud2',   'ellipse', 1150, 175, 110,  34,   '#ffffff', 0, 0),
  ('cloud3',   'ellipse', 1900, 105, 120,  36,   '#ffffff', 0, 0),
  ('ground',   'rect',    1200, 830, 2600, 360,  '#f4f8fd', 0, 0),
  ('road',     'rect',    1200, 858, 2600, 60,   '#cbd6e4', 0, 0),
  ('bank1',    'ellipse', 640,  838, 420,  46,   '#ffffff', 0, 0),
  ('bank2',    'ellipse', 1500, 842, 500,  50,   '#ffffff', 0, 0),
  ('bank3',    'ellipse', 2150, 840, 460,  48,   '#ffffff', 0, 0);

-- ----------------------------------------------------------------------------
-- 2. ЕЛИ ВДОЛЬ ДОРОГИ (путевые ориентиры для следящего кадра)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('t1', 'ellipse', 200,  600, 150, 280, '#14532d', 0, 0),
  ('cap1','ellipse', 200,  480, 88,  38,  '#f8fafc', 0, 0),
  ('t2', 'ellipse', 560,  590, 170, 310, '#166534', 0, 0),
  ('cap2','ellipse', 560,  462, 98,  42,  '#f8fafc', 0, 0),
  ('t3', 'ellipse', 950,  610, 140, 260, '#14532d', 0, 0),
  ('cap3','ellipse', 950,  505, 82,  36,  '#f8fafc', 0, 0),
  ('t4', 'ellipse', 1350, 595, 160, 300, '#166534', 0, 0),
  ('cap4','ellipse', 1350, 472, 92,  40,  '#f8fafc', 0, 0),
  ('t5', 'ellipse', 2260, 600, 170, 320, '#14532d', 0, 0),
  ('cap5','ellipse', 2260, 468, 98,  42,  '#f8fafc', 0, 0),
  ('t6', 'ellipse', 2450, 590, 150, 290, '#166534', 0, 0),
  ('cap6','ellipse', 2450, 472, 88,  40,  '#f8fafc', 0, 0);

-- ----------------------------------------------------------------------------
-- 3. ДОМ: СТЕНЫ, КРЫША, ТРУБА, ОКНА, ДВЕРЬ (x = 1950)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, rotation) VALUES
  ('house',    'rect',    1950, 540, 320, 210, '#b45309', 6, 0, 0),
  ('roof_l',   'rect',    1870, 432, 185, 26,  '#7f1d1d', 4, 0, -24),
  ('roof_r',   'rect',    2030, 432, 185, 26,  '#7f1d1d', 4, 0, 24),
  ('cap_roof', 'ellipse', 1950, 394, 70,  16,  '#f8fafc', 0, 0, 0),
  ('chimney',  'rect',    2020, 406, 28,  62,  '#991b1b', 3, 0, 0),
  ('win1',     'rect',    1875, 530, 48,  44,  '#fbbf24', 4, 0, 0),
  ('win2',     'rect',    2025, 530, 48,  44,  '#fbbf24', 4, 0, 0),
  ('door',     'rect',    1950, 608, 46,  80,  '#7c2d12', 4, 0, 0);

-- ----------------------------------------------------------------------------
-- 4. ВОРОТА И ЗАБОР ВДОЛЬ ДОРОГИ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('gate_p1',   'rect', 1730, 770, 16,  110, '#b45309', 3, 0),
  ('gate_p2',   'rect', 1810, 770, 16,  110, '#b45309', 3, 0),
  ('gate_rail1','rect', 1770, 738, 96,  12,  '#b45309', 3, 0),
  ('gate_rail2','rect', 1770, 792, 96,  9,   '#b45309', 3, 0),
  ('fpl1',      'rect', 1660, 812, 10,  88,  '#92400e', 2, 0),
  ('fpl2',      'rect', 1690, 812, 10,  88,  '#92400e', 2, 0),
  ('fprail',    'rect', 1675, 794, 30,  8,   '#92400e', 2, 0),
  ('fp1',       'rect', 2090, 812, 10,  88,  '#92400e', 2, 0),
  ('fp2',       'rect', 2120, 812, 10,  88,  '#92400e', 2, 0),
  ('fp3',       'rect', 2150, 812, 10,  88,  '#92400e', 2, 0),
  ('frail',     'rect', 2120, 794, 70,  8,   '#92400e', 2, 0);

-- ----------------------------------------------------------------------------
-- 5. ДЫМОК ИЗ ТРУБЫ (три клубка в цикле)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('smoke1', 'ellipse', 2020, 386, 22, 22, '#e2e8f0', 0, 0),
  ('smoke2', 'ellipse', 2022, 386, 26, 26, '#e2e8f0', 0, 0),
  ('smoke3', 'ellipse', 2018, 386, 19, 19, '#e2e8f0', 0, 0);

-- ----------------------------------------------------------------------------
-- 6. БАБУШКА И ДЕДУШКА ЖДУТ У ДОМА
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('gp_body', 'rect',    1900, 752, 46, 82, '#2563eb', 12, 0),
  ('gp_head', 'ellipse', 1900, 690, 32, 32, '#fcd5b5', 0,  0),
  ('gp_hat',  'ellipse', 1900, 676, 36, 16, '#1e3a8a', 0,  0),
  ('gp_arm',  'rect',    1876, 718, 9,  34, '#2563eb', 4,  0);

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('gm_body',  'rect',    2000, 756, 44, 78, '#db2777', 12, 0),
  ('gm_head',  'ellipse', 2000, 696, 32, 32, '#fcd5b5', 0,  0),
  ('gm_scarf', 'ellipse', 2000, 712, 40, 14, '#be185d', 0,  0),
  ('gm_arm',   'rect',    1977, 722, 9,  34, '#db2777', 4,  0);

-- ----------------------------------------------------------------------------
-- 7. СОБАКА — помчится к машине навстречу
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('dog_body', 'ellipse', 2100, 768, 40, 26, '#92400e', 0, 0),
  ('dog_head', 'ellipse', 2072, 752, 20, 18, '#b45309', 0, 0),
  ('dog_ear',  'ellipse', 2066, 740, 8,  12, '#78350f', 0, 0),
  ('dog_tail', 'ellipse', 2124, 758, 14, 8,  '#b45309', 0, 0);

-- ----------------------------------------------------------------------------
-- 8. НАША МАШИНА (ждёт в лесу, потом едет к дому)
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('car_body',  'rect',    250, 826, 150, 46, '#dc2626', 10, 0),
  ('car_cabin', 'rect',    270, 788, 70,  36, '#fca5a5', 8,  0),
  ('w1',        'ellipse', 202, 856, 34,  34, '#111827', 0,  0),
  ('w2',        'ellipse', 298, 856, 34,  34, '#111827', 0,  0),
  ('headlight', 'ellipse', 322, 828, 10,  10, '#fde68a', 0,  0);

-- ----------------------------------------------------------------------------
-- 9. БЛЁСТКИ НА СНЕГУ У ДОМА И СНЕГОПАД ПО ВСЕМУ МИРУ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('sp1', 'ellipse', 1770, 840, 6, 6, '#fef9c3', 0, 0, 100),
  ('sp2', 'ellipse', 1870, 862, 5, 5, '#fef9c3', 0, 0, 100),
  ('sp3', 'ellipse', 1990, 845, 6, 6, '#fef9c3', 0, 0, 100),
  ('sp4', 'ellipse', 2090, 858, 5, 5, '#fef9c3', 0, 0, 100),
  ('sp5', 'ellipse', 1830, 822, 7, 7, '#fef9c3', 0, 0, 100),
  ('sp6', 'ellipse', 2060, 866, 6, 6, '#fef9c3', 0, 0, 100);

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('fl1', 'ellipse', 180,  -40, 10, 10, '#ffffff', 0, 70),
  ('fl2', 'ellipse', 520,  -60, 8,  8,  '#ffffff', 0, 60),
  ('fl3', 'ellipse', 900,  -30, 12, 12, '#ffffff', 0, 75),
  ('fl4', 'ellipse', 1300, -50, 9,  9,  '#ffffff', 0, 65),
  ('fl5', 'ellipse', 1650, -40, 11, 11, '#ffffff', 0, 70),
  ('fl6', 'ellipse', 2000, -60, 10, 10, '#ffffff', 0, 65),
  ('fl7', 'ellipse', 2280, -30, 8,  8,  '#ffffff', 0, 60),
  ('fl8', 'ellipse', 760,  -70, 9,  9,  '#ffffff', 0, 75);

-- ----------------------------------------------------------------------------
-- 10. ОТКРЫТКА-ПОЗДРАВЛЕНИЕ В НЕБЕ НАД ДОМОМ
-- ----------------------------------------------------------------------------
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('card_shadow', 'rect', 1950, 262, 450, 175, '#fde68a', 26, 0),
  ('card',        'rect', 1950, 258, 440, 170, '#ffffff', 24, 0),
  ('pill',        'rect', 1950, 190, 210, 30,  '#dbeafe', 15, 0);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('t_pill',  'text', 'ДОРОГИЕ МАМА И ПАПА',         1950, 192, 13, '#0369a1', 0),
  ('t_title', 'text', 'Привет, мама и папа!',         1950, 244, 32, '#1e293b', 0),
  ('t_msg1',  'text', 'С Рождеством и Новым годом!',  1950, 292, 19, '#475569', 0),
  ('t_msg2',  'text', 'Мы уже у ворот!',              1950, 320, 19, '#475569', 0);

-- ============================================================================
-- АКТ I: ЛЕСНОЯ ДОРОГА ОЖИВАЕТ (0.2 — 1.1)
-- ============================================================================
UPDATE layers SET opacity = 100 WHERE id IN ('ground', 'road') AT 0.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('bank1', 'bank2', 'bank3') AT 0.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('t1', 't2', 't3', 't4') AT 0.35 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('cap1', 'cap2', 'cap3', 'cap4') AT 0.5 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('t5', 't6') AT 5.25 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('cap5', 'cap6') AT 5.4 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'sun' AT 0.3 WITH (duration = 0.6, ease = 'out');
UPDATE layers SET opacity = 40, scale = 100 WHERE id = 'sun_glow' AT 0.3 WITH (duration = 0.8, ease = 'out');
UPDATE layers SET opacity = 60 WHERE id = 'cloud1' AT 0.5 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 55 WHERE id = 'cloud2' AT 0.6 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 50 WHERE id = 'cloud3' AT 0.7 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET x = 720 WHERE id = 'cloud1' AT 0.5 WITH (duration = 8.0, ease = 'linear');
UPDATE layers SET x = 1240 WHERE id = 'cloud2' AT 0.6 WITH (duration = 7.0, ease = 'linear');
UPDATE layers SET x = 1980 WHERE id = 'cloud3' AT 0.7 WITH (duration = 6.0, ease = 'linear');

-- ============================================================================
-- АКТ II: МАШИНА ЕДЕТ ЧЕРЕЗ ЛЕС, КАМЕРА СЛЕДУЕТ ЗА НЕЙ (1.0 — 5.5)
-- ============================================================================
UPDATE layers SET opacity = 100 WHERE id IN ('car_body', 'car_cabin', 'w1', 'w2', 'headlight') AT 0.9 WITH (duration = 0.25, ease = 'out');
UPDATE layers SET x = 1680 WHERE id = 'car_body'  AT 1.0 WITH (duration = 4.5, ease = 'inOut');
UPDATE layers SET x = 1700 WHERE id = 'car_cabin' AT 1.0 WITH (duration = 4.5, ease = 'inOut');
UPDATE layers SET x = 1632 WHERE id = 'w1'        AT 1.0 WITH (duration = 4.5, ease = 'inOut');
UPDATE layers SET x = 1728 WHERE id = 'w2'        AT 1.0 WITH (duration = 4.5, ease = 'inOut');
UPDATE layers SET x = 1752 WHERE id = 'headlight' AT 1.0 WITH (duration = 4.5, ease = 'inOut');
UPDATE layers SET rotation = 1440 WHERE id IN ('w1', 'w2') AT 1.0 WITH (duration = 4.5, ease = 'linear');

-- ============================================================================
-- АКТ III: ДОМ, ВОРОТА И ЗАБОР ПОЯВЛЯЮТСЯ ПЕРЕД REVEAL (5.2 — 6.0)
-- ============================================================================
UPDATE layers SET opacity = 100 WHERE id = 'house' AT 5.2 WITH (duration = 0.4, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'roof_l' AT 5.35 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'roof_r' AT 5.4 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'cap_roof' AT 5.55 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'chimney' AT 5.5 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('win1', 'win2') AT 5.65 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'door' AT 5.75 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('gate_p1', 'gate_p2', 'gate_rail1', 'gate_rail2') AT 5.6 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('fpl1', 'fpl2', 'fprail', 'fp1', 'fp2', 'fp3', 'frail') AT 5.7 WITH (duration = 0.3, ease = 'out');

-- ============================================================================
-- АКТ IV: РОДИТЕЛИ МАШУТ, СОБАКА МЧИТСЯ К МАШИНЕ (5.9 — 10.1)
-- ============================================================================
UPDATE layers SET opacity = 100 WHERE id IN ('gp_body', 'gp_head', 'gp_hat') AT 5.9 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'gp_arm' AT 6.1 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id IN ('gm_body', 'gm_head', 'gm_scarf') AT 6.0 WITH (duration = 0.35, ease = 'out');
UPDATE layers SET opacity = 100 WHERE id = 'gm_arm' AT 6.2 WITH (duration = 0.3, ease = 'out');

-- Дедушка машет в сторону дороги
UPDATE layers SET rotation = -20 WHERE id = 'gp_arm' AT 6.6 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET rotation = 35  WHERE id = 'gp_arm' AT 7.2 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = -10 WHERE id = 'gp_arm' AT 7.9 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = 35  WHERE id = 'gp_arm' AT 8.6 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = 0   WHERE id = 'gp_arm' AT 9.3 WITH (duration = 0.6, ease = 'inOut');

-- Бабушка машет в свой ритм
UPDATE layers SET rotation = -30 WHERE id = 'gm_arm' AT 6.8 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET rotation = 30  WHERE id = 'gm_arm' AT 7.4 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = -15 WHERE id = 'gm_arm' AT 8.1 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = 30  WHERE id = 'gm_arm' AT 8.8 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET rotation = 0   WHERE id = 'gm_arm' AT 9.5 WITH (duration = 0.6, ease = 'inOut');

-- Собака выскакивает из-за дома и несётся к машине с прыжками
UPDATE layers SET opacity = 100 WHERE id IN ('dog_body', 'dog_head', 'dog_ear', 'dog_tail') AT 6.5 WITH (duration = 0.2, ease = 'out');
UPDATE layers SET x = 1800 WHERE id = 'dog_body' AT 6.6 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET x = 1772 WHERE id = 'dog_head' AT 6.6 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET x = 1766 WHERE id = 'dog_ear'  AT 6.6 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET x = 1824 WHERE id = 'dog_tail' AT 6.6 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET y = 748 WHERE id = 'dog_body' AT 6.6 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 772 WHERE id = 'dog_body' AT 6.9 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 748 WHERE id = 'dog_body' AT 7.2 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 766 WHERE id = 'dog_body' AT 7.5 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 732 WHERE id = 'dog_head' AT 6.6 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 756 WHERE id = 'dog_head' AT 6.9 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 732 WHERE id = 'dog_head' AT 7.2 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 750 WHERE id = 'dog_head' AT 7.5 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 720 WHERE id = 'dog_ear' AT 6.6 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 744 WHERE id = 'dog_ear' AT 6.9 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 720 WHERE id = 'dog_ear' AT 7.2 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 738 WHERE id = 'dog_ear' AT 7.5 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 738 WHERE id = 'dog_tail' AT 6.6 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 762 WHERE id = 'dog_tail' AT 6.9 WITH (duration = 0.3, ease = 'in');
UPDATE layers SET y = 738 WHERE id = 'dog_tail' AT 7.2 WITH (duration = 0.3, ease = 'out');
UPDATE layers SET y = 756 WHERE id = 'dog_tail' AT 7.5 WITH (duration = 0.3, ease = 'in');

-- ============================================================================
-- АКТ V: ОТКРЫТКА ВСПЛЫВАЕТ НАД ДОМОМ (7.4 — 8.4)
-- ============================================================================
UPDATE layers SET opacity = 80,  y = 260 WHERE id = 'card_shadow' AT 7.4 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 92,  y = 256 WHERE id = 'card'        AT 7.4 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 184 WHERE id = 'pill'        AT 7.7 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 186 WHERE id = 't_pill'      AT 7.7 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 238 WHERE id = 't_title'     AT 7.9 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 286 WHERE id = 't_msg1'      AT 8.15 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET opacity = 100, y = 314 WHERE id = 't_msg2'      AT 8.35 WITH (duration = 0.5, ease = 'out');

-- ============================================================================
-- АКТ VI: СОЛНЦЕ ИГРАЕТ, ПЕЧЬ ТОПИТСЯ, СНЕГ БЛЁСТИТ (8.0 — 10.8)
-- ============================================================================
UPDATE layers SET scale = 115, opacity = 55 WHERE id = 'sun_glow' AT 8.0 WITH (duration = 1.3, ease = 'inOut');
UPDATE layers SET scale = 100, opacity = 40 WHERE id = 'sun_glow' AT 9.3 WITH (duration = 1.3, ease = 'inOut');
UPDATE layers SET opacity = 85  WHERE id = 'win1' AT 8.0 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 100 WHERE id = 'win1' AT 8.4 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 85  WHERE id = 'win1' AT 9.0 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 100 WHERE id = 'win1' AT 9.4 WITH (duration = 0.4, ease = 'inOut');

UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp1' AT 8.2 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp1' AT 8.7 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp2' AT 8.4 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp2' AT 8.9 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp3' AT 8.6 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp3' AT 9.1 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp4' AT 8.8 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp4' AT 9.3 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp5' AT 9.0 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp5' AT 9.5 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp6' AT 8.3 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp6' AT 8.8 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp1' AT 9.4 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp1' AT 9.9 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp2' AT 9.6 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp2' AT 10.1 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 80,  scale = 140 WHERE id = 'sp3' AT 9.8 WITH (duration = 0.4, ease = 'inOut');
UPDATE layers SET opacity = 10,  scale = 100 WHERE id = 'sp3' AT 10.3 WITH (duration = 0.4, ease = 'inOut');

-- ============================================================================
-- ДЫМОК КЛУБИТСЯ (с 5.0, два цикла на клубок)
-- ============================================================================
UPDATE layers SET opacity = 28 WHERE id = 'smoke1' AT 5.0 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke1' AT 5.0 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke1' AT 6.2 WITH (duration = 1.0, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke1' AT 7.4 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET y = 386 WHERE id = 'smoke1' AT 7.4 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET opacity = 28 WHERE id = 'smoke1' AT 7.7 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke1' AT 7.7 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke1' AT 8.9 WITH (duration = 1.0, ease = 'linear');

UPDATE layers SET opacity = 28 WHERE id = 'smoke2' AT 5.6 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke2' AT 5.6 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke2' AT 6.8 WITH (duration = 1.0, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke2' AT 8.0 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET y = 386 WHERE id = 'smoke2' AT 8.0 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET opacity = 28 WHERE id = 'smoke2' AT 8.3 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke2' AT 8.3 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke2' AT 9.5 WITH (duration = 1.0, ease = 'linear');

UPDATE layers SET opacity = 28 WHERE id = 'smoke3' AT 6.2 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke3' AT 6.2 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke3' AT 7.4 WITH (duration = 1.0, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke3' AT 8.5 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET y = 386 WHERE id = 'smoke3' AT 8.5 WITH (duration = 0.1, ease = 'out');
UPDATE layers SET opacity = 28 WHERE id = 'smoke3' AT 8.7 WITH (duration = 0.5, ease = 'out');
UPDATE layers SET y = 300 WHERE id = 'smoke3' AT 8.7 WITH (duration = 2.1, ease = 'linear');
UPDATE layers SET opacity = 0 WHERE id = 'smoke3' AT 9.9 WITH (duration = 1.0, ease = 'linear');

-- ============================================================================
-- СНЕГОПАД ПО ВСЕМУ МИРУ (с 0.0)
-- ============================================================================
UPDATE layers SET y = 1020 WHERE id = 'fl1' AT 0.0 WITH (duration = 11.0, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl2' AT 0.0 WITH (duration = 9.5, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl3' AT 0.0 WITH (duration = 12.0, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl4' AT 0.0 WITH (duration = 10.5, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl5' AT 0.0 WITH (duration = 11.5, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl6' AT 0.0 WITH (duration = 9.0, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl7' AT 0.0 WITH (duration = 10.0, ease = 'linear');
UPDATE layers SET y = 1020 WHERE id = 'fl8' AT 0.0 WITH (duration = 8.5, ease = 'linear');
UPDATE layers SET x = 1000 WHERE id = 'fl3' AT 3.0 WITH (duration = 5.0, ease = 'inOut');
UPDATE layers SET x = 1900 WHERE id = 'fl6' AT 4.0 WITH (duration = 5.0, ease = 'inOut');

-- ============================================================================
-- ФИНАЛ: МЯГКОЕ РАСТВОРЕНИЕ (11.0 — 11.9), НЕБО ОСТАЁТСЯ
-- ============================================================================
UPDATE layers SET opacity = 0 WHERE id IN ('sun_glow', 'sun', 'cloud1', 'cloud2', 'cloud3', 'ground', 'road', 'bank1', 'bank2', 'bank3', 't1', 'cap1', 't2', 'cap2', 't3', 'cap3', 't4', 'cap4', 't5', 'cap5', 't6', 'cap6', 'house', 'roof_l', 'roof_r', 'cap_roof', 'chimney', 'win1', 'win2', 'door', 'gate_p1', 'gate_p2', 'gate_rail1', 'gate_rail2', 'fpl1', 'fpl2', 'fprail', 'fp1', 'fp2', 'fp3', 'frail', 'smoke1', 'smoke2', 'smoke3', 'gp_body', 'gp_head', 'gp_hat', 'gp_arm', 'gm_body', 'gm_head', 'gm_scarf', 'gm_arm', 'dog_body', 'dog_head', 'dog_ear', 'dog_tail', 'car_body', 'car_cabin', 'w1', 'w2', 'headlight', 'sp1', 'sp2', 'sp3', 'sp4', 'sp5', 'sp6', 'fl1', 'fl2', 'fl3', 'fl4', 'fl5', 'fl6', 'fl7', 'fl8', 'card_shadow', 'card', 'pill', 't_pill', 't_title', 't_msg1', 't_msg2') AT 11.0 WITH (duration = 0.9, ease = 'in');
