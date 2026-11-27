-- ============================================================================
-- 🧠 «РЕФАКТОРИНГ МЫСЛЕНИЯ» — приветственная анимация · v7 (Lifecycle & Clean DOM)
-- Лендинг: cognitive-refactoring.ru · Алексей Бабанов · КПТ для IT и фаундеров
--
-- ПАЛИТРА (Darcula):
--   фон      #1E1F22 · стены сцен #232529 · панели #2B2D31
--   терминал #0B0D12 · шапка окна #14161B · границы #393B40
--   текст    #FFFFFF заголовки · #A9B7C6 основной · #7A7E85 комментарии
--   акценты  #CC7832 оранжевый · #FF79C6 розовый · #6A8759 зелёный OK
--            #FF5555 ошибки · diff: + #A2C48D / - #FF8A8A
-- ШРИФТЫ: Roboto Condensed (заголовки) · Source Code Pro (код, логи, плашки)
-- СЕТКА 9:16 (k=0.5 от 1080x1920): safe zone x 35–505, y 75–770;
--   заголовки 38–46 · основной 15–18 · минимум читаемости 15
-- Формат: 540x960 (9:16), fps 60, длительность 32.5 с
-- Локации: С1 x=350 терминал · С2 x=1200 карта багов · С3 x=2050 git diff
--          С4 x=2900 протоколы · С5 x=3750 CTA run_session
-- Переходы: панорама → кат → панорама → кат
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 32.5;

-- Стартовая камера: Сцена 1
AT 0.0 UPDATE camera SET x = 350, y = 480, zoom = 1.0;

-- ============================================================================
-- 1. БАЗОВЫЙ ХОЛСТ И ФИКСИРОВАННЫЙ HUD (живут весь ролик в Safe Zone)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('world_bg',  'rect', false, 2050, 480, 4500, 1300, '#1E1F22', 0, 100, 100),
  ('hud_track', 'rect', true,  270,  758, 470,  6,    '#2B2D31', 3, 100, 100),
  ('hud_fill',  'rect', true,  270,  758, 10,   6,    '#CC7832', 3, 100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('hud_badge', 'text', true, '// cognitive_debugging', 'Source Code Pro', 148, 96, 15, '#FF79C6', 0, 100),
  ('hud_scene', 'text', true, '01 · терминал',          'Source Code Pro', 415, 96, 15, '#7A7E85', 0, 100);

AT 0.3 UPDATE layers SET opacity = 100 WHERE id IN ('hud_badge', 'hud_scene') WITH (duration = 0.5, ease = 'out');
AT 0.2 UPDATE layers SET width = 470 WHERE id = 'hud_fill' WITH (duration = 31.9, ease = 'linear');

-- ============================================================================
-- 2. СЦЕНА 1 [0.0 — 9.6] терминал: построчный вывод строго внутри окна
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s1_wall',   'rect',    false, 350, 480, 620, 1000, '#232529', 0,  100, 100),
  ('s1_glow_p', 'ellipse', false, 520, 170, 480, 300,  '#FF79C6', 0,  6,   100),
  ('s1_glow_o', 'ellipse', false, 180, 560, 420, 320,  '#CC7832', 0,  6,   100),
  ('s1_win',    'rect',    false, 350, 335, 454, 324,  '#393B40', 14, 100, 100),
  ('s1_win_i',  'rect',    false, 350, 335, 450, 320,  '#0B0D12', 12, 100, 100),
  ('s1_tbar',   'rect',    false, 350, 195, 454, 42,   '#14161B', 14, 100, 100),
  ('s1_dot1',   'ellipse', false, 155, 195, 11,  11,   '#393B40', 0,  100, 100),
  ('s1_dot2',   'ellipse', false, 175, 195, 11,  11,   '#393B40', 0,  100, 100),
  ('s1_dot3',   'ellipse', false, 195, 195, 11,  11,   '#393B40', 0,  100, 100),
  ('s1_sess',   'ellipse', false, 555, 195, 8,   8,    '#6A8759', 0,  100, 100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
  ('s1_lab',    'text', false, '// 01 — точка входа',              'Source Code Pro',  350, 134, 15, '#FF79C6', 0,   100),
  ('s1_prompt', 'text', false, '$',                                'Source Code Pro',  154, 248, 16, '#FF79C6', 0,   100),
  ('s1_cmd',    'text', false, '',                                 'Source Code Pro',  180, 248, 16, '#FFFFFF', 100, 100),
  ('s1_l2',     'text', false, '',                                 'Source Code Pro',  294, 290, 15, '#7A7E85', 100, 100),
  ('s1_l3',     'text', false, '',                                 'Source Code Pro',  330, 330, 15, '#A9B7C6', 100, 100),
  ('s1_l4',     'text', false, '',                                 'Source Code Pro',  276, 370, 15, '#6A8759', 100, 100),
  ('s1_h1a',    'text', false, 'РЕФАКТОРИНГ',                      'Roboto Condensed', 350, 595, 46, '#FFFFFF', 0,   100),
  ('s1_h1b',    'text', false, 'МЫШЛЕНИЯ',                         'Roboto Condensed', 350, 648, 46, '#FFFFFF', 0,   100),
  ('s1_typer',  'text', false, '',                                 'Source Code Pro',  350, 692, 18, '#CC7832', 100, 100),
  ('s1_tag',    'text', false, '// без эзотерики · без абонементов', 'Source Code Pro',  350, 728, 15, '#7A7E85', 0,   100);

AT 0.3 UPDATE layers SET opacity = 100 WHERE id IN ('s1_prompt', 's1_lab') WITH (duration = 0.4, ease = 'out');

-- Посимвольная печать команды внутри терминала
AT 0.80 UPDATE layers SET text = '_',                          x = 180.0 WHERE id = 's1_cmd';
AT 0.92 UPDATE layers SET text = './_',                        x = 189.6 WHERE id = 's1_cmd';
AT 1.04 UPDATE layers SET text = './co_',                      x = 199.2 WHERE id = 's1_cmd';
AT 1.16 UPDATE layers SET text = './cogn_',                    x = 208.8 WHERE id = 's1_cmd';
AT 1.28 UPDATE layers SET text = './cognit_',                  x = 218.4 WHERE id = 's1_cmd';
AT 1.40 UPDATE layers SET text = './cognitiv_',                x = 228.0 WHERE id = 's1_cmd';
AT 1.52 UPDATE layers SET text = './cognitive__',              x = 237.6 WHERE id = 's1_cmd';
AT 1.64 UPDATE layers SET text = './cognitive_re_',            x = 247.2 WHERE id = 's1_cmd';
AT 1.76 UPDATE layers SET text = './cognitive_refa_',          x = 256.8 WHERE id = 's1_cmd';
AT 1.88 UPDATE layers SET text = './cognitive_refact_',        x = 266.4 WHERE id = 's1_cmd';
AT 2.00 UPDATE layers SET text = './cognitive_refactor_',      x = 276.0 WHERE id = 's1_cmd';
AT 2.12 UPDATE layers SET text = './cognitive_refactorin_',    x = 285.6 WHERE id = 's1_cmd';
AT 2.24 UPDATE layers SET text = './cognitive_refactoring._',  x = 295.2 WHERE id = 's1_cmd';
AT 2.36 UPDATE layers SET text = './cognitive_refactoring.sh_', x = 304.8 WHERE id = 's1_cmd';
AT 2.90 UPDATE layers SET text = './cognitive_refactoring.sh',  x = 300.0 WHERE id = 's1_cmd';
AT 3.15 UPDATE layers SET text = './cognitive_refactoring.sh_', x = 304.8 WHERE id = 's1_cmd';
AT 3.40 UPDATE layers SET text = './cognitive_refactoring.sh',  x = 300.0 WHERE id = 's1_cmd';

-- Мгновенный вывод строк лога
AT 2.60 UPDATE layers SET text = '> инициализация mind_debugger...'          WHERE id = 's1_l2';
AT 2.95 UPDATE layers SET text = 'scan: выгорание · прокрастинация · релиз'  WHERE id = 's1_l3';
AT 3.30 UPDATE layers SET text = '[ OK ] mind_debugger запущен'              WHERE id = 's1_l4';

-- Заголовок и ротатор аудитории
AT 3.9 UPDATE layers SET opacity = 100, y = 575 WHERE id = 's1_h1a' WITH (duration = 0.5, ease = 'out');
AT 3.9 UPDATE layers SET opacity = 100, y = 628 WHERE id = 's1_h1b' WITH (duration = 0.5, ease = 'out');
AT 4.2 UPDATE layers SET opacity = 100          WHERE id = 's1_tag' WITH (duration = 0.4, ease = 'out');

AT 4.40 UPDATE layers SET text = '_'                         WHERE id = 's1_typer';
AT 4.55 UPDATE layers SET text = '> для IT_'                 WHERE id = 's1_typer';
AT 4.70 UPDATE layers SET text = '> для IT-спец_'            WHERE id = 's1_typer';
AT 4.85 UPDATE layers SET text = '> для IT-специали_'        WHERE id = 's1_typer';
AT 5.00 UPDATE layers SET text = '> для IT-специалисто_'     WHERE id = 's1_typer';
AT 5.20 UPDATE layers SET text = '> для IT-специалистов'     WHERE id = 's1_typer';
AT 5.55 UPDATE layers SET text = '> для IT-специалистов_'    WHERE id = 's1_typer';
AT 5.90 UPDATE layers SET text = '> для IT-специалистов'     WHERE id = 's1_typer';
AT 6.20 UPDATE layers SET text = '> для IT-специал_'         WHERE id = 's1_typer';
AT 6.40 UPDATE layers SET text = '> для _'                   WHERE id = 's1_typer';
AT 6.65 UPDATE layers SET text = '> для созд_'               WHERE id = 's1_typer';
AT 6.85 UPDATE layers SET text = '> для создател_'           WHERE id = 's1_typer';
AT 7.05 UPDATE layers SET text = '> для создателей_'         WHERE id = 's1_typer';
AT 7.25 UPDATE layers SET text = '> для создателей про_'     WHERE id = 's1_typer';
AT 7.45 UPDATE layers SET text = '> для создателей продук_'  WHERE id = 's1_typer';
AT 7.70 UPDATE layers SET text = '> для создателей продуктов' WHERE id = 's1_typer';

-- ============================================================================
-- 3. СЦЕНА 2 [8.4 — 14.6] диагностика: панорама камеры + 3 карточки багов
-- ============================================================================
AT 8.4 UPDATE camera SET x = 1200, y = 480, zoom = 1.0 WITH (duration = 1.2, ease = 'inOut');
AT 8.4 UPDATE layers SET text = '02 · диагностика' WHERE id = 'hud_scene';

-- Выгружаем все 20 слоёв Сцены 1 из DOM после окончания панорамы
AT 9.6 DELETE FROM layers WHERE id LIKE 's1_%';

-- Создаём Сцену 2 только перед её появлением в кадре (ip = 8.4 с)
AT 8.4 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
  ('s2_wall',   'rect',    false, 1200, 480, 620, 1000, '#232529', 0,  100, 100),
  ('s2_glow_o', 'ellipse', false, 1040, 540, 420, 320,  '#CC7832', 0,  6,   100),
  ('s2_glow_p', 'ellipse', false, 1360, 200, 460, 280,  '#FF79C6', 0,  5,   100),
  ('s2_c1_bd',  'rect',    false, 1200, 275, 420, 136,  '#393B40', 14, 0,   85),
  ('s2_c2_bd',  'rect',    false, 1200, 435, 420, 136,  '#393B40', 14, 0,   85),
  ('s2_c3_bd',  'rect',    false, 1200, 595, 420, 136,  '#FF5555', 14, 0,   85),
  ('s2_c1_in',  'rect',    false, 1200, 275, 416, 132,  '#2B2D31', 12, 0,   85),
  ('s2_c2_in',  'rect',    false, 1200, 435, 416, 132,  '#2B2D31', 12, 0,   85),
  ('s2_c3_in',  'rect',    false, 1200, 595, 416, 132,  '#2B2D31', 12, 0,   85);
AT 8.4 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s2_lab',   'text', false, '// 02 — диагностика',               'Source Code Pro',  1200, 134, 15, '#FF79C6', 0, 100),
('s2_head',  'text', false, 'ТОЧКИ ОТКАЗА',                      'Roboto Condensed', 1200, 182, 40, '#FFFFFF', 0, 85),
('s2_c1_tt', 'text', false, 'ВЫГОРАНИЕ',                         'Roboto Condensed', 1200, 236, 25, '#FFFFFF', 0, 85),
('s2_c2_tt', 'text', false, 'ПРОКРАСТИНАЦИЯ',                    'Roboto Condensed', 1200, 396, 25, '#FFFFFF', 0, 85),
('s2_c3_tt', 'text', false, 'СТРАХ РЕЛИЗА',                      'Roboto Condensed', 1200, 556, 25, '#FFFFFF', 0, 85),
('s2_c1_ds', 'text', false, 'энергия утекает как фоновый процесс','Source Code Pro',  1200, 270, 15, '#A9B7C6', 0, 85),
('s2_c2_ds', 'text', false, 'deadlock в планировщике задач',      'Source Code Pro',  1200, 430, 15, '#A9B7C6', 0, 85),
('s2_c3_ds', 'text', false, 'каждый warning блокирует сборку',    'Source Code Pro',  1200, 590, 15, '#A9B7C6', 0, 85),
('s2_c1_mp', 'text', false, '→ memory_leak_fix',                 'Source Code Pro',  1200, 304, 15, '#CC7832', 0, 85),
('s2_c2_mp', 'text', false, '→ scheduler_deadlock',              'Source Code Pro',  1200, 464, 15, '#CC7832', 0, 85),
('s2_c3_mp', 'text', false, '→ warnings_as_errors',              'Source Code Pro',  1200, 624, 15, '#CC7832', 0, 85);
AT 9.6   UPDATE layers SET opacity = 100             WHERE id = 's2_lab'  WITH (duration = 0.4, ease = 'out');
AT 9.6   UPDATE layers SET opacity = 100, scale = 100 WHERE id = 's2_head' WITH (duration = 0.5, ease = 'out');
AT 9.8   UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c1_%' WITH (duration = 0.5, ease = 'out');
AT 10.5  UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c2_%' WITH (duration = 0.5, ease = 'out');
AT 11.2  UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's2_c3_%' WITH (duration = 0.5, ease = 'out');
AT 12.2  UPDATE layers SET color = '#CC7832' WHERE id IN ('s2_c1_bd', 's2_c2_bd') WITH (duration = 0.25, ease = 'out');
AT 12.2  UPDATE layers SET color = '#FF79C6' WHERE id = 's2_c3_bd'                WITH (duration = 0.25, ease = 'out');
AT 12.55 UPDATE layers SET color = '#393B40' WHERE id IN ('s2_c1_bd', 's2_c2_bd') WITH (duration = 0.25, ease = 'in');
AT 12.55 UPDATE layers SET color = '#FF5555' WHERE id = 's2_c3_bd'                WITH (duration = 0.25, ease = 'in');
-- ============================================================================
-- 4. СЦЕНА 3 [14.6 — 20.4] git diff: мгновенный кат камеры + вывод diff
-- ============================================================================
AT 14.6 UPDATE camera SET x = 2050, y = 480, zoom = 1.0;
AT 14.6 UPDATE layers SET text = '03 · git diff' WHERE id = 'hud_scene';
-- Мгновенный кат: сразу выгружаем все 20 слоёв Сцены 2
AT 14.6 DELETE FROM layers WHERE id LIKE 's2_%';
-- Создаём Сцену 3 ровно к моменту ката (ip = 14.6 с)
AT 14.6 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s3_wall',   'rect',    false, 2050, 480, 620, 1000, '#232529', 0,  100, 100),
('s3_glow_g', 'ellipse', false, 2050, 720, 520, 260,  '#6A8759', 0,  6,   100),
('s3_win',    'rect',    false, 2050, 365, 460, 410,  '#393B40', 14, 100, 100),
('s3_win_i',  'rect',    false, 2050, 365, 456, 406,  '#0B0D12', 12, 100, 100),
('s3_tbar',   'rect',    false, 2050, 181, 460, 42,   '#14161B', 14, 100, 100),
('s3_pill',   'rect',    false, 2050, 645, 460, 54,   '#CC7832', 27, 0,   70),
('s3_pill_i', 'rect',    false, 2050, 645, 456, 50,   '#2B2D31', 25, 0,   70);
AT 14.6 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s3_lab',    'text', false, '// 03 — патч мышления',               'Source Code Pro', 2050, 134, 15, '#FF79C6', 0,   100),
('s3_ttitle', 'text', false, 'git diff --staged mind/core/*.txt',    'Source Code Pro', 2050, 186, 15, '#7A7E85', 100, 100),
('s3_d1',     'text', false, '',                                     'Source Code Pro', 1989, 245, 16, '#FF8A8A', 100, 100),
('s3_d2',     'text', false, '',                                     'Source Code Pro', 1970, 287, 16, '#FF8A8A', 100, 100),
('s3_a1',     'text', false, '',                                     'Source Code Pro', 1960, 339, 16, '#A2C48D', 100, 100),
('s3_a2',     'text', false, '',                                     'Source Code Pro', 1960, 381, 16, '#A2C48D', 100, 100),
('s3_p7',     'text', false, '',                                     'Source Code Pro', 1980, 455, 22, '#A2C48D', 100, 100),
('s3_m13',    'text', false, '',                                     'Source Code Pro', 2120, 455, 22, '#FF8A8A', 100, 100),
('s3_pill_t', 'text', false, '5..8 сессий = тот самый патч',         'Source Code Pro', 2050, 650, 16, '#CC7832', 0,   70);
AT 14.8  UPDATE layers SET opacity = 100 WHERE id = 's3_lab' WITH (duration = 0.4, ease = 'out');
AT 15.00 UPDATE layers SET text = '- гиперответственность за всё' WHERE id = 's3_d1';
AT 15.30 UPDATE layers SET text = '- тревога на каждый релиз'     WHERE id = 's3_d2';
AT 15.65 UPDATE layers SET text = '+ границы: моё / не моё'       WHERE id = 's3_a1';
AT 15.95 UPDATE layers SET text = '+ фокус на одной задаче'       WHERE id = 's3_a2';
AT 16.30 UPDATE layers SET text = '+7'                           WHERE id = 's3_p7';
AT 16.30 UPDATE layers SET text = '-13'                          WHERE id = 's3_m13';
AT 16.8  UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's3_pill%' WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);
-- ============================================================================
-- 5. СЦЕНА 4 [20.4 — 26.6] протоколы: панорама камеры к x = 2900
-- ============================================================================
AT 20.4 UPDATE camera SET x = 2900, y = 480, zoom = 1.0 WITH (duration = 1.2, ease = 'inOut');
AT 20.4 UPDATE layers SET text = '04 · протоколы' WHERE id = 'hud_scene';
-- Выгружаем все 16 слоёв Сцены 3 после завершения панорамы
AT 21.6 DELETE FROM layers WHERE id LIKE 's3_%';
-- Создаём Сцену 4 к началу панорамы (ip = 20.4 с)
AT 20.4 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s4_wall',   'rect',    false, 2900, 480, 620, 1000, '#232529', 0,  100, 100),
('s4_glow_p', 'ellipse', false, 3060, 230, 420, 280,  '#FF79C6', 0,  5,   100),
('s4_box_bd', 'rect',    false, 2900, 385, 450, 320,  '#393B40', 14, 0,   95),
('s4_box_in', 'rect',    false, 2900, 385, 446, 316,  '#2B2D31', 12, 0,   95),
('s4_pill',   'rect',    false, 2900, 610, 460, 54,   '#CC7832', 27, 0,   70),
('s4_pill_i', 'rect',    false, 2900, 610, 456, 50,   '#2B2D31', 25, 0,   70);
AT 20.4 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s4_lab',    'text', false, '// 04 — протоколы',                        'Source Code Pro',  2900, 134, 15, '#FF79C6', 0, 100),
('s4_head',   'text', false, 'ПРОТОКОЛЫ РАБОТЫ',                         'Roboto Condensed', 2900, 182, 38, '#FFFFFF', 0, 85),
('s4_p1_n',   'text', false, 'diagnostic',                               'Source Code Pro',  2753, 272, 16, '#FFFFFF', 0, 85),
('s4_p1_c',   'text', false, '· 1 сессия',                               'Source Code Pro',  3042, 272, 16, '#CC7832', 0, 85),
('s4_p2_n',   'text', false, 'warnings_as_errors',                       'Source Code Pro',  2791, 328, 16, '#FFFFFF', 0, 85),
('s4_p2_c',   'text', false, '· 2 сессии',                               'Source Code Pro',  3042, 328, 16, '#CC7832', 0, 85),
('s4_p3_n',   'text', false, 'memory_leak_fix',                          'Source Code Pro',  2777, 384, 16, '#FFFFFF', 0, 85),
('s4_p3_c',   'text', false, '· 2 сессии',                               'Source Code Pro',  3042, 384, 16, '#CC7832', 0, 85),
('s4_p4_n',   'text', false, 'scheduler_deadlock',                       'Source Code Pro',  2791, 440, 16, '#FFFFFF', 0, 85),
('s4_p4_c',   'text', false, '· 2–3 сессии',                             'Source Code Pro',  3050, 440, 16, '#CC7832', 0, 85),
('s4_p5_n',   'text', false, 'refactor_toolchain',                       'Source Code Pro',  2791, 496, 16, '#FFFFFF', 0, 85),
('s4_p5_c',   'text', false, '· 1 сессия',                               'Source Code Pro',  3042, 496, 16, '#CC7832', 0, 85),
('s4_pill_t', 'text', false, '5..8 сессий — инструменты остаются у вас', 'Source Code Pro',  2900, 615, 15, '#CC7832', 0, 70);
AT 21.6 UPDATE layers SET opacity = 100             WHERE id = 's4_lab'  WITH (duration = 0.4, ease = 'out');
AT 21.6 UPDATE layers SET opacity = 100, scale = 100 WHERE id = 's4_head' WITH (duration = 0.5, ease = 'out');
AT 21.7 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_box_%' WITH (duration = 0.4, ease = 'out');
AT 21.8 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_p1_%'  WITH (duration = 0.45, ease = 'out');
AT 22.3 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_p2_%'  WITH (duration = 0.45, ease = 'out');
AT 22.8 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_p3_%'  WITH (duration = 0.45, ease = 'out');
AT 23.3 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_p4_%'  WITH (duration = 0.45, ease = 'out');
AT 23.8 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_p5_%'  WITH (duration = 0.45, ease = 'out');
AT 24.4 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's4_pill%' WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);
-- ============================================================================
-- 6. СЦЕНА 5 [26.6 — 32.5] CTA: мгновенный кат на x = 3750
-- ============================================================================
AT 26.6 UPDATE camera SET x = 3750, y = 480, zoom = 1.0;
AT 26.6 UPDATE layers SET text = '05 · запуск' WHERE id = 'hud_scene';
-- Мгновенный кат: сразу удаляем все 19 слоёв Сцены 4
AT 26.6 DELETE FROM layers WHERE id LIKE 's4_%';
-- Создаём Сцену 5 ровно в момент ката (ip = 26.6 с)
AT 26.6 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('s5_wall',   'rect',    false, 3750, 480, 620, 1000, '#232529', 0,  100, 100),
('s5_glow_o', 'ellipse', false, 3700, 720, 520, 300,  '#CC7832', 0,  6,   100),
('s5_btn',    'rect',    false, 3750, 400, 380, 76,   '#E08A3F', 38, 0,   70),
('s5_btn_i',  'rect',    false, 3750, 400, 376, 72,   '#CC7832', 36, 0,   70);
AT 26.6 INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity, scale) VALUES
('s5_lab',    'text', false, '// 05 — запуск сессии',               'Source Code Pro',  3750, 134, 15, '#FF79C6', 0, 100),
('s5_head',   'text', false, 'ЗАПУСК СЕССИИ',                        'Roboto Condensed', 3750, 210, 40, '#FFFFFF', 0, 85),
('s5_dollar', 'text', false, '$',                                    'Source Code Pro',  3640, 280, 18, '#FF79C6', 0, 85),
('s5_rcmd',   'text', false, 'run_session --new',                    'Source Code Pro',  3755, 280, 18, '#FFFFFF', 0, 85),
('s5_btn_t',  'text', false, 'ЗАПИСАТЬСЯ В TELEGRAM',                'Roboto Condensed', 3750, 406, 20, '#1E1F22', 0, 70),
('s5_price',  'text', false, '50 минут · 5000 ₽ · онлайн',           'Source Code Pro',  3750, 505, 16, '#A9B7C6', 0, 85),
('s5_note',   'text', false, '// без эзотерики · без абонементов',   'Source Code Pro',  3750, 560, 16, '#7A7E85', 0, 85);
AT 26.8 UPDATE layers SET opacity = 100             WHERE id = 's5_lab'  WITH (duration = 0.4, ease = 'out');
AT 26.8 UPDATE layers SET opacity = 100, scale = 100 WHERE id = 's5_head' WITH (duration = 0.5, ease = 'out');
AT 27.1 UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s5_dollar', 's5_rcmd') WITH (duration = 0.4, ease = 'out');
AT 27.5 UPDATE layers SET opacity = 100, scale = 100 WHERE id LIKE 's5_btn%' WITH (duration = 0.55, ease = [0.22, 1, 0.36, 1]);
AT 28.2 UPDATE layers SET scale = 108 WHERE id LIKE 's5_btn%' WITH (duration = 0.65, ease = 'inOut', repeat = 3, yoyo = true);
AT 27.9 UPDATE layers SET opacity = 100, scale = 100 WHERE id IN ('s5_price', 's5_note') WITH (duration = 0.4, ease = 'out');
AT 29.2 UPDATE camera SET x = 3750, y = 460, zoom = 1.06 WITH (duration = 1.2, ease = 'inOut');
-- Финальный фейд создаётся только в самом конце (ip = 31.2 с)
AT 31.2 INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity, scale) VALUES
('fade', 'rect', true, 270, 480, 540, 960, '#000000', 0, 0, 100);
AT 31.2 UPDATE layers SET opacity = 100 WHERE id = 'fade' WITH (duration = 1.3, ease = 'in');
