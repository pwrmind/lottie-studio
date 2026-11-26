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
-- 🎬 LSL STUDIO — САМОПРЕЗЕНТАЦИЯ ВОЗМОЖНОСТЕЙ В РЕАЛЬНОМ ВРЕМЕНИ
-- Формат: 540x960 (вертикальный), длительность: 14.0 сек
-- Каждая фича подписывается в HUD и сразу демонстрируется на сцене
-- ============================================================================

UPDATE composition SET width = 540, height = 960, fps = 60, duration = 14.0;

-- Начальная точка камеры (Сцена 1)
UPDATE camera SET x = 350, y = 480, zoom = 1.0 AT 0.0;

-- ============================================================================
-- 1. ВИРТУАЛЬНЫЙ МИР И 4 КАРТОЧКИ-ЭКРАНА
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('world_bg', 'rect', 1475, 480, 3600, 1600, '#070a12', 0,  100),
  ('sc_1',     'rect', 350,  490, 460,  700,  '#0f172a', 32, 100),
  ('sc_2',     'rect', 1100, 490, 460,  700,  '#17122b', 32, 100),
  ('sc_3',     'rect', 1850, 490, 460,  700,  '#0c2229', 32, 100),
  ('sc_4',     'rect', 2600, 490, 460,  700,  '#1c1526', 32, 100);

-- ============================================================================
-- 2. ЭКРАН 1 [0.0s — 3.4s]: МОРФИНГ ГЕОМЕТРИИ + КРИВЫЕ БЕЗЬЕ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s1_morph', 'rect', 350, 440, 110, 110, '#38bdf8', 55, 100),
  ('s1_pill',  'rect', 350, 620, 60,  12,  '#1e293b', 6,  100);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s1_num',   'text', '01 · МОРФИНГ & БЕЗЬЕ',         'JetBrains Mono', 350, 210, 15, '#38bdf8', 100),
  ('s1_title', 'text', 'LSL',                          'Montserrat',     350, 455, 38, '#070a12', 100),
  ('s1_code',  'text', 'width · height · radius',      'JetBrains Mono', 350, 545, 16, '#94a3b8', 0),
  ('s1_ease',  'text', 'ease = [0.22, 1, 0.36, 1]',    'JetBrains Mono', 350, 580, 14, '#38bdf8', 0);

-- ============================================================================
-- 3. ЭКРАН 2 [3.4s — 7.0s]: SQL-ВЫБОРКИ (WHERE LIKE / AND / OR)
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('eq_1', 'rect', 965,  560, 44, 50, '#334155', 10, 100),
  ('eq_2', 'rect', 1032, 560, 44, 50, '#334155', 10, 100),
  ('eq_3', 'rect', 1100, 560, 44, 50, '#334155', 10, 100),
  ('eq_4', 'rect', 1168, 560, 44, 50, '#334155', 10, 100),
  ('eq_5', 'rect', 1235, 560, 44, 50, '#334155', 10, 100);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s2_num',   'text', '02 · SQL-СЕЛЕКТОРЫ',           'JetBrains Mono', 1100, 210, 15, '#c084fc', 100),
  ('s2_q1',    'text', "WHERE id LIKE 'eq_%'",         'JetBrains Mono', 1100, 285, 17, '#e9d5ff', 100),
  ('s2_q2',    'text', "WHERE id = 'eq_2' OR id = 'eq_4'", 'JetBrains Mono', 1100, 320, 13, '#94a3b8', 0);

-- ============================================================================
-- 4. ЭКРАН 3 [7.0s — 10.6s]: ЦИКЛЫ, ПОВТОРЫ И YOYO-МАЯТНИК
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('yo_ring', 'ellipse', 1850, 470, 150, 150, '#22c55e', 0,  25),
  ('yo_box',  'rect',    1850, 470, 110, 110, '#22c55e', 24, 100);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s3_num',   'text', '03 · REPEAT & YOYO',           'JetBrains Mono', 1850, 210, 15, '#4ade80', 100),
  ('s3_icon',  'text', '↻',                            'Montserrat',     1850, 484, 40, '#052e16', 100),
  ('s3_code',  'text', 'repeat = 3, yoyo = true',      'JetBrains Mono', 1850, 625, 17, '#bbf7d0', 100);

-- ============================================================================
-- 5. ЭКРАН 4 [10.6s — 14.0s]: МОНТАЖНЫЙ КАТ + 2D-КАМЕРА + ЭКСПОРТ
-- ============================================================================
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('s4_btn',   'rect', 2600, 470, 140, 140, '#f43f5e', 70, 100);

INSERT INTO layers (id, type, text, font, x, y, size, color, opacity) VALUES
  ('s4_num',   'text', '04 · КАМЕРА, КАТ & ЭКСПОРТ',   'JetBrains Mono', 2600, 210, 15, '#fb7185', 100),
  ('s4_cut',   'text', 'AT 10.6 (duration = 0)',       'JetBrains Mono', 2600, 310, 16, '#fda4af', 100),
  ('s4_btn_t', 'text', 'JSON & MP4',                   'Playpen Sans',   2600, 480, 24, '#ffffff', 0),
  ('s4_sub',   'text', '1 HTML-файл · Без зависимостей','Playpen Sans',  2600, 625, 17, '#cbd5e1', 0);

-- ============================================================================
-- 6. ФИКСИРОВАННЫЙ HUD (fixed = true — остаётся на экране при движении камеры)
-- ============================================================================
INSERT INTO layers (id, type, fixed, x, y, width, height, color, radius, opacity) VALUES
  ('hud_top_bg', 'rect', true, 270, 72,  460, 44, '#0f172a', 12, 95),
  ('hud_bar_bg', 'rect', true, 270, 912, 460, 8,  '#1e293b', 4,  100),
  ('hud_bar',    'rect', true, 270, 912, 10,  8,  '#38bdf8', 4,  100);

INSERT INTO layers (id, type, fixed, text, font, x, y, size, color, opacity) VALUES
  ('hud_status', 'text', true, 'ФИЧА 1/4: МОРФИНГ ФОРМЫ', 'JetBrains Mono', 270, 78, 14, '#38bdf8', 100);

-- ============================================================================
-- ТАЙМЛАЙН ДЕМОНСТРАЦИИ (14.0 СЕКУНД БЕЗ ПАУЗ)
-- ============================================================================

-- Глобальный прогресс-бар внизу экрана (0.0s -> 14.0s)
UPDATE layers SET width = 460 WHERE id = 'hud_bar' AT 0.0 WITH (duration = 14.0, ease = 'linear');

-- ----------------------------------------------------------------------------
-- БЛОК 1 [0.0s — 3.4s]: МОРФИНГ РАЗМЕРОВ И КАСТОМНАЯ КРИВАЯ БЕЗЬЕ
-- ----------------------------------------------------------------------------
UPDATE layers SET width = 330, height = 92, radius = 22 WHERE id = 's1_morph' AT 0.3 WITH (duration = 0.75, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET opacity = 100                         WHERE id IN ('s1_code', 's1_ease') AT 0.65 WITH (duration = 0.45, ease = 'out');
UPDATE layers SET width = 280, color = '#38bdf8'        WHERE id = 's1_pill'  AT 0.8 WITH (duration = 0.8, ease = 'out');
UPDATE camera SET zoom = 1.07                           AT 0.5 WITH (duration = 1.5, ease = 'inOut');

-- Плавный переезд камеры ко 2-й фиче [2.2s -> 3.4s]
UPDATE camera SET x = 1100, y = 480, zoom = 1.0 AT 2.2 WITH (duration = 1.2, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- БЛОК 2 [3.4s — 7.0s]: МАССОВЫЕ SQL-ВЫБОРКИ (LIKE + OR)
-- ----------------------------------------------------------------------------
UPDATE layers SET color = '#c084fc' WHERE id = 'hud_bar' AT 3.1;
UPDATE layers SET text = 'ФИЧА 2/4: SQL WHERE LIKE / OR', color = '#c084fc' WHERE id = 'hud_status' AT 3.1;

-- Шаг 2а: Поднимаем все 5 столбиков одной командой LIKE 'eq_%'
UPDATE layers SET height = 220, y = 495, color = '#a855f7' WHERE id LIKE 'eq_%' AT 3.4 WITH (duration = 0.6, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET opacity = 100                            WHERE id = 's2_q2'     AT 4.1 WITH (duration = 0.4, ease = 'out');

-- Шаг 2б: Выборочно акцентируем чётные столбики через OR
UPDATE layers SET height = 300, y = 455, color = '#38bdf8' WHERE id = 'eq_2' OR id = 'eq_4' AT 4.3 WITH (duration = 0.6, ease = 'inOut');
UPDATE layers SET radius = 22                              WHERE id LIKE 'eq_%'            AT 5.0 WITH (duration = 0.4, ease = 'out');

-- Плавный переезд камеры к 3-й фиче [5.8s -> 7.0s]
UPDATE camera SET x = 1850, y = 480, zoom = 1.0 AT 5.8 WITH (duration = 1.2, ease = 'inOut');

-- ----------------------------------------------------------------------------
-- БЛОК 3 [7.0s — 10.6s]: REPEAT И YOYO-МАЯТНИК
-- ----------------------------------------------------------------------------
UPDATE layers SET color = '#22c55e' WHERE id = 'hud_bar' AT 6.7;
UPDATE layers SET text = 'ФИЧА 3/4: REPEAT & YOYO', color = '#4ade80' WHERE id = 'hud_status' AT 6.7;

-- Вращение квадрата + пульсация кольца 3 раза туда-обратно (7.0s + 3 * 0.8s = 9.4s)
UPDATE layers SET rotation = 90, radius = 55, scale = 115 WHERE id = 'yo_box'  AT 7.0 WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
UPDATE layers SET rotation = 180                          WHERE id = 'yo_icon' AT 7.0 WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
UPDATE layers SET width = 260, height = 260, opacity = 45 WHERE id = 'yo_ring' AT 7.0 WITH (duration = 0.8, ease = 'inOut', repeat = 3, yoyo = true);
UPDATE camera SET zoom = 1.08                             AT 7.2 WITH (duration = 1.2, ease = 'inOut', repeat = 1, yoyo = true);

-- ----------------------------------------------------------------------------
-- БЛОК 4 [10.6s — 14.0s]: МОНТАЖНЫЙ КАТ (duration = 0) И ФИНАЛЬНЫЙ ЭКСПОРТ
-- ----------------------------------------------------------------------------
UPDATE layers SET color = '#f43f5e' WHERE id = 'hud_bar' AT 10.6;
UPDATE layers SET text = 'ФИЧА 4/4: МОНТАЖНЫЙ КАТ & ЭКСПОРТ', color = '#fb7185' WHERE id = 'hud_status' AT 10.6;

-- Мгновенный перескок камеры на 4-й экран без пролёта
UPDATE camera SET x = 2600, y = 480, zoom = 0.92 AT 10.6;

-- Наезд камеры + превращение круга в финальную кнопку экспорта
UPDATE camera SET x = 2600, y = 490, zoom = 1.12          AT 10.7 WITH (duration = 1.6, ease = 'inOut');
UPDATE layers SET width = 340, height = 86, radius = 43   WHERE id = 's4_btn' AT 10.7 WITH (duration = 0.7, ease = [0.22, 1, 0.36, 1]);
UPDATE layers SET opacity = 100                           WHERE id IN ('s4_btn_t', 's4_sub') AT 11.1 WITH (duration = 0.5, ease = 'out');

-- Финальная стабилизация общего плана [12.5s -> 13.8s]
UPDATE camera SET x = 2600, y = 480, zoom = 1.0 AT 12.5 WITH (duration = 1.3, ease = 'inOut');

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

/** Разбирает хвост UPDATE: SET-часть плюс необязательные WHERE / AT / WITH (...). */
function splitUpdateTail(rest) {
  const marks = findTopLevelKeywords(rest, ['WHERE', 'AT', 'WITH'])
    .sort((a, b) => a.index - b.index);
  const tail = { set: '', where: null, at: 0, with: {} };
  if (!marks.length) { tail.set = rest.trim(); return tail; }

  tail.set = rest.slice(0, marks[0].index).trim();
  for (let i = 0; i < marks.length; i++) {
    const { word, index } = marks[i];
    const end = i + 1 < marks.length ? marks[i + 1].index : rest.length;
    const segment = rest.slice(index + word.length, end).trim();

    if (word === 'AT') tail.at = parseFloat(segment) || 0;
    else if (word === 'WITH') tail.with = parseAssignments(stripParens(segment));
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

function parseInsertStatement(stmt, layers) {
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
    const layer = { ...DEFAULT_LAYER };
    columns.forEach((col, i) => { layer[col] = values[i]; });
    if (!layer.id) throw new Error('У каждого слоя в INSERT должен быть указан id');
    layers.set(layer.id, layer);
  }
  return true;
}

function parseCompositionUpdate(stmt, comp) {
  const match = stmt.match(/^UPDATE\s+composition\s+SET\s+(.+)$/is);
  if (!match) return false;
  Object.assign(comp, parseAssignments(match[1]));
  return true;
}

function parseCameraUpdate(stmt, cameraUpdates) {
  const match = stmt.match(/^UPDATE\s+camera\s+SET\s+(.+)$/is);
  if (!match) return false;
  const tail = splitUpdateTail(match[1]);
  cameraUpdates.push(makeUpdate(tail.set, tail.at, tail.with));
  return true;
}

function parseLayerUpdate(stmt, updates) {
  const match = stmt.match(/^UPDATE\s+layers\s+SET\s+(.+)$/is);
  if (!match) return false;

  const tail = splitUpdateTail(match[1]);
  const update = makeUpdate(tail.set, tail.at, tail.with);
  update.matchFn = tail.where ? compileWherePredicate(tail.where) : () => true;
  updates.push(update);
  return true;
}

/** Обработчики инструкций: каждая возвращает true, если распознала выражение. */
const STATEMENT_PARSERS = [
  // INSERT INTO layers (...) VALUES (...), (...);
  (stmt, ctx) => parseInsertStatement(stmt, ctx.layers),
  // UPDATE composition SET ...;
  (stmt, ctx) => parseCompositionUpdate(stmt, ctx.comp),
  // UPDATE camera SET ... [AT ...] [WITH (...)];
  (stmt, ctx) => parseCameraUpdate(stmt, ctx.cameraUpdates),
  // UPDATE layers SET ... [WHERE ...] [AT ...] [WITH (...)];
  (stmt, ctx) => parseLayerUpdate(stmt, ctx.updates),
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
    const stmt = raw.trim();
    if (!stmt) continue;
    const matched = STATEMENT_PARSERS.some((parse) => parse(stmt, ctx));
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
  if (!sorted.length) return { a: 0, k: make(initialVal) };

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

/** Базовый слой Lottie: непропорциональные слои привязываются к камере. */
function createBaseLayer(name, ks, ind, totalFrames, camInd, fixed) {
  const layer = { ddd: 0, ind, nm: name, sr: 1, ks, ao: 0, ip: 0, op: totalFrames, st: 0, bm: 0 };
  if (!fixed) layer.parent = camInd;
  return layer;
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

/** Графический слой: прямоугольник или эллипс с заливкой и анимируемым размером. */
function createShapeLayer(layer, channels, ind, totalFrames, fps, camInd) {
  const sizeTrack = buildKeyframes(channels.size, [layer.width, layer.height], fps, true);

  const geometry = layer.type === 'ellipse'
    ? { ty: 'el', d: 1, s: sizeTrack, p: { a: 0, k: [0, 0] }, nm: 'Ellipse' }
    : {
        ty: 'rc',
        d: 1,
        s: sizeTrack,
        p: { a: 0, k: [0, 0] },
        r: buildKeyframes(channels.radius, layer.radius || 0, fps, false),
        nm: 'Rectangle',
      };

  return {
    ...createBaseLayer(layer.id, layerTransform(layer, channels, fps), ind, totalFrames, camInd, layer.fixed),
    ty: 4,
    shapes: [{
      ty: 'gr',
      it: [
        geometry,
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
          s: { a: 0, k: [100, 100] },
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
    ...createBaseLayer(layer.id, layerTransform(layer, channels, fps), ind, totalFrames, camInd, layer.fixed),
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
