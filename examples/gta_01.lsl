-- ============================================================================
-- 🎬 GTA VI: ОДНА ДЕТАЛЬНАЯ СЦЕНА — МОНТАЖ КРУПНОСТИ ПЛАНОВ (LSL STUDIO)
-- Формат: 540x960 (9:16), 60 fps, длительность 14.0 с
-- Планы: Дальний -> 2-й средний -> Крупный -> Деталь -> 1-й средний -> Общий
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 14.0;

-- 1. ДАЛЬНИЙ ПЛАН [0.0 — 2.4s]: панорама улицы, отеля и авто
AT 0.0 UPDATE camera SET x = 270, y = 480, zoom = 1.0;

-- ============================================================================
-- СЛОЙ 1: ЗАКАТНОЕ НЕБО, СОЛНЦЕ И ОБЛАКА
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('sky_1',      'rect',    270, 160, 620, 340, '#2E1065', 0, 100),
  ('sky_2',      'rect',    270, 380, 620, 240, '#BE185D', 0, 100),
  ('sky_3',      'rect',    270, 540, 620, 200, '#F97316', 0, 100),
  ('sky_4',      'rect',    270, 640, 620, 140, '#FACC15', 0, 100),
  ('sun_glow',   'ellipse', 140, 510, 240, 240, '#FEF08A', 0, 25),
  ('sun_core',   'ellipse', 140, 510, 130, 130, '#FEF9C3', 0, 95);

-- Чайки в небе (SVG path)
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('birds', 'path', 210, 360, 70, 24, '#3B0764', 85, 'M2 14 Q14 2 26 12 Q38 2 50 14 Q38 8 26 16 Q14 8 2 14 Z M64 22 Q74 12 84 20 Q94 12 104 22 Q94 17 84 23 Q74 17 64 22 Z');

-- ============================================================================
-- СЛОЙ 2: ОТЕЛЬ АР-ДЕКО И НЕОНОВЫЕ ВЫВЕСКИ НА ЗАДНЕМ ПЛАНЕ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('hotel_back',  'rect', 430, 495, 220, 340, '#312E81', 4, 100),
  ('hotel_main',  'rect', 375, 525, 190, 290, '#4338CA', 4, 100),
  ('hotel_wing',  'rect', 475, 555, 130, 230, '#3730A3', 2, 100),
  ('hotel_spire', 'rect', 375, 345, 14,  80,  '#6366F1', 2, 100),
  ('neon_line_1', 'rect', 375, 395, 160, 5,   '#38BDF8', 2, 100),
  ('neon_line_2', 'rect', 375, 412, 140, 4,   '#F472B6', 2, 100),
  ('neon_sign_bg','rect', 445, 585, 76,  42,  '#1E1B4B', 4, 100),
  ('win_1',       'rect', 330, 465, 22,  36,  '#FDE047', 2, 75),
  ('win_2',       'rect', 375, 465, 22,  36,  '#38BDF8', 2, 70),
  ('win_3',       'rect', 420, 465, 22,  36,  '#FDE047', 2, 75),
  ('win_4',       'rect', 330, 525, 22,  36,  '#F472B6', 2, 65),
  ('win_5',       'rect', 375, 525, 22,  36,  '#FDE047', 2, 80);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('neon_txt_1', 'text', 'OCEAN', 'Montserrat', 445, 578, 12, '#38BDF8', 100),
  ('neon_txt_2', 'text', 'HOTEL', 'Montserrat', 445, 594, 12, '#F472B6', 100);

-- ============================================================================
-- СЛОЙ 3: ПАЛЬМЫ И ДОРОГА ОУШЕН-ДРАЙВ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('palm_far_1', 'path', 72,  435, 175, 380, '#1E1035', 95, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z'),
  ('palm_far_2', 'path', 495, 420, 195, 420, '#170B2B', 95, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z');

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('sidewalk',   'rect', 270, 685, 620, 26,  '#4C1D95', 0, 100),
  ('road_base',  'rect', 270, 830, 620, 270, '#140F26', 0, 100),
  ('road_glow',  'rect', 270, 740, 620, 60,  '#2E1065', 0, 45),
  ('road_line_1','rect', 95,  885, 90,  6,   '#FBBF24', 2, 85),
  ('road_line_2','rect', 270, 885, 90,  6,   '#FBBF24', 2, 85),
  ('road_line_3','rect', 445, 885, 90,  6,   '#FBBF24', 2, 85);

-- ============================================================================
-- СЛОЙ 4: ДЕТАЛИЗИРОВАННЫЙ МАСЛКАР (кузов, капот с бликом, решётка, двойные фары)
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('car_shadow', 'path', 215, 818, 370, 34,  '#05030A', 90, 'M10 15 Q180 0 360 15 Q180 30 10 15 Z'),
  ('car_body',   'path', 205, 735, 340, 145, '#1E293B', 100,'M8 125 L16 74 L48 64 L88 18 L215 18 L255 62 L326 70 L334 125 L302 125 A26 26 0 0 1 250 125 L94 125 A26 26 0 0 1 42 125 Z'),
  ('car_hood_hl','path', 255, 702, 165, 22,  '#F472B6', 65, 'M0 14 L145 2 L162 12 L12 20 Z'),
  ('car_glass',  'path', 165, 688, 128, 34,  '#0F172A', 100,'M12 32 L38 4 L106 4 L124 32 Z'),
  ('car_grille', 'path', 285, 744, 145, 32,  '#090D16', 100,'M4 6 L140 6 L136 28 L8 28 Z');

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('car_bumper', 'rect',    282, 766, 156, 9,  '#94A3B8', 3, 100),
  ('hl_1',       'ellipse', 236, 744, 18,  18, '#FEF08A', 0, 100),
  ('hl_2',       'ellipse', 258, 744, 18,  18, '#FEF9C3', 0, 100),
  ('hl_3',       'ellipse', 326, 744, 16,  16, '#FEF08A', 0, 100),
  ('hl_4',       'ellipse', 345, 744, 16,  16, '#FEF9C3', 0, 100),
  ('wheel_f',    'ellipse', 198, 782, 62,  62, '#090D16', 0, 100),
  ('rim_f',      'ellipse', 198, 782, 34,  34, '#CBD5E1', 0, 100),
  ('wheel_b',    'ellipse', 72,  774, 54,  54, '#090D16', 0, 100),
  ('rim_b',      'ellipse', 72,  774, 28,  28, '#94A3B8', 0, 100);

-- ============================================================================
-- СЛОЙ 5: ГЕРОИ НА КАПОТЕ (детализированы для Крупного плана и Детали)
-- ============================================================================
-- Девушка (розовый топ, джинсы, волосы) и парень (белая майка, лицо, глаза/очки)
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('girl_hair',  'path', 216, 568, 44, 68,  '#1C1018', 100, 'M22 4 C36 4 42 18 40 36 C42 50 34 64 20 66 C8 64 2 48 6 30 C8 14 14 4 22 4 Z'),
  ('girl_body',  'path', 218, 638, 48, 86,  '#EC4899', 100, 'M12 4 L34 4 L44 38 L38 82 L8 82 L4 42 Z'),
  ('girl_jeans', 'path', 226, 704, 46, 68,  '#1D4ED8', 100, 'M6 2 L38 2 L44 64 L26 64 L20 26 L12 64 L2 64 Z'),
  ('guy_torso',  'path', 268, 626, 62, 92,  '#F8FAFC', 100, 'M14 4 L48 4 L58 34 L54 88 L8 88 L4 34 Z'),
  ('guy_pants',  'path', 272, 718, 64, 86,  '#3F6212', 100, 'M8 2 L54 2 L60 82 L36 82 L30 34 L22 82 L4 82 Z'),
  ('guy_arm',    'path', 294, 638, 28, 66,  '#D97757', 100, 'M6 4 L22 4 L26 38 L16 64 L4 60 L10 34 Z'),
  ('guy_gun',    'path', 268, 682, 22, 18,  '#0F172A', 100, 'M2 2 L20 2 L20 8 L10 8 L8 16 L2 16 Z');

-- Голова, причёска и детали лица парня (для Крупного плана и Детали)
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('girl_face',  'ellipse', 218, 566, 22, 28, '#C86D51', 0, 100),
  ('guy_neck',   'rect',    268, 580, 16, 16, '#C86D51', 4, 100),
  ('guy_face',   'ellipse', 268, 558, 28, 36, '#D97757', 0, 100),
  ('guy_hair',   'rect',    268, 542, 30, 12, '#1C1917', 5, 100),
  ('guy_brow_l', 'rect',    262, 552, 9,  2.5,'#1C1917', 1, 100),
  ('guy_brow_r', 'rect',    274, 552, 9,  2.5,'#1C1917', 1, 100),
  ('eye_l_w',    'ellipse', 262, 556, 7,  4,  '#FFFFFF', 0, 100),
  ('eye_r_w',    'ellipse', 274, 556, 7,  4,  '#FFFFFF', 0, 100),
  ('eye_l_p',    'ellipse', 262, 556, 3.5,3.5,'#0F172A', 0, 100),
  ('eye_r_p',    'ellipse', 274, 556, 3.5,3.5,'#0F172A', 0, 100);

-- ============================================================================
-- СЛОЙ 6: ФИКСИРОВАННЫЙ HUD С НАЗВАНИЕМ КРУПНОСТИ ПЛАНА (по референсу)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity) VALUES
  ('hud_bg', 'rect', true, 270, 888, 320, 40, '#090514', 20, 82);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity) VALUES
  ('hud_plan', 'text', true, 'ДАЛЬНИЙ ПЛАН', 'JetBrains Mono', 270, 895, 16, '#FDE047', 100);

-- Финальный логотип (появляется на последнем Общем плане)
INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('end_vi',   'text', true, 'VI',    'Playfair Display', 270, 250, 150, '#EC4899', 0, 90),
  ('end_t1_s', 'text', true, 'grand', 'Montserrat',       273, 188, 48,  '#090514', 0, 90),
  ('end_t1',   'text', true, 'grand', 'Montserrat',       270, 185, 48,  '#FFFFFF', 0, 90),
  ('end_t2_s', 'text', true, 'theft', 'Montserrat',       273, 232, 48,  '#090514', 0, 90),
  ('end_t2',   'text', true, 'theft', 'Montserrat',       270, 229, 48,  '#FFFFFF', 0, 90),
  ('end_t3_s', 'text', true, 'auto',  'Montserrat',       273, 276, 48,  '#090514', 0, 90),
  ('end_t3',   'text', true, 'auto',  'Montserrat',       270, 273, 48,  '#FFFFFF', 0, 90);

-- ============================================================================
-- 7. МОНТАЖНЫЙ ЛИСТ КАМЕРЫ (КАТЫ И НАЕЗДЫ ПО ШКАЛЕ КРУПНОСТИ)
-- ============================================================================

-- 1) [0.0 — 2.4s] ДАЛЬНИЙ ПЛАН: лёгкий наезд на панораму Оушен-Драйв
AT 0.2 UPDATE camera SET x = 270, y = 490, zoom = 1.12 WITH (duration = 2.1, ease = 'linear');
AT 0.0 UPDATE layers SET x = 235 WHERE id = 'birds' WITH (duration = 14.0, ease = 'linear');

-- 2) [2.4 — 4.6s] КАТ НА 2-Й СРЕДНИЙ ПЛАН (герои в полный рост и маслкар) + наезд
AT 2.4 UPDATE camera SET x = 245, y = 665, zoom = 2.05;
AT 2.4 UPDATE layers SET text = '2-Й СРЕДНИЙ ПЛАН', color = '#38BDF8' WHERE id = 'hud_plan';
AT 2.45 UPDATE camera SET x = 245, y = 655, zoom = 2.25 WITH (duration = 2.1, ease = 'linear');

-- 3) [4.6 — 6.8s] РЕЗКИЙ КАТ НА КРУПНЫЙ ПЛАН (голова и плечи героев) + наезд
AT 4.6 UPDATE camera SET x = 248, y = 568, zoom = 4.6;
AT 4.6 UPDATE layers SET text = 'КРУПНЫЙ ПЛАН', color = '#F472B6' WHERE id = 'hud_plan';
AT 4.65 UPDATE camera SET x = 252, y = 564, zoom = 5.1 WITH (duration = 2.1, ease = 'linear');
-- 4) [6.8 — 9.0s] КАТ НА ДЕТАЛЬ (глаза персонажа крупно) + микро-зум
AT 6.8 UPDATE camera SET x = 268, y = 556, zoom = 8.5;
AT 6.8 UPDATE layers SET text = 'ДЕТАЛЬ (ГЛАЗА)', color = '#FACC15' WHERE id = 'hud_plan';
AT 6.85 UPDATE camera SET x = 268, y = 556, zoom = 9.4 WITH (duration = 2.1, ease = 'linear');
-- 5) [9.0 — 11.2s] КАТ НА 1-Й СРЕДНИЙ ПЛАН (по пояс, акцент на пистолет и капот)
AT 9.0 UPDATE camera SET x = 255, y = 635, zoom = 3.1;
AT 9.0 UPDATE layers SET text = '1-Й СРЕДНИЙ ПЛАН', color = '#A78BFA' WHERE id = 'hud_plan';
AT 9.05 UPDATE camera SET x = 262, y = 640, zoom = 3.35 WITH (duration = 2.1, ease = 'linear');
-- 6) [11.2 — 14.0s] ПЛАВНЫЙ ОТЪЕЗД НА ОБЩИЙ ПЛАН + логотип GTA VI
AT 11.2 UPDATE camera SET x = 270, y = 480, zoom = 1.0 WITH (duration = 1.3, ease = [0.22, 1, 0.36, 1]);
AT 11.2 UPDATE layers SET text = 'ОБЩИЙ ПЛАН', color = '#4ADE80' WHERE id = 'hud_plan';
AT 12.1 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 'end_%' WITH (duration = 0.6, ease = [0.22, 1, 0.36, 1]);
