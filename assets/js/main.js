'use strict';

/* ============================================================================
 * LSL STUDIO
 * Структура скрипта:
 *   0. Константы и общие утилиты
 *   1. Демо-сценарий (DEFAULT_DSL)
 *   2. Сканер строк: кавычки, скобки, разделители
 *   3. Парсер LSL
 *   4. Компилятор DSL → Lottie JSON (2D-камера + динамические шрифты)
 *   5. Загрузчик шрифтов (Google Fonts + Base64 для экспорта в видео)
 *   6. UI, плеер и экспорт видео
 * ========================================================================== */

/* ============================================================================
 * 0. КОНСТАНТЫ И ОБЩИЕ УТИЛИТЫ
 * ========================================================================== */

const SVG_NS = 'http://www.w3.org/2000/svg';
const STORAGE_KEY = 'lsl_lottie_studio:dsl';

/** Индекс камеры в Lottie-документе: null-слой (ty: 3), к которому привязаны все обычные слои. */
const CAMERA_INDEX = 9999;

/** Значения полей слоя по умолчанию. */
const DEFAULT_LAYER = {
  type: 'rect', x: 0, y: 0, width: 100, height: 100,
  scale: 100, rotation: 0, opacity: 100, color: '#ffffff',
  radius: 0, text: '', size: 24, font: 'Arial', fixed: false,
  ip: 0, op: null, d: '',
};

/** Значения композиции по умолчанию. */
const DEFAULT_COMPOSITION = { width: 540, height: 960, fps: 60, duration: 5.0 };

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const deepClone = (obj) => JSON.parse(JSON.stringify(obj));

/* ============================================================================
 * 1. ДЕМО-СЦЕНАРИЙ: большой мир, камера, шрифты
 * ========================================================================== */

const DEFAULT_DSL = `
-- ============================================================================
-- ☀️ LSL STUDIO — САМОПРЕЗЕНТАЦИЯ ВОЗМОЖНОСТЕЙ (LIGHT EDITION)
-- Формат: 540x960 (9:16, k=0.5 от 1080x1920), 60 fps, длительность 18.0 с
-- Сетка Safe Zone: x 35–505, y 75–770 | Типографика: от 15 px до 56 px
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 18.0;

AT 0.0 UPDATE camera SET x = 350, y = 480, zoom = 1.0;

-- ============================================================================
-- 0. БАЗОВЫЙ ХОЛСТ И ФИКСИРОВАННЫЙ HUD (живут весь ролик в Safe Zone)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity) VALUES
  ('world_bg', 'rect', false, 1650, 480, 3800, 1400, '#F7F5F0', 0,  100),
  ('sc_1',     'rect', false, 350,  422, 460,  640,  '#FFFFFF', 24, 100),
  ('sc_2',     'rect', false, 1150, 422, 460,  640,  '#FFFFFF', 24, 100),
  ('sc_3',     'rect', false, 1950, 422, 460,  640,  '#FFFFFF', 24, 100),
  ('sc_4',     'rect', false, 2750, 422, 460,  640,  '#FFFFFF', 24, 100);

INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity) VALUES
  ('hud_pill',   'rect', true, 270, 96,  450, 38, '#EFECE4', 19, 100),
  ('hud_track',  'rect', true, 270, 756, 450, 8,  '#E5E0D8', 4,  100),
  ('hud_bar',    'rect', true, 270, 756, 12,  8,  '#2563EB', 4,  100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity) VALUES
  ('hud_status', 'text', true, '01 / 04 · МОРФИНГ & SVG PATH', 'JetBrains Mono', 270, 102, 16, '#2563EB', 100);

-- Глобальный прогресс-бар в нижней границе Safe Zone (y = 756)
AT 0.0 UPDATE layers SET width = 450 WHERE id = 'hud_bar' WITH (duration = 17.8, ease = 'linear');

-- ============================================================================
-- 1. СЦЕНА 1 [0.0s — 4.4s]: МОРФИНГ ГЕОМЕТРИИ + ВЕКТОРНЫЙ SVG PATH
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s1_badge', 'rect', 350, 178, 280, 36, '#DBEAFE', 18, 100),
  ('s1_morph', 'rect', 350, 325, 132, 132, '#2563EB', 66, 100),
  ('s1_code_bg','rect', 350, 565, 410, 130, '#EFECE4', 16, 0);

-- Векторная звезда (SVG path) появляется слева внутри раскрытой плашки
INSERT INTO layers (id, type, x, y, width, height, color, opacity, scale, d) VALUES
  ('s1_star', 'path', 226, 325, 36, 36, '#FBBF24', 0, 40, 'M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z');

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s1_tag',    'text', 'type = ''path'' + морфинг',    'JetBrains Mono', 350, 184, 16, '#1D4ED8', 100),
  ('s1_shape_t','text', 'LSL',                          'Montserrat',     350, 339, 44, '#FFFFFF', 100),
  ('s1_head',   'text', 'Геометрия и SVG Path',         'Montserrat',     350, 455, 32, '#1C1B19', 100),
  ('s1_c1',     'text', 'rect · ellipse · path (SVG d)','JetBrains Mono', 350, 542, 17, '#1C1B19', 0),
  ('s1_c2',     'text', 'ease = [0.22, 1, 0.36, 1]',    'JetBrains Mono', 350, 578, 16, '#2563EB', 0),
  ('s1_c3',     'text', 'векторные иконки без внешних файлов', 'Montserrat', 350, 612, 16, '#4A4741', 0);

AT 0.35 UPDATE layers SET width = 360, height = 104, radius = 24 WHERE id = 's1_morph' WITH (duration = 0.8, ease = [0.22, 1, 0.36, 1]);
AT 0.55 UPDATE layers SET text = 'LSL STUDIO', size = 30, x = 372  WHERE id = 's1_shape_t';
AT 0.65 UPDATE layers SET opacity = 100, scale = 100, rotation = 360 WHERE id = 's1_star' WITH (duration = 0.7, ease = [0.22, 1, 0.36, 1]);
AT 0.80 UPDATE layers SET opacity = 100 WHERE id IN ('s1_code_bg', 's1_c1', 's1_c2', 's1_c3') WITH (duration = 0.45, ease = 'out');
AT 0.50 UPDATE camera SET zoom = 1.05 WITH (duration = 1.6, ease = 'inOut');

-- Переезд камеры ко 2-й сцене [3.2s -> 4.4s] и очистка DOM 1-й сцены
AT 3.2 UPDATE camera SET x = 1150, y = 480, zoom = 1.0 WITH (duration = 1.2, ease = 'inOut');
AT 4.5 DELETE FROM layers WHERE id LIKE 's1_%';

-- ============================================================================
-- 2. СЦЕНА 2 [3.6s — 9.0s]: SQL-СЕЛЕКТОРЫ (WHERE LIKE / OR)
-- ============================================================================
AT 3.6 INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s2_badge',   'rect', 1150, 178, 280, 36, '#EDE9FE', 18, 100),
  ('s2_chart_bg','rect', 1150, 415, 410, 230,'#F7F5F0', 16, 100),
  ('eq_1',       'rect', 1002, 480, 52,  48, '#CBD5E1', 12, 100),
  ('eq_2',       'rect', 1076, 480, 52,  48, '#CBD5E1', 12, 100),
  ('eq_3',       'rect', 1150, 480, 52,  48, '#CBD5E1', 12, 100),
  ('eq_4',       'rect', 1224, 480, 52,  48, '#CBD5E1', 12, 100),
  ('eq_5',       'rect', 1298, 480, 52,  48, '#CBD5E1', 12, 100);

AT 3.6 INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s2_tag',  'text', "WHERE id LIKE 'eq_%'",            'JetBrains Mono', 1150, 184, 16, '#6D28D9', 100),
  ('s2_head', 'text', 'SQL-выборки слоёв',               'Montserrat',     1150, 248, 32, '#1C1B19', 100),
  ('s2_sub',  'text', 'Массовая анимация одним запросом','Montserrat',     1150, 282, 17, '#4A4741', 100),
  ('s2_q2',   'text', "WHERE id = 'eq_2' OR id = 'eq_4'",'JetBrains Mono', 1150, 578, 16, '#6D28D9', 0),
  ('s2_hint', 'text', 'поддержка LIKE, IN, AND, OR, >, <','Montserrat',    1150, 616, 16, '#4A4741', 0);

AT 4.1 UPDATE layers SET color = '#7C3AED' WHERE id = 'hud_bar';
AT 4.1 UPDATE layers SET text = '02 / 04 · SQL-СЕЛЕКТОРЫ', color = '#7C3AED' WHERE id = 'hud_status';

-- Шаг 2а: Поднимаем все 5 колонок по маске LIKE 'eq_%'
AT 4.5 UPDATE layers SET height = 140, y = 434, color = '#8B5CF6' WHERE id LIKE 'eq_%' WITH (duration = 0.6, ease = [0.22, 1, 0.36, 1]);
AT 5.2 UPDATE layers SET opacity = 100 WHERE id IN ('s2_q2', 's2_hint') WITH (duration = 0.4, ease = 'out');

-- Шаг 2б: Выделяем чётные колонки через OR
AT 5.6 UPDATE layers SET height = 190, y = 409, color = '#2563EB', radius = 26 WHERE id = 'eq_2' OR id = 'eq_4' WITH (duration = 0.6, ease = 'inOut');

-- Переезд камеры к 3-й сцене [7.8s -> 9.0s] и очистка DOM 2-й сцены
AT 7.8 UPDATE camera SET x = 1950, y = 480, zoom = 1.0 WITH (duration = 1.2, ease = 'inOut');
AT 9.1 DELETE FROM layers WHERE id LIKE 's2_%' OR id LIKE 'eq_%';

-- ============================================================================
-- 3. СЦЕНА 3 [8.2s — 13.6s]: ЦИКЛЫ, ПОВТОРЫ И YOYO-МАЯТНИК (на SVG path)
-- ============================================================================
AT 8.2 INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s3_badge',   'rect',    1950, 178, 280, 36,  '#D1FAE5', 18, 100),
  ('yo_ring',    'ellipse', 1950, 385, 168, 168, '#10B981', 0,  22),
  ('yo_box',     'rect',    1950, 385, 120, 120, '#059669', 26, 100),
  ('s3_code_bg', 'rect',    1950, 585, 410, 104, '#EFECE4', 16, 100);

-- Векторная иконка Rotate-Right (Font Awesome path) вместо текстового глифа
AT 8.2 INSERT INTO layers (id, type, x, y, width, height, color, opacity, d) VALUES
  ('yo_icon', 'path', 1950, 385, 52, 52, '#FFFFFF', 100, 'M463.5 224H472c13.3 0 24-10.7 24-24V72c0-9.7-5.8-18.5-14.8-22.2s-19.3-1.7-26.2 5.2L413.4 96.6c-87.6-86.5-228.7-86.2-315.8 1c-87.5 87.5-87.5 229.3 0 316.8s229.3 87.5 316.8 0c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0c-62.5 62.5-163.8 62.5-226.3 0s-62.5-163.8 0-226.3c62.2-62.2 162.7-62.5 225.3-1L327 183c-6.9 6.9-8.9 17.2-5.2 26.2s12.5 14.8 22.2 14.8H463.5z');

AT 8.2 INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s3_tag',  'text', 'repeat = 3, yoyo = true',          'JetBrains Mono', 1950, 184, 16, '#047857', 100),
  ('s3_head', 'text', 'Циклы и маятник',                  'Montserrat',     1950, 248, 32, '#1C1B19', 100),
  ('s3_c1',   'text', 'WITH (duration = 0.8, repeat = 3, yoyo = true)', 'JetBrains Mono', 1950, 572, 15, '#1C1B19', 100),
  ('s3_c2',   'text', 'автоматический возврат в исходное состояние',    'Montserrat',     1950, 608, 16, '#4A4741', 100);

AT 8.7 UPDATE layers SET color = '#059669' WHERE id = 'hud_bar';
AT 8.7 UPDATE layers SET text = '03 / 04 · REPEAT & YOYO', color = '#059669' WHERE id = 'hud_status';

-- 3 цикла туда-обратно (9.0s + 3 * 0.8s = 11.4s)
AT 9.0 UPDATE layers SET rotation = 90, radius = 60, scale = 114 WHERE id = 'yo_box'  WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
AT 9.0 UPDATE layers SET rotation = 180, width = 62, height = 62  WHERE id = 'yo_icon' WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
AT 9.0 UPDATE layers SET width = 260, height = 260, opacity = 40  WHERE id = 'yo_ring' WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
AT 9.2 UPDATE camera SET zoom = 1.06                              WITH (duration = 1.2, ease = 'inOut', repeat = 1, yoyo = true);

-- Очистка DOM 3-й сцены сразу после монтажного ката
AT 13.7 DELETE FROM layers WHERE id LIKE 's3_%' OR id LIKE 'yo_%';

-- ============================================================================
-- 4. СЦЕНА 4 [13.5s — 18.0s]: МОНТАЖНЫЙ КАТ + 2D-КАМЕРА + ЭКСПОРТ
-- ============================================================================
AT 13.5 INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s4_badge', 'rect', 2750, 178, 280, 36,  '#FEE2E2', 18, 100),
  ('s4_btn',   'rect', 2750, 420, 148, 148, '#D95338', 74, 100),
  ('s4_info',  'rect', 2750, 585, 410, 104, '#EFECE4', 16, 0);

AT 13.5 INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
('s4_tag',   'text', 'AT 13.6 UPDATE camera ...',        'JetBrains Mono', 2750, 184, 16, '#B91C1C', 100),
('s4_head',  'text', 'Кат камеры и экспорт',             'Montserrat',     2750, 248, 32, '#1C1B19', 100),
('s4_sub',   'text', 'Мгновенная смена плана без duration','Montserrat',    2750, 284, 17, '#4A4741', 100),
('s4_btn_t', 'text', 'JSON & WebM',                      'Montserrat',     2750, 430, 26, '#FFFFFF', 0),
('s4_i1',    'text', '• Lottie JSON с 2D-камерой (CAMERA_RIG)', 'Montserrat', 2750, 570, 16, '#1C1B19', 0),
('s4_i2',    'text', '• Покадровый рендер в WebM 60 fps',      'Montserrat', 2750, 604, 16, '#4A4741', 0);
-- Мгновенный перескок камеры на 4-й экран (duration = 0)
AT 13.6 UPDATE camera SET x = 2750, y = 480, zoom = 0.94;
AT 13.6 UPDATE layers SET color = '#D95338' WHERE id = 'hud_bar';
AT 13.6 UPDATE layers SET text = '04 / 04 · КАТ & ЭКСПОРТ', color = '#D95338' WHERE id = 'hud_status';
-- Наезд камеры + морфинг круга в кнопку + появление карточки итогов
AT 13.75 UPDATE camera SET x = 2750, y = 480, zoom = 1.08 WITH (duration = 1.5, ease = 'inOut');
AT 13.75 UPDATE layers SET width = 360, height = 88, radius = 44 WHERE id = 's4_btn' WITH (duration = 0.7, ease = [0.22, 1, 0.36, 1]);
AT 14.15 UPDATE layers SET opacity = 100 WHERE id IN ('s4_btn_t', 's4_info', 's4_i1', 's4_i2') WITH (duration = 0.45, ease = 'out');
-- Финальная стабилизация плана [15.6s -> 17.0s]
AT 15.6 UPDATE camera SET x = 2750, y = 480, zoom = 1.0 WITH (duration = 1.4, ease = 'inOut');
`;

/* ============================================================================
 * 2. СКАНЕР СТРОК
 * Все функции ниже игнорируют содержимое строковых литералов и скобочных
 * групп, поэтому значения в DSL могут свободно содержать кавычки и скобки.
 * ========================================================================== */

/** Кавычки, открывающие строковый литерал. */
const QUOTES = new Set(["'", '"']);

/** Скобочные группы: открывающая → закрывающая. */
const BRACKETS = { '(': ')', '[': ']' };

/** Индекс закрывающей кавычки для кавычки в позиции start (escape: \'). */
function findQuoteEnd(text, start) {
  const quote = text[start];
  for (let i = start + 1; i < text.length; i++) {
    if (text[i] === quote && text[i - 1] !== '\\') return i;
  }
  return text.length - 1;
}

/** Индекс закрывающей скобки для открывающей в позиции start. */
function findClosingBracket(text, start) {
  const closer = BRACKETS[text[start]];
  let depth = 0;
  for (let i = start; i < text.length; i++) {
    const ch = text[i];
    if (QUOTES.has(ch)) { i = findQuoteEnd(text, i); continue; }
    if (BRACKETS[ch]) depth++;
    else if (ch === closer && --depth === 0) return i;
  }
  return text.length - 1;
}

/** Разделяет строку по разделителю, игнорируя его внутри кавычек и скобок. */
function splitTopLevel(str, sep = ',') {
  const parts = [];
  let current = '';
  let depth = 0;
  for (let i = 0; i < str.length; i++) {
    const ch = str[i];
    if (QUOTES.has(ch)) {
      const end = findQuoteEnd(str, i);
      current += str.slice(i, end + 1);
      i = end;
    } else if (ch === '(' || ch === '[') {
      depth++;
      current += ch;
    } else if (ch === ')' || ch === ']') {
      depth--;
      current += ch;
    } else if (ch === sep && depth === 0) {
      parts.push(current.trim());
      current = '';
    } else {
      current += ch;
    }
  }
  if (current.trim()) parts.push(current.trim());
  return parts;
}

/** Срезает внешние скобки: "(a, b)" → "a, b". */
function stripParens(str) {
  const t = str.trim();
  return t.startsWith('(') && t.endsWith(')') ? t.slice(1, -1) : t;
}

/** '123' → 123, "'текст'" → текст, "true" → true и массивы вида "[0.25, 0.1]". */
function parseValue(raw) {
  const s = raw.trim();
  if ((s.startsWith("'") && s.endsWith("'")) || (s.startsWith('"') && s.endsWith('"'))) {
    return s.slice(1, -1).replace(/\\n/g, '\n');
  }
  if (s.startsWith('[') && s.endsWith(']')) {
    const inner = s.slice(1, -1).trim();
    return inner ? splitTopLevel(inner).map(parseValue) : [];
  }
  if (s === 'true') return true;
  if (s === 'false') return false;
  const num = Number(s);
  return s !== '' && !isNaN(num) ? num : s;
}

/** "x = 10, color = '#fff'" → { x: 10, color: '#fff' }. */
function parseAssignments(str) {
  const obj = {};
  for (const part of splitTopLevel(str)) {
    const eq = part.indexOf('=');
    if (eq === -1) throw new Error('Ожидалось присваивание "ключ = значение" в: ' + part);
    obj[part.slice(0, eq).trim()] = parseValue(part.slice(eq + 1));
  }
  return obj;
}

/** Убирает комментарий "-- ..." до конца строки (не трогая его внутри кавычек). */
function stripLineComment(line) {
  for (let i = 0; i < line.length - 1; i++) {
    const ch = line[i];
    if (QUOTES.has(ch)) { i = findQuoteEnd(line, i); continue; }
    if (ch === '-' && line[i + 1] === '-') return line.slice(0, i);
  }
  return line;
}

/**
 * Находит ключевые слова вне кавычек и скобочных групп: [{ word, index }].
 * Используется, чтобы надёжно отделить опциональные части UPDATE
 * (WHERE / AT / WITH), даже если значения содержат похожие слова в кавычках.
 */
function findTopLevelKeywords(text, words) {
  const upper = text.toUpperCase();
  const found = [];
  for (let i = 0; i < text.length; i++) {
    const ch = text[i];
    if (QUOTES.has(ch)) { i = findQuoteEnd(text, i); continue; }
    if (BRACKETS[ch]) { i = findClosingBracket(text, i); continue; }

    const isWordStart = i === 0 || /\s/.test(text[i - 1]);
    if (!isWordStart) continue;
    for (const word of words) {
      const end = i + word.length;
      if (upper.startsWith(word, i) && (end >= text.length || /\s/.test(text[end]))) {
        found.push({ word, index: i });
        i = end - 1;
        break;
      }
    }
  }
  return found;
}

/** Разбирает хвост UPDATE: SET-часть плюс необязательные WHERE / WITH (...). */
function splitUpdateTail(rest) {
  const marks = findTopLevelKeywords(rest, ['WHERE', 'WITH'])
    .sort((a, b) => a.index - b.index);
  const tail = { set: '', where: null, with: {} };
  if (!marks.length) { tail.set = rest.trim(); return tail; }

  tail.set = rest.slice(0, marks[0].index).trim();
  for (let i = 0; i < marks.length; i++) {
    const { word, index } = marks[i];
    const end = i + 1 < marks.length ? marks[i + 1].index : rest.length;
    const segment = rest.slice(index + word.length, end).trim();

    if (word === 'WITH') tail.with = parseAssignments(stripParens(segment));
    else tail.where = segment;
  }
  return tail;
}

/** Приводит SET/AT/WITH к единому объекту события анимации. */
function makeUpdate(setPart, atTime, withObj) {
  const delay = Number(withObj.delay ?? 0);
  return {
    t: (atTime || 0) + delay,
    dur: Number(withObj.duration ?? withObj.dur ?? 0),
    ease: withObj.ease ?? 'inOut',
    repeat: Math.max(0, Math.floor(Number(withObj.repeat ?? 0))),
    yoyo: Boolean(withObj.yoyo ?? false),
    set: parseAssignments(setPart),
  };
}

/* ============================================================================
 * 3. ПАРСЕР LSL
 * ========================================================================== */

function parseInsertStatement(stmt, layers, atTime = 0) {
  const match = stmt.match(/^INSERT\s+INTO\s+layers\s*\(([^)]+)\)\s*VALUES\s*(.+)$/is);
  if (!match) return false;

  const columns = splitTopLevel(match[1]).map((c) => c.trim());
  for (const tuple of splitTopLevel(match[2])) {
    const values = splitTopLevel(stripParens(tuple)).map(parseValue);
    if (values.length !== columns.length) {
      throw new Error(
        `Количество значений (${values.length}) не совпадает с колонками (${columns.length})`
      );
    }
    const layer = { ...DEFAULT_LAYER, ip: atTime };
    columns.forEach((col, i) => { layer[col] = values[i]; });
    if (!layer.id) throw new Error('У каждого слоя в INSERT должен быть указан id');
    layers.set(layer.id, layer);
  }
  return true;
}

function parseDeleteStatement(stmt, layers, atTime = 0) {
  const match = stmt.match(/^DELETE\s+FROM\s+layers(?:\s+WHERE\s+(.+))?$/is);
  if (!match) return false;

  const predicate = match[1] ? compileWherePredicate(match[1].trim()) : () => true;
  for (const layer of layers.values()) {
    if (predicate(layer) && layer.op === null) {
      layer.op = atTime;
    }
  }
  return true;
}

function parseCompositionUpdate(stmt, comp) {
  const match = stmt.match(/^UPDATE\s+composition\s+SET\s+(.+)$/is);
  if (!match) return false;
  Object.assign(comp, parseAssignments(match[1]));
  return true;
}

function parseLayerUpdate(stmt, updates, atTime) {
  const match = stmt.match(/^UPDATE\s+layers\s+SET\s+(.+)$/is);
  if (!match) return false;

  const tail = splitUpdateTail(match[1]);
  const update = makeUpdate(tail.set, atTime, tail.with);
  update.matchFn = tail.where ? compileWherePredicate(tail.where) : () => true;
  updates.push(update);
  return true;
}

function parseCameraUpdate(stmt, cameraUpdates, atTime) {
  const match = stmt.match(/^UPDATE\s+camera\s+SET\s+(.+)$/is);
  if (!match) return false;
  const tail = splitUpdateTail(match[1]);
  cameraUpdates.push(makeUpdate(tail.set, atTime, tail.with));
  return true;
}

/** Обработчики инструкций: каждая возвращает true, если распознала выражение. */
const STATEMENT_PARSERS = [
  (stmt, ctx, atTime) => parseInsertStatement(stmt, ctx.layers, atTime),
  (stmt, ctx, atTime) => parseDeleteStatement(stmt, ctx.layers, atTime),
  (stmt, ctx) => parseCompositionUpdate(stmt, ctx.comp),
  (stmt, ctx, atTime) => parseCameraUpdate(stmt, ctx.cameraUpdates, atTime),
  (stmt, ctx, atTime) => parseLayerUpdate(stmt, ctx.updates, atTime),
];

/** Разбирает текст DSL в { comp, layers, updates, cameraUpdates }. */
function parseDSL(text) {
  const cleaned = text.split('\n').map(stripLineComment).join('\n');
  const statements = splitTopLevel(cleaned, ';');

  const ctx = {
    comp: { ...DEFAULT_COMPOSITION },
    layers: new Map(),
    updates: [],
    cameraUpdates: [],
  };

  for (const raw of statements) {
    let stmt = raw.trim();
    if (!stmt) continue;

    let atTime = 0;
    const atMatch = stmt.match(/^AT\s+([+-]?\d+(?:\.\d+)?)\s+(.+)$/is);
    if (atMatch) {
      atTime = parseFloat(atMatch[1]) || 0;
      stmt = atMatch[2].trim();
    }

    const matched = STATEMENT_PARSERS.some((parse) => parse(stmt, ctx, atTime));
    if (!matched) throw new Error('Неизвестная инструкция LSL: ' + stmt.slice(0, 60));
  }

  return ctx;
}

/* --- Условия WHERE: компиляция строки в предикат (layer) => boolean --- */

/** Условие "col IN ('a', 'b')". */
function compileInPredicate(col, listStr) {
  const list = splitTopLevel(listStr).map(parseValue);
  return (layer) => list.includes(layer[col]);
}

/** Условие "col LIKE 'шаблон%'": % — любое число символов, _ — один символ. */
function compileLikePredicate(col, rawPattern) {
  const pat = String(parseValue(rawPattern))
    .replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
    .replace(/%/g, '.*')
    .replace(/_/g, '.');
  const re = new RegExp('^' + pat + '$', 'i');
  return (layer) => re.test(String(layer[col] ?? ''));
}

/** Условие сравнения: col (= | != | <> | >= | <= | > | <) value. */
function compileComparisonPredicate(col, op, rawVal) {
  const val = parseValue(rawVal);
  const compare = {
    '=': (a, b) => a === b,
    '!=': (a, b) => a !== b,
    '<>': (a, b) => a !== b,
    '>': (a, b) => a > b,
    '<': (a, b) => a < b,
    '>=': (a, b) => a >= b,
    '<=': (a, b) => a <= b,
  }[op];
  if (!compare) throw new Error('Неподдерживаемое условие WHERE: ' + col + ' ' + op);
  return (layer) => compare(layer[col], val);
}

/**
 * Компилирует строку условия WHERE в функцию (layer) => boolean.
 * Поддерживает OR на верхнем уровне, AND внутри и три вида условий.
 */
function compileWherePredicate(whereStr) {
  const orPredicates = whereStr.split(/\s+OR\s+/i).map((orPart) => {
    const andPredicates = orPart.split(/\s+AND\s+/i).map((raw) => {
      const cond = raw.trim();

      let m = cond.match(/^(\w+)\s+IN\s*\((.+)\)$/i);
      if (m) return compileInPredicate(m[1], m[2]);

      m = cond.match(/^(\w+)\s+LIKE\s+(.+)$/i);
      if (m) return compileLikePredicate(m[1], m[2]);

      m = cond.match(/^(\w+)\s*(!=|<>|>=|<=|=|>|<)\s*(.+)$/);
      if (m) return compileComparisonPredicate(m[1], m[2], m[3]);

      throw new Error('Неподдерживаемое условие WHERE: ' + cond);
    });
    return (layer) => andPredicates.every((fn) => fn(layer));
  });
  return (layer) => orPredicates.some((fn) => fn(layer));
}

/* ============================================================================
 * 4. КОМПИЛЯТОР DSL → LOTTIE JSON
 * ========================================================================== */

/** Хэндлы ключевого кадра Lottie из пары контрольных точек cubic-bezier. */
const bezier = (ix, iy, ox, oy) => ({ i: { x: [ix], y: [iy] }, o: { x: [ox], y: [oy] } });

// В Lottie "o" — исходящий хэндл (x1, y1), "i" — входящий (x2, y2) из cubic-bezier.
const EASING = {
  linear: bezier(1, 1, 0, 0),
  in:     bezier(1, 1, 0.42, 0),
  out:    bezier(0.58, 1, 0, 0),
  inOut:  bezier(0.58, 1, 0.42, 0),
};
const LINEAR = EASING.linear;

function hexToLottieColor(hex) {
  let c = String(hex).replace('#', '').trim();
  if (c.length === 3) c = [...c].map((x) => x + x).join('');
  const num = parseInt(c, 16);
  if (isNaN(num)) return [1, 1, 1, 1];
  return [
    ((num >> 16) & 255) / 255,
    ((num >> 8) & 255) / 255,
    (num & 255) / 255,
    1,
  ].map((v) => +v.toFixed(4));
}

/** Именованная кривая или массив [x1, y1, x2, y2] → хэндлы ключевого кадра. */
function resolveEase(easeSpec) {
  if (Array.isArray(easeSpec) && easeSpec.length === 4) {
    const [x1, y1, x2, y2] = easeSpec.map(Number);
    return bezier(x2, y2, x1, y1);
  }
  return EASING[String(easeSpec)] || EASING.inOut;
}

/**
 * Собирает Lottie-трек ключевых кадров из событий одного канала.
 * Поддерживает repeat (повторы) и yoyo (туда-обратно), которые
 * разворачиваются в последовательность атомарных переходов.
 */
function buildKeyframes(events, initialVal, fps, isArray) {
  const make = (val) => (isArray ? val.slice() : [val]);
  const sorted = [...events].sort((a, b) => a.t - b.t);
  if (!sorted.length) return { a: 0, k: isArray ? initialVal.slice() : initialVal };

  // Разворачиваем repeat / yoyo в последовательность атомарных переходов
  const expanded = [];
  let trackedVal = initialVal;

  for (const ev of sorted) {
    const fromVal = trackedVal;
    const toVal = ev.val;
    const cycles = (ev.repeat || 0) + 1;

    for (let c = 0; c < cycles; c++) {
      const startT = ev.t + c * ev.dur;
      if (ev.yoyo) {
        const target = c % 2 === 0 ? toVal : fromVal;
        expanded.push({ t: startT, dur: ev.dur, ease: ev.ease, val: target });
        trackedVal = target;
      } else {
        // При repeat без yoyo на каждом новом цикле сбрасываемся в fromVal
        if (c > 0) expanded.push({ t: startT, dur: 0, ease: 'linear', val: fromVal });
        expanded.push({ t: startT, dur: ev.dur, ease: ev.ease, val: toVal });
        trackedVal = toVal;
      }
    }
  }

  const kf = [];
  const last = () => kf[kf.length - 1];
  const push = (t, val, ease) => kf.push({ t, s: make(val), i: ease.i, o: ease.o });
  let curVal = initialVal;

  for (const ev of expanded) {
    const startFrame = Math.round(ev.t * fps);
    const durFrames = Math.round(ev.dur * fps);
    const endFrame = startFrame + durFrames;
    const ease = resolveEase(ev.ease);

    if (durFrames <= 0) {
      if (startFrame > 0) {
        const prev = startFrame - 1;
        if (!last() || last().t < prev) push(prev, curVal, LINEAR);
      }
      if (last() && last().t === startFrame) {
        Object.assign(last(), { s: make(ev.val), i: LINEAR.i, o: LINEAR.o });
      } else {
        push(startFrame, ev.val, LINEAR);
      }
    } else {
      if (!last() || last().t < startFrame) {
        push(startFrame, curVal, ease);
      } else if (last().t === startFrame) {
        last().i = ease.i;
        last().o = ease.o;
      }
      push(endFrame, ev.val, LINEAR);
    }
    curVal = ev.val;
  }
  if (kf.length === 1) {
    return { a: 0, k: isArray ? kf[0].s : kf[0].s[0] };
  }
  return { a: 1, k: kf };
}

/**
 * Разбирает UPDATE-события одного слоя на каналы анимации.
 * Каждый трекер соответствует одному каналу и накапливает его текущее
 * значение, чтобы частичный SET (например, только width) не сбрасывал
 * остальные свойства.
 */
function collectLayerEvents(layer, updates) {
  const channels = { pos: [], scale: [], rot: [], op: [], color: [], size: [], radius: [], text: [] };
  const pos = { x: layer.x, y: layer.y };
  const size = { w: layer.width, h: layer.height };
  let color = layer.color;
  let text = String(layer.text || '');

  const ev = (u, val) => ({
    t: u.t, dur: u.dur, ease: u.ease, repeat: u.repeat, yoyo: u.yoyo, val,
  });

  const trackers = [
    // pos: x и y обновляются совместно, чтобы не терять вторую координату
    (u) => {
      const { set } = u;
      if (set.x === undefined && set.y === undefined) return;
      if (set.x !== undefined) pos.x = set.x;
      if (set.y !== undefined) pos.y = set.y;
      channels.pos.push(ev(u, [pos.x, pos.y, 0]));
    },
    // size: аналогично — width и height всегда парой
    (u) => {
      const { set } = u;
      if (set.width === undefined && set.height === undefined) return;
      if (set.width !== undefined) size.w = set.width;
      if (set.height !== undefined) size.h = set.height;
      channels.size.push(ev(u, [size.w, size.h]));
    },
    (u) => { if (u.set.radius !== undefined) channels.radius.push(ev(u, u.set.radius)); },
    (u) => {
      const sc = u.set.scale;
      if (sc !== undefined) channels.scale.push(ev(u, [sc, sc, 100]));
    },
    (u) => { if (u.set.rotation !== undefined) channels.rot.push(ev(u, u.set.rotation)); },
    (u) => { if (u.set.opacity !== undefined) channels.op.push(ev(u, u.set.opacity)); },
    (u) => {
      if (u.set.color === undefined) return;
      color = u.set.color;
      channels.color.push(ev(u, hexToLottieColor(color)));
    },
    // text: замена текста, а также цвет текстового слоя (событие t);
    // color-трекер выше уже обновил текущий цвет, если он менялся
    (u) => {
      const { set } = u;
      const touchesText = set.text !== undefined || (layer.type === 'text' && set.color !== undefined);
      if (!touchesText) return;
      if (set.text !== undefined) text = String(set.text);
      channels.text.push({ t: u.t, text, color });
    },
  ];

  for (const u of updates) {
    if (u.matchFn && !u.matchFn(layer)) continue;
    for (const track of trackers) track(u);
  }
  return channels;
}

/** Базовый слой Lottie: задаёт интервал жизни [ip, op] и привязку к камере. */
function createBaseLayer(layer, ks, ind, totalFrames, fps, camInd) {
  const ip = Math.max(0, Math.round((layer.ip || 0) * fps));
  const rawOp = layer.op !== null && layer.op !== undefined
    ? Math.round(layer.op * fps)
    : totalFrames;
  const op = Math.max(ip + 1, Math.min(totalFrames, rawOp));

  const res = {
    ddd: 0, ind, nm: layer.id, sr: 1, ks, ao: 0,
    ip, op, st: 0, bm: 0,
  };
  if (!layer.fixed) res.parent = camInd;
  return res;
}

function layerTransform(layer, channels, fps) {
  return {
    o: buildKeyframes(channels.op, layer.opacity, fps, false),
    r: buildKeyframes(channels.rot, layer.rotation, fps, false),
    p: buildKeyframes(channels.pos, [layer.x, layer.y, 0], fps, true),
    a: { a: 0, k: [0, 0, 0] },
    s: buildKeyframes(channels.scale, [layer.scale, layer.scale, 100], fps, true),
  };
}

/** Переводит SVG path (d) в массив Lottie-шейпов ('ty': 'sh'), нормализованных к 100×100. */
function svgPathToLottieShapes(d) {
  if (!d || typeof d !== 'string') return [];

  const tokens = d.match(/[a-zA-Z]|[+-]?(?:\d+\.?\d*|\.\d+)(?:e[+-]?\d+)?/gi) || [];
  const subpaths = [];
  let curPath = null;

  let idx = 0, cmd = '', prevCmd = '';
  let cx = 0, cy = 0, sx = 0, sy = 0, lastCtrlX = 0, lastCtrlY = 0;

  const num = () => parseFloat(tokens[idx++]);
  const hasNum = () => idx < tokens.length && !/^[a-zA-Z]$/.test(tokens[idx]);

  const startSubpath = (x, y) => {
    curPath = { closed: false, pts: [{ x, y, ix: 0, iy: 0, ox: 0, oy: 0 }] };
    subpaths.push(curPath);
    cx = sx = x; cy = sy = y;
  };

  const addCubic = (x1, y1, x2, y2, x, y) => {
    if (!curPath) startSubpath(cx, cy);
    const prev = curPath.pts[curPath.pts.length - 1];
    prev.ox = x1 - cx;
    prev.oy = y1 - cy;
    curPath.pts.push({ x, y, ix: x2 - x, iy: y2 - y, ox: 0, oy: 0 });
    cx = x; cy = y;
  };

  while (idx < tokens.length) {
    if (/^[a-zA-Z]$/.test(tokens[idx])) cmd = tokens[idx++];
    else if (cmd === 'M') cmd = 'L';
    else if (cmd === 'm') cmd = 'l';

    const isRel = cmd === cmd.toLowerCase();
    const type = cmd.toUpperCase();

    if (type === 'M') {
      const x = num() + (isRel ? cx : 0), y = num() + (isRel ? cy : 0);
      startSubpath(x, y);
      lastCtrlX = cx; lastCtrlY = cy;
    } else if (type === 'L') {
      const x = num() + (isRel ? cx : 0), y = num() + (isRel ? cy : 0);
      addCubic(cx, cy, x, y, x, y);
      lastCtrlX = cx; lastCtrlY = cy;
    } else if (type === 'H') {
      const x = num() + (isRel ? cx : 0);
      addCubic(cx, cy, x, cy, x, cy);
      lastCtrlX = cx; lastCtrlY = cy;
    } else if (type === 'V') {
      const y = num() + (isRel ? cy : 0);
      addCubic(cx, cy, cx, y, cx, y);
      lastCtrlX = cx; lastCtrlY = cy;
    } else if (type === 'C') {
      const x1 = num() + (isRel ? cx : 0), y1 = num() + (isRel ? cy : 0);
      const x2 = num() + (isRel ? cx : 0), y2 = num() + (isRel ? cy : 0);
      const x  = num() + (isRel ? cx : 0), y  = num() + (isRel ? cy : 0);
      addCubic(x1, y1, x2, y2, x, y);
      lastCtrlX = x2; lastCtrlY = y2;
    } else if (type === 'S') {
      const x1 = (prevCmd === 'C' || prevCmd === 'S') ? 2 * cx - lastCtrlX : cx;
      const y1 = (prevCmd === 'C' || prevCmd === 'S') ? 2 * cy - lastCtrlY : cy;
      const x2 = num() + (isRel ? cx : 0), y2 = num() + (isRel ? cy : 0);
      const x  = num() + (isRel ? cx : 0), y  = num() + (isRel ? cy : 0);
      addCubic(x1, y1, x2, y2, x, y);
      lastCtrlX = x2; lastCtrlY = y2;
    } else if (type === 'Q') {
      const qx = num() + (isRel ? cx : 0), qy = num() + (isRel ? cy : 0);
      const x  = num() + (isRel ? cx : 0), y  = num() + (isRel ? cy : 0);
      addCubic(
        cx + (2 / 3) * (qx - cx), cy + (2 / 3) * (qy - cy),
        x  + (2 / 3) * (qx - x),  y  + (2 / 3) * (qy - y),
        x, y
      );
      lastCtrlX = qx; lastCtrlY = qy;
    } else if (type === 'T') {
      const qx = (prevCmd === 'Q' || prevCmd === 'T') ? 2 * cx - lastCtrlX : cx;
      const qy = (prevCmd === 'Q' || prevCmd === 'T') ? 2 * cy - lastCtrlY : cy;
      const x  = num() + (isRel ? cx : 0), y  = num() + (isRel ? cy : 0);
      addCubic(
        cx + (2 / 3) * (qx - cx), cy + (2 / 3) * (qy - cy),
        x  + (2 / 3) * (qx - x),  y  + (2 / 3) * (qy - y),
        x, y
      );
      lastCtrlX = qx; lastCtrlY = qy;
    } else if (type === 'A') {
      const rx = Math.abs(num()), ry = Math.abs(num());
      const rot = num(), largeArc = num(), sweep = num();
      const x = num() + (isRel ? cx : 0), y = num() + (isRel ? cy : 0);
      for (const seg of arcToCubicCurves(cx, cy, x, y, rx, ry, rot, largeArc, sweep)) {
        addCubic(seg[0], seg[1], seg[2], seg[3], seg[4], seg[5]);
      }
      lastCtrlX = cx; lastCtrlY = cy;
    } else if (type === 'Z') {
      if (curPath && curPath.pts.length > 1) {
        curPath.closed = true;
        const first = curPath.pts[0];
        const last = curPath.pts[curPath.pts.length - 1];
        if (Math.hypot(first.x - last.x, first.y - last.y) < 1e-4) {
          first.ix = last.ix;
          first.iy = last.iy;
          curPath.pts.pop();
        }
      }
      cx = sx; cy = sy;
      lastCtrlX = cx; lastCtrlY = cy;
    } else {
      if (!hasNum()) idx++;
    }
    prevCmd = type;
  }

  let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
  for (const sp of subpaths) {
    for (const p of sp.pts) {
      minX = Math.min(minX, p.x, p.x + p.ix, p.x + p.ox);
      maxX = Math.max(maxX, p.x, p.x + p.ix, p.x + p.ox);
      minY = Math.min(minY, p.y, p.y + p.iy, p.y + p.oy);
      maxY = Math.max(maxY, p.y, p.y + p.iy, p.y + p.oy);
    }
  }
  if (!isFinite(minX)) return [];

  const rawW = Math.max(1e-5, maxX - minX);
  const rawH = Math.max(1e-5, maxY - minY);
  const midX = (minX + maxX) / 2;
  const midY = (minY + maxY) / 2;
  const scaleX = 100 / rawW;
  const scaleY = 100 / rawH;
  const r = (n) => +n.toFixed(3);

  return subpaths.map((sp, i) => ({
    ty: 'sh',
    d: 1,
    nm: 'Path ' + (i + 1),
    ks: {
      a: 0,
      k: {
        c: sp.closed,
        v: sp.pts.map((p) => [r((p.x - midX) * scaleX), r((p.y - midY) * scaleY)]),
        i: sp.pts.map((p) => [r(p.ix * scaleX), r(p.iy * scaleY)]),
        o: sp.pts.map((p) => [r(p.ox * scaleX), r(p.oy * scaleY)]),
      },
    },
  }));
}

/** Аппроксимация SVG-дуги (команда A) кубическими кривыми Безье. */
function arcToCubicCurves(x1, y1, x2, y2, rx, ry, angleDeg, largeArcFlag, sweepFlag) {
  if (rx === 0 || ry === 0 || (x1 === x2 && y1 === y2)) return [[x1, y1, x2, y2, x2, y2]];
  const rad = (angleDeg * Math.PI) / 180;
  const cos = Math.cos(rad), sin = Math.sin(rad);
  const dx = (x1 - x2) / 2, dy = (y1 - y2) / 2;
  const x1p = cos * dx + sin * dy, y1p = -sin * dx + cos * dy;

  const rCheck = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry);
  if (rCheck > 1) { const s = Math.sqrt(rCheck); rx *= s; ry *= s; }

  const sign = largeArcFlag === sweepFlag ? -1 : 1;
  const num = Math.max(0, rx * rx * ry * ry - rx * rx * y1p * y1p - ry * ry * x1p * x1p);
  const den = rx * rx * y1p * y1p + ry * ry * x1p * x1p;
  const sq = sign * Math.sqrt(num / den);
  const cxp = sq * ((rx * y1p) / ry), cyp = sq * (-(ry * x1p) / rx);

  const cx = cos * cxp - sin * cyp + (x1 + x2) / 2;
  const cy = sin * cxp + cos * cyp + (y1 + y2) / 2;

  const vecAngle = (ux, uy, vx, vy) => {
    const dot = ux * vx + uy * vy;
    const len = Math.hypot(ux, uy) * Math.hypot(vx, vy);
    const ang = Math.acos(Math.max(-1, Math.min(1, dot / len)));
    return ux * vy - uy * vx < 0 ? -ang : ang;
  };

  const theta1 = vecAngle(1, 0, (x1p - cxp) / rx, (y1p - cyp) / ry);
  let dTheta = vecAngle((x1p - cxp) / rx, (y1p - cyp) / ry, (-x1p - cxp) / rx, (-y1p - cyp) / ry);
  if (!sweepFlag && dTheta > 0) dTheta -= 2 * Math.PI;
  if (sweepFlag && dTheta < 0) dTheta += 2 * Math.PI;

  const segments = Math.ceil(Math.abs(dTheta) / (Math.PI / 2));
  const delta = dTheta / segments;
  const alpha = (4 / 3) * Math.tan(delta / 4);
  const curves = [];

  for (let i = 0; i < segments; i++) {
    const t1 = theta1 + i * delta, t2 = t1 + delta;
    const mapPt = (px, py) => [
      cos * (rx * px) - sin * (ry * py) + cx,
      sin * (rx * px) + cos * (ry * py) + cy,
    ];
    const c1 = mapPt(Math.cos(t1) - alpha * Math.sin(t1), Math.sin(t1) + alpha * Math.cos(t1));
    const c2 = mapPt(Math.cos(t2) + alpha * Math.sin(t2), Math.sin(t2) - alpha * Math.cos(t2));
    const ep = mapPt(Math.cos(t2), Math.sin(t2));
    curves.push([c1[0], c1[1], c2[0], c2[1], ep[0], ep[1]]);
  }
  return curves;
}

/** Графический слой: прямоугольник, эллипс или произвольный SVG path. */
function createShapeLayer(layer, channels, ind, totalFrames, fps, camInd) {
  const isPath = layer.type === 'path';
  const sizeTrack = buildKeyframes(channels.size, [layer.width, layer.height], fps, true);

  let geometries = [];
  if (isPath) {
    geometries = svgPathToLottieShapes(layer.d);
  } else if (layer.type === 'ellipse') {
    geometries = [{ ty: 'el', d: 1, s: sizeTrack, p: { a: 0, k: [0, 0] }, nm: 'Ellipse' }];
  } else {
    geometries = [{
      ty: 'rc',
      d: 1,
      s: sizeTrack,
      p: { a: 0, k: [0, 0] },
      r: buildKeyframes(channels.radius, layer.radius || 0, fps, false),
      nm: 'Rectangle',
    }];
  }

  return {
    ...createBaseLayer(layer, layerTransform(layer, channels, fps), ind, totalFrames, fps, camInd),
    ty: 4,
    shapes: [{
      ty: 'gr',
      it: [
        ...geometries,
        {
          ty: 'fl',
          c: buildKeyframes(channels.color, hexToLottieColor(layer.color), fps, true),
          o: { a: 0, k: 100 },
          r: 1,
          bm: 0,
          nm: 'Fill',
        },
        {
          ty: 'tr',
          p: { a: 0, k: [0, 0] },
          a: { a: 0, k: [0, 0] },
          s: isPath ? sizeTrack : { a: 0, k: [100, 100] },
          r: { a: 0, k: 0 },
          o: { a: 0, k: 100 },
        },
      ],
      nm: 'Group',
    }],
  };
}

/** Текстовый слой: динамические документы (смена текста и цвета по кадрам). */
function createTextLayer(layer, channels, ind, totalFrames, fps, camInd) {
  const size = layer.size || 24;
  const fontName = resolveFontName(layer);

  const makeDocState = (txt, hexColor) => ({
    s: size,
    f: fontName,
    t: String(txt).replace(/\r?\n/g, '\r'),
    j: 2,
    tr: 0,
    lh: size * 1.2,
    ls: 0,
    fc: hexToLottieColor(hexColor).slice(0, 3),
  });

  const textKeys = [{ t: 0, s: makeDocState(layer.text || '', layer.color) }];
  const sortedTextEvents = [...channels.text].sort((a, b) => a.t - b.t);

  for (const item of sortedTextEvents) {
    const frame = Math.round(item.t * fps);
    const prev = textKeys[textKeys.length - 1];
    if (prev && prev.t === frame) prev.s = makeDocState(item.text, item.color);
    else textKeys.push({ t: frame, s: makeDocState(item.text, item.color) });
  }

  return {
    ...createBaseLayer(layer, layerTransform(layer, channels, fps), ind, totalFrames, fps, camInd),
    ty: 5,
    t: {
      d: { k: textKeys },
      p: {},
      m: { g: 1, a: { a: 0, k: [0, 0] } },
      a: [],
    },
  };
}

/** Разбирает события камеры на каналы anchor (позиция) и scale (zoom × 100). */
function collectCameraEvents(comp, cameraUpdates) {
  const anchor = [];
  const scale = [];
  let curX = comp.width / 2;
  let curY = comp.height / 2;

  for (const u of [...cameraUpdates].sort((a, b) => a.t - b.t)) {
    if (u.set.x !== undefined || u.set.y !== undefined) {
      curX = u.set.x !== undefined ? u.set.x : curX;
      curY = u.set.y !== undefined ? u.set.y : curY;
      anchor.push({ t: u.t, dur: u.dur, ease: u.ease, val: [curX, curY, 0] });
    }
    if (u.set.zoom !== undefined) {
      const sc = u.set.zoom * 100;
      scale.push({ t: u.t, dur: u.dur, ease: u.ease, val: [sc, sc, 100] });
    }
  }
  return { anchor, scale };
}

/** Камера — это null-слой (ty: 3), к которому привязаны все обычные слои. */
function createCameraRig(comp, cameraUpdates, fps, totalFrames, camInd) {
  const { anchor, scale } = collectCameraEvents(comp, cameraUpdates);
  return {
    ddd: 0,
    ind: camInd,
    nm: 'CAMERA_RIG',
    ty: 3,
    sr: 1,
    ks: {
      o: { a: 0, k: 0 },
      r: { a: 0, k: 0 },
      p: { a: 0, k: [comp.width / 2, comp.height / 2, 0] },
      a: buildKeyframes(anchor, [comp.width / 2, comp.height / 2, 0], fps, true),
      s: buildKeyframes(scale, [100, 100, 100], fps, true),
    },
    ao: 0,
    ip: 0,
    op: totalFrames,
    st: 0,
    bm: 0,
  };
}

function resolveFontName(layer) {
  return String(layer.font || 'Arial').trim() || 'Arial';
}

/** Компилирует разобранный DSL в полный Lottie-документ. */
function compileToLottie(parsed) {
  const comp = parsed.comp;
  const fps = comp.fps || 60;
  const totalFrames = Math.max(1, Math.round((comp.duration || 5) * fps));

  // В Lottie слои рисуются сверху вниз по массиву, поэтому разворачиваем порядок вставки
  const lottieLayers = [];
  let ind = 1;
  for (const layer of [...parsed.layers.values()].reverse()) {
    const channels = collectLayerEvents(layer, parsed.updates);
    const build = layer.type === 'text' ? createTextLayer : createShapeLayer;
    lottieLayers.push(build(layer, channels, ind++, totalFrames, fps, CAMERA_INDEX));
  }
  lottieLayers.push(createCameraRig(comp, parsed.cameraUpdates, fps, totalFrames, CAMERA_INDEX));

  const usedFonts = new Set();
  for (const layer of parsed.layers.values()) {
    if (layer.type === 'text') usedFonts.add(resolveFontName(layer));
  }
  if (!usedFonts.size) usedFonts.add('Arial');

  return {
    v: '5.12.2',
    fr: fps,
    ip: 0,
    op: totalFrames,
    w: comp.width,
    h: comp.height,
    nm: 'LSL_Camera_Animation',
    ddd: 0,
    assets: [],
    fonts: {
      list: [...usedFonts].map((fName) => ({
        fName,
        fFamily: fName,
        fStyle: 'Regular',
        ascent: 75,
      })),
    },
    layers: lottieLayers,
  };
}

/* ============================================================================
 * 5. ЗАГРУЗЧИК ШРИФТОВ (Google Fonts + Base64 для экспорта в видео)
 * ========================================================================== */

const SYSTEM_FONTS = new Set([
  'arial', 'helvetica', 'times new roman', 'courier new',
  'georgia', 'verdana', 'tahoma', 'trebuchet ms', 'impact',
  'sans-serif', 'serif', 'monospace', 'cursive', 'fantasy',
]);

const fontCssCache = new Map();

const blobToDataUrl = (blob) => new Promise((resolve) => {
  const reader = new FileReader();
  reader.onloadend = () => resolve(reader.result);
  reader.readAsDataURL(blob);
});

/** Заменяет ссылки на файлы шрифтов в CSS на Base64 data-URL. */
async function embedFontUrls(css) {
  let embedded = css;
  const urls = [...css.matchAll(/url\((https:\/\/[^)]+)\)/g)].map((m) => m[1]);
  for (const fontUrl of urls) {
    try {
      const res = await fetch(fontUrl);
      if (!res.ok) continue;
      embedded = embedded.split(fontUrl).join(await blobToDataUrl(await res.blob()));
    } catch (err) {
      console.warn('Не удалось встроить файл шрифта:', fontUrl, err);
    }
  }
  return embedded;
}

/** Загружает CSS Google Fonts с кириллицей и латиницей, шрифты встраиваются. */
async function loadGoogleFontCss(family) {
  const url = 'https://fonts.googleapis.com/css?family='
    + encodeURIComponent(family).replace(/%20/g, '+') + '&display=swap';
  const res = await fetch(url);
  if (!res.ok) throw new Error('HTTP ' + res.status);

  const rawCss = await res.text();
  const filtered = rawCss
    .split('/*')
    .filter((block) => block.trim())
    .map((block) => '/*' + block)
    .filter((block) => block.includes('cyrillic */') || block.includes('latin */'))
    .join('\n');

  return embedFontUrls(filtered || rawCss);
}

/** Подключает шрифты в <head> и дожидается их готовности в document.fonts. */
async function ensureFontsLoaded(fontsList) {
  for (const { fFamily: family } of fontsList) {
    if (!family || SYSTEM_FONTS.has(family.toLowerCase()) || fontCssCache.has(family)) continue;
    try {
      const css = await loadGoogleFontCss(family);
      fontCssCache.set(family, css);

      const styleTag = document.createElement('style');
      styleTag.setAttribute('data-lottie-font', family);
      styleTag.textContent = css;
      document.head.appendChild(styleTag);

      if (document.fonts && document.fonts.load) {
        await document.fonts.load('16px "' + family + '"');
      }
    } catch (err) {
      console.warn('Шрифт не найден в Google Fonts (будет использован системный):', family, err);
    }
  }
}

/* ============================================================================
 * 6. UI, ПЛЕЕР И ЭКСПОРТ
 * ========================================================================== */

const els = {
  editor: document.getElementById('dsl-editor'),
  errorBox: document.getElementById('error-box'),
  lottieBox: document.getElementById('lottie-box'),
  stageWrap: document.getElementById('stage-wrap'),
  rawJson: document.getElementById('raw-json-view'),
  scrubber: document.getElementById('scrubber'),
  timecode: document.getElementById('timecode'),
  btnCompile: document.getElementById('btn-compile'),
  btnPlay: document.getElementById('btn-play'),
  btnSaveDsl: document.getElementById('btn-save-dsl'),
  btnLoadDsl: document.getElementById('btn-load-dsl'),
  fileDsl: document.getElementById('file-dsl'),
  btnResetDsl: document.getElementById('btn-reset-dsl'),
  btnSaveLottie: document.getElementById('btn-save-lottie'),
  btnExport: document.getElementById('btn-export-video'),
  tabPreview: document.getElementById('tab-preview'),
  tabRaw: document.getElementById('tab-raw'),
  recBadge: document.getElementById('rec-badge'),
};

const state = {
  anim: null,
  lottieData: null,
  isPlaying: true,
  isExporting: false,
};

/* ---------- Сообщения об ошибках и вкладки ---------- */

function showError(message) {
  els.errorBox.textContent = message;
  els.errorBox.classList.add('visible');
}

function hideError() {
  els.errorBox.textContent = '';
  els.errorBox.classList.remove('visible');
}

function switchTab(tab) {
  const showPreview = tab === 'preview';
  els.tabPreview.classList.toggle('active', showPreview);
  els.tabRaw.classList.toggle('active', !showPreview);
  els.stageWrap.style.display = showPreview ? 'flex' : 'none';
  els.rawJson.style.display = showPreview ? 'none' : 'block';
}

/* ---------- Плеер ---------- */

/** Вписывает контейнер превью в свободное место панели. */
function fitStageBox(w, h) {
  const rect = els.stageWrap.getBoundingClientRect();
  const scale = Math.min(Math.max(120, rect.width - 40) / w, Math.max(120, rect.height - 40) / h, 1);
  els.lottieBox.style.width = Math.round(w * scale) + 'px';
  els.lottieBox.style.height = Math.round(h * scale) + 'px';
}

function updateTimeUI() {
  if (!state.anim || !state.lottieData) return;
  const { currentFrame: frame, totalFrames } = state.anim;
  const fps = state.lottieData.fr;
  els.scrubber.value = Math.round(frame);
  els.timecode.textContent = (frame / fps).toFixed(2) + ' / ' + (totalFrames / fps).toFixed(2) + 's';
}

function pausePlayback() {
  if (!state.anim) return;
  state.anim.pause();
  state.isPlaying = false;
  els.btnPlay.textContent = '▶ Старт';
}

function resumePlayback() {
  if (!state.anim) return;
  state.anim.play();
  state.isPlaying = true;
  els.btnPlay.textContent = '⏸ Пауза';
}

function togglePlayback() {
  if (!state.anim || state.isExporting) return;
  if (state.isPlaying) pausePlayback();
  else resumePlayback();
}

/* ---------- Компиляция и запуск ---------- */

async function compileAndRun() {
  if (typeof lottie === 'undefined') {
    showError('Библиотека lottie-web не загружена. Проверьте подключение к CDN.');
    return;
  }
  try {
    const compiled = compileToLottie(parseDSL(els.editor.value));

    // Шрифты подгружаем до инициализации плеера
    await ensureFontsLoaded(compiled.fonts.list);

    state.lottieData = compiled;
    localStorage.setItem(STORAGE_KEY, els.editor.value);
    hideError();
    els.rawJson.textContent = JSON.stringify(compiled, null, 2);

    if (state.anim) state.anim.destroy();
    els.lottieBox.innerHTML = '';
    fitStageBox(compiled.w, compiled.h);

    state.anim = lottie.loadAnimation({
      container: els.lottieBox,
      renderer: 'svg',
      loop: true,
      autoplay: true,
      animationData: deepClone(compiled),
      rendererSettings: {
        preserveAspectRatio: 'xMidYMid meet',
        progressiveLoad: false,
      },
    });
    state.isPlaying = true;
    els.btnPlay.textContent = '⏸ Пауза';
    els.scrubber.max = Math.max(1, compiled.op - 1);
    state.anim.addEventListener('enterFrame', updateTimeUI);
  } catch (err) {
    showError('Ошибка компиляции: ' + err.message);
  }
}

/* ---------- Скачивание файлов ---------- */

function downloadBlob(blob, filename) {
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  setTimeout(() => { URL.revokeObjectURL(a.href); a.remove(); }, 2000);
}

function saveDslFile() {
  downloadBlob(new Blob([els.editor.value], { type: 'text/plain;charset=utf-8' }), 'animation.lsl');
}

function saveLottieJson() {
  if (!state.lottieData) return;
  downloadBlob(
    new Blob([JSON.stringify(state.lottieData, null, 2)], { type: 'application/json' }),
    'animation.lottie.json'
  );
}

/** Рисует текущий SVG-кадр плеера на offscreen-canvas. */
function renderSvgFrameToCanvas(ctx, width, height, fontDefs) {
  return new Promise((resolve) => {
    const svgEl = els.lottieBox.querySelector('svg');
    if (!svgEl) { resolve(); return; }

    const clone = svgEl.cloneNode(true);
    clone.setAttribute('xmlns', SVG_NS);
    clone.setAttribute('width', width);
    clone.setAttribute('height', height);
    if (fontDefs) clone.insertBefore(fontDefs.cloneNode(true), clone.firstChild);

    const svgBlob = new Blob(
      [new XMLSerializer().serializeToString(clone)],
      { type: 'image/svg+xml;charset=utf-8' }
    );
    const url = URL.createObjectURL(svgBlob);
    const img = new Image();
    img.onload = () => {
      ctx.clearRect(0, 0, width, height);
      ctx.drawImage(img, 0, 0, width, height);
      URL.revokeObjectURL(url);
      resolve();
    };
    img.onerror = () => { URL.revokeObjectURL(url); resolve(); };
    img.src = url;
  });
}

/* ---------- Экспорт видео ---------- */

function pickRecorderMime() {
  if (!window.MediaRecorder) return null;
  const candidates = [
    'video/mp4;codecs="avc1.42E01E"',
    'video/mp4',
    'video/webm;codecs=vp9',
    'video/webm;codecs=vp8',
    'video/webm',
  ];
  return candidates.find((m) => MediaRecorder.isTypeSupported(m)) || null;
}

/** Быстро растеризует текущий SVG-кадр плеера в Canvas. */
function drawCurrentSvgToCanvas(ctx, width, height, fontStyleText) {
  return new Promise((resolve) => {
    const svgEl = els.lottieBox.querySelector('svg');
    if (!svgEl) { resolve(); return; }

    // Клонируем только сам SVG и подставляем размеры
    const clone = svgEl.cloneNode(true);
    clone.setAttribute('xmlns', SVG_NS);
    clone.setAttribute('width', width);
    clone.setAttribute('height', height);

    if (fontStyleText) {
      const style = document.createElementNS(SVG_NS, 'style');
      style.textContent = fontStyleText;
      clone.insertBefore(style, clone.firstChild);
    }

    const svgStr = new XMLSerializer().serializeToString(clone);
    const url = URL.createObjectURL(new Blob([svgStr], { type: 'image/svg+xml;charset=utf-8' }));

    const img = new Image();
    img.onload = () => {
      ctx.fillStyle = '#000000';
      ctx.fillRect(0, 0, width, height);
      ctx.drawImage(img, 0, 0, width, height);
      URL.revokeObjectURL(url);
      resolve();
    };
    img.onerror = () => {
      URL.revokeObjectURL(url);
      resolve();
    };
    img.src = url;
  });
}

/** Быстрый покадровый рендер SVG-сцены в WebM (VP9) через Mediabunny. */
async function exportVideo() {
  if (!state.lottieData || !state.anim || state.isExporting) return;

  if (typeof Mediabunny === 'undefined') {
    showError('Не найдена библиотека Mediabunny — проверьте тег <script>.');
    return;
  }

  switchTab('preview');
  state.isExporting = true;
  pausePlayback();
  els.recBadge.classList.add('on');
  els.btnExport.disabled = true;

  const { w, h, fr: fps, op: totalFrames } = state.lottieData;
  const encW = w % 2 === 0 ? w : w + 1;
  const encH = h % 2 === 0 ? h : h + 1;

  const fontStyleText = fontCssCache.size > 0 ? [...fontCssCache.values()].join('\n') : '';

  const offCanvas = document.createElement('canvas');
  offCanvas.width = encW;
  offCanvas.height = encH;
  const offCtx = offCanvas.getContext('2d', { alpha: false });

  const { Output, WebMOutputFormat, BufferTarget, CanvasSource, Quality, canEncodeVideo } = Mediabunny;

  let output = null;

  try {
    if (!(await canEncodeVideo('vp9', { width: encW, height: encH }))) {
      throw new Error('Кодек VP9 недоступен в этом браузере.');
    }

    output = new Output({
      format: new WebMOutputFormat(),
      target: new BufferTarget(),
    });

    const videoSource = new CanvasSource(offCanvas, {
      codec: 'vp9',
      quality: new Quality({ bitrate: 8_000_000 }),
      keyFrameInterval: 1, // ключевой кадр раз в секунду — как раньше
    });
    output.addVideoTrack(videoSource, { frameRate: fps });
    await output.start();

    const frameDur = 1 / fps;

    for (let f = 0; f < totalFrames; f++) {
      state.anim.goToAndStop(f, true);
      await drawCurrentSvgToCanvas(offCtx, encW, encH, fontStyleText);

      // add() возвращает промис: ожидание заменяет ваш ручной бэкпрешур
      await videoSource.add(f * frameDur, frameDur);

      if (f % 10 === 0 || f === totalFrames - 1) {
        els.scrubber.value = f;
        els.timecode.textContent = (f / fps).toFixed(2) + ' / ' + (totalFrames / fps).toFixed(2) + 's';
      }
    }

    videoSource.close();
    await output.finalize();

    downloadBlob(new Blob([output.target.buffer], { type: 'video/webm' }), 'lottie_export.webm');
  } catch (err) {
    if (output) { try { await output.cancel(); } catch { /* уже закрыт */ } }
    showError('Ошибка экспорта видео: ' + err.message);
  } finally {
    state.isExporting = false;
    els.recBadge.classList.remove('on');
    els.btnExport.disabled = false;
    resumePlayback();
  }
}

/* ---------- Привязка событий ---------- */

function onScrubberInput() {
  if (!state.anim || state.isExporting) return;
  pausePlayback();
  state.anim.goToAndStop(Number(els.scrubber.value), true);
  updateTimeUI();
}

function loadDslFromFile(event) {
  const file = event.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = (ev) => {
    els.editor.value = ev.target.result;
    compileAndRun();
  };
  reader.readAsText(file);
  event.target.value = '';
}

function resetToDemo() {
  els.editor.value = DEFAULT_DSL;
  compileAndRun();
}

const CLICK_HANDLERS = [
  [els.btnCompile, compileAndRun],
  [els.btnSaveDsl, saveDslFile],
  [els.btnLoadDsl, () => els.fileDsl.click()],
  [els.btnResetDsl, resetToDemo],
  [els.btnSaveLottie, saveLottieJson],
  [els.btnPlay, togglePlayback],
  [els.btnExport, exportVideo],
];
for (const [element, handler] of CLICK_HANDLERS) element.addEventListener('click', handler);

els.fileDsl.addEventListener('change', loadDslFromFile);
els.scrubber.addEventListener('input', onScrubberInput);
els.tabPreview.addEventListener('click', () => switchTab('preview'));
els.tabRaw.addEventListener('click', () => switchTab('raw'));

els.editor.addEventListener('keydown', (e) => {
  if (e.code === 'Enter' && (e.ctrlKey || e.metaKey)) {
    e.preventDefault();
    compileAndRun();
  }
});

window.addEventListener('resize', () => {
  if (state.lottieData) fitStageBox(state.lottieData.w, state.lottieData.h);
});

/* ---------- Инициализация ---------- */

els.editor.value = localStorage.getItem(STORAGE_KEY) || DEFAULT_DSL;
compileAndRun();
