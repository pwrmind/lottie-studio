-- ============================================================================
-- 🌴 VICE CITY / GTA VI — ПОСТЕР-АНИМАЦИЯ (LSL STUDIO)
-- Формат: 540x960 (9:16), 60 fps, длительность 18.0 с
-- Сетка 4 фреймов с чёрными разделителями + SVG path (пальмы, авто, вертолёт)
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 18.0;

AT 0.0 UPDATE camera SET x = 270, y = 480, zoom = 1.0;

-- ============================================================================
-- 0. ЧЁРНАЯ ПОДЛОЖКА КОМИКСНОЙ СЕТКИ
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity) VALUES
  ('poster_bg', 'rect', false, 270, 480, 900, 1500, '#0B0914', 0, 100);

-- ============================================================================
-- 1. ФРЕЙМ 1 (Верхний левый: x=142, y=248, 244x444) — ЗАКАТ И ПАЛЬМЫ ОУШЕН-ДРАЙВ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity, scale) VALUES
  ('f1_sky_top',  'rect',    142, 137, 244, 222, '#3B1D5E', 0, 0, 100),
  ('f1_sky_mid',  'rect',    142, 260, 244, 160, '#C84B78', 0, 0, 100),
  ('f1_sky_bot',  'rect',    142, 370, 244, 140, '#F59E0B', 0, 0, 100),
  ('f1_sun',      'ellipse', 155, 290, 110, 110, '#FDE047', 0, 0, 100),
  ('f1_hotel_1',  'rect',    75,  355, 76,  190, '#6D28D9', 0, 0, 100),
  ('f1_hotel_2',  'rect',    135, 375, 64,  150, '#8B5CF6', 0, 0, 100),
  ('f1_hotel_3',  'rect',    210, 365, 82,  170, '#4C1D95', 0, 0, 100),
  ('f1_neon_1',   'rect',    75,  295, 52,  6,   '#38BDF8', 0, 0, 100),
  ('f1_neon_2',   'rect',    210, 310, 56,  6,   '#F472B6', 0, 0, 100),
  ('f1_road',     'rect',    142, 448, 244, 44,  '#1E1B2E', 0, 0, 100);

-- Силуэты пальм (SVG path) на переднем плане Фрейма 1
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('f1_palm_l', 'path', 78,  325, 115, 220, '#120A24', 0, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z'),
  ('f1_palm_r', 'path', 208, 340, 96,  190, '#1A0F33', 0, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z');

-- ============================================================================
-- 2. ФРЕЙМ 2 (Верхний правый: x=398, y=248, 244x444) — НОЧНОЙ МАСЛКАР И НЕОН
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('f2_bg',      'rect', 398, 248, 244, 444, '#130926', 0, 0),
  ('f2_glow',    'rect', 398, 310, 244, 130, '#701A75', 0, 0),
  ('f2_street',  'rect', 398, 415, 244, 110, '#1E1633', 0, 0),
  ('f2_stripe1', 'rect', 350, 385, 80,  4,   '#06B6D4', 0, 0),
  ('f2_stripe2', 'rect', 445, 435, 90,  4,   '#EC4899', 0, 0);

-- Силуэт спорткара (SVG path) + фары
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('f2_car_body',  'path', 398, 355, 200, 76, '#090514', 0, 'M5 62 L12 42 L34 36 L58 14 L132 14 L164 36 L194 42 L198 62 L182 62 A16 16 0 0 1 150 62 L54 62 A16 16 0 0 1 22 62 Z'),
  ('f2_car_glass', 'path', 394, 338, 92,  20, '#38BDF8', 0, 'M10 18 L30 2 L76 2 L92 18 Z'),
  ('f2_car_hl_1',  'ellipse', 322, 362, 16, 10, '#FEF08A', 0, 0),
  ('f2_car_hl_2',  'ellipse', 474, 362, 16, 10, '#F43F5E', 0, 0);

-- ============================================================================
-- 3. ФРЕЙМ 3 (Нижний левый: x=142, y=712, 244x444) — ПАЛЬМОВАЯ УЛИЦА И КАБРИОЛЕТ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('f3_bg',       'rect', 142, 712, 244, 444, '#1E1035', 0, 0),
  ('f3_horizon',  'rect', 142, 680, 244, 150, '#DB2777', 0, 0),
  ('f3_asphalt',  'rect', 142, 835, 244, 198, '#141122', 0, 0),
  ('f3_road_l',   'rect', 105, 845, 50,  5,   '#FACC15', 0, 0),
  ('f3_road_r',   'rect', 185, 845, 50,  5,   '#FACC15', 0, 0);

INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('f3_palm_1', 'path', 66,  675, 85, 175, '#0D071A', 0, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z'),
  ('f3_palm_2', 'path', 218, 675, 85, 175, '#0D071A', 0, 'M45 100 L52 100 L48 42 C32 34 15 38 5 48 C18 32 34 28 46 34 C30 20 14 18 2 24 C18 12 36 14 48 26 C44 10 34 2 22 0 C38 0 48 10 52 24 C58 10 70 2 84 4 C70 8 60 16 55 28 C70 20 86 22 98 32 C84 28 68 30 56 38 C72 36 86 42 95 54 C80 46 66 44 53 44 Z'),
  ('f3_cruiser','path', 120, 795, 145, 52, '#F472B6', 0, 'M4 44 L10 26 L44 22 L62 12 L116 12 L134 24 L156 28 L160 44 L144 44 A12 12 0 0 1 120 44 L44 44 A12 12 0 0 1 20 44 Z');

-- ============================================================================
-- 4. ФРЕЙМ 4 (Нижний правый: x=398, y=712, 244x444) — НОЧНОЙ ГОРОД И ВЕРТОЛЁТ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('f4_bg',      'rect', 398, 712, 244, 444, '#0F172A', 0, 0),
  ('f4_moon',    'ellipse', 455, 570, 64, 64, '#FDE68A', 0, 0),
  ('f4_b1',      'rect', 318, 825, 52,  218, '#1E293B', 0, 0),
  ('f4_b2',      'rect', 376, 805, 58,  258, '#334155', 0, 0),
  ('f4_b3',      'rect', 438, 835, 54,  198, '#1E293B', 0, 0),
  ('f4_b4',      'rect', 492, 815, 48,  238, '#0F172A', 0, 0);

-- Вертолёт (SVG path) и луч прожектора
INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('f4_beam',   'path', 375, 725, 110, 170, '#FEF08A', 0, 'M65 0 L75 0 L100 100 L0 100 Z'),
  ('f4_heli',   'path', 405, 625, 128, 52,  '#090D16', 0, 'M10 12 L95 12 L95 16 L60 16 L60 22 L84 22 C96 22 104 30 104 38 C104 44 96 48 84 48 L52 48 L22 36 L6 42 L2 36 L16 28 L52 28 L52 16 L10 16 Z M44 54 L92 54 L92 58 L44 58 Z');

-- ============================================================================
-- 5. ЧЁРНАЯ РАМКА-СЕТКА ПОВЕРХ ВСЕХ ФРЕЙМОВ (чтобы края не вылезали при движении)
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('grid_top',   'rect', 270, 13,  540, 26,  '#0B0914', 0, 100),
  ('grid_bot',   'rect', 270, 947, 540, 26,  '#0B0914', 0, 100),
  ('grid_left',  'rect', 10,  480, 20,  960, '#0B0914', 0, 100),
  ('grid_right', 'rect', 530, 480, 20,  960, '#0B0914', 0, 100),
  ('grid_mid_v', 'rect', 270, 480, 12,  960, '#0B0914', 0, 100),
  ('grid_mid_h', 'rect', 270, 480, 540, 12,  '#0B0914', 0, 100);

-- ============================================================================
-- 6. ЦЕНТРАЛЬНЫЙ ЛОГОТИП В СТИЛЕ GTA (многослойная обводка через сдвиг текста)
-- ============================================================================
INSERT INTO layers (id, type, text, font, x, y, size, color, opacity, scale) VALUES
  ('logo_vi',      'text', 'VI',          'Playfair Display', 270, 495, 165, '#EC4899', 0, 80),
  ('logo_t1_sh',   'text', 'grand',       'Montserrat',       274, 424, 58,  '#0B0914', 0, 80),
  ('logo_t1',      'text', 'grand',       'Montserrat',       270, 420, 58,  '#FFFFFF', 0, 80),
  ('logo_t2_sh',   'text', 'theft',       'Montserrat',       274, 474, 58,  '#0B0914', 0, 80),
  ('logo_t2',      'text', 'theft',       'Montserrat',       270, 470, 58,  '#FFFFFF', 0, 80),
  ('logo_t3_sh',   'text', 'auto',        'Montserrat',       274, 524, 58,  '#0B0914', 0, 80),
  ('logo_t3',      'text', 'auto',        'Montserrat',       270, 520, 58,  '#FFFFFF', 0, 80),
  ('logo_sub',     'text', 'VICE BEACH EDITION', 'JetBrains Mono', 270, 568, 15, '#FDE047', 0, 100);

-- ============================================================================
-- 7. ТАЙМЛАЙН АНИМАЦИИ: СБОРКА СЕТКИ + КАМЕРА (ЗУМ -> ОТЪЕЗД -> ЗУМ)
-- ============================================================================

-- [0.2 — 1.4s] Поочерёдное проявление 4 фреймов и центрального логотипа
AT 0.2 UPDATE layers SET opacity = 100 WHERE id LIKE 'f1_%' WITH (duration = 0.45, ease = 'out');
AT 0.4 UPDATE layers SET opacity = 100 WHERE id LIKE 'f2_%' WITH (duration = 0.45, ease = 'out');
AT 0.6 UPDATE layers SET opacity = 100 WHERE id LIKE 'f3_%' WITH (duration = 0.45, ease = 'out');
AT 0.8 UPDATE layers SET opacity = 100 WHERE id LIKE 'f4_%' WITH (duration = 0.45, ease = 'out');
AT 0.8 UPDATE layers SET opacity = 28  WHERE id = 'f4_beam' WITH (duration = 0.45, ease = 'out');

AT 1.0 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 'logo_%' WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);

-- [1.6 — 4.5s] КАДР 1: ЗУМ на закат с пальмами (x=142, y=248) + лёгкий дрейф
AT 1.6 UPDATE layers SET opacity = 0 WHERE id LIKE 'logo_%' WITH (duration = 0.35, ease = 'in');
AT 1.6 UPDATE camera SET x = 135, y = 265, zoom = 1.95 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 2.6 UPDATE camera SET x = 152, y = 240, zoom = 2.08 WITH (duration = 1.8, ease = 'linear');
AT 2.0 UPDATE layers SET y = 315, scale = 108 WHERE id = 'f1_sun' WITH (duration = 2.4, ease = 'out');

-- [4.5 — 5.3s] ОТЪЕЗД камеры на общий план сетки
AT 4.5 UPDATE camera SET x = 270, y = 480, zoom = 1.0 WITH (duration = 0.8, ease = 'inOut');

-- [5.3 — 8.3s] КАДР 2: ЗУМ на ночной маслкар (x=398, y=248) + движение авто
AT 5.3 UPDATE camera SET x = 398, y = 285, zoom = 1.95 WITH (duration = 0.9, ease = [0.22, 1, 0.36, 1]);
AT 6.2 UPDATE camera SET x = 408, y = 275, zoom = 2.10 WITH (duration = 2.0, ease = 'linear');
AT 5.6 UPDATE layers SET scale = 108, y = 360 WHERE id LIKE 'f2_car_%' WITH (duration = 2.2, ease = 'out');
-- [8.3 — 9.1s] ОТЪЕЗД камеры на общий план сетки
AT 8.3 UPDATE camera SET x = 270, y = 480, zoom = 1.0 WITH (duration = 0.8, ease = 'inOut');
-- [9.1 — 12.1s] КАДР 3: ЗУМ на пальмовую аллею и кабриолет (x=142, y=712)
AT 9.1  UPDATE camera SET x = 135, y = 735, zoom = 1.95 WITH (duration = 0.9, ease = [0.22, 1, 0.36, 1]);
AT 10.0 UPDATE camera SET x = 155, y = 725, zoom = 2.08 WITH (duration = 2.0, ease = 'linear');
AT 9.3  UPDATE layers SET x = 168 WHERE id = 'f3_cruiser' WITH (duration = 2.5, ease = 'inOut');
-- [12.1 — 12.9s] ОТЪЕЗД камеры на общий план сетки
AT 12.1 UPDATE camera SET x = 270, y = 480, zoom = 1.0 WITH (duration = 0.8, ease = 'inOut');
-- [12.9 — 15.8s] КАДР 4: ЗУМ на ночной город и вертолёт (x=398, y=712)
AT 12.9 UPDATE camera SET x = 398, y = 695, zoom = 1.95 WITH (duration = 0.9, ease = [0.22, 1, 0.36, 1]);
AT 13.8 UPDATE camera SET x = 392, y = 680, zoom = 2.08 WITH (duration = 1.9, ease = 'linear');
AT 13.1 UPDATE layers SET x = 385, y = 615, rotation = -6 WHERE id = 'f4_heli' WITH (duration = 2.4, ease = 'inOut');
AT 13.1 UPDATE layers SET x = 355, y = 715, rotation = -6 WHERE id = 'f4_beam' WITH (duration = 2.4, ease = 'inOut');
-- [15.8 — 18.0s] ФИНАЛЬНЫЙ ОТЪЕЗД и возвращение логотипа постера
AT 15.8 UPDATE camera SET x = 270, y = 480, zoom = 1.0 WITH (duration = 1.0, ease = [0.22, 1, 0.36, 1]);
AT 16.3 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 'logo_%' WITH (duration = 0.6, ease = [0.22, 1, 0.36, 1]);
