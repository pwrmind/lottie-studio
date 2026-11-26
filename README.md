# 🎬 Lottie Scenario Language (`*.lsl`) & Studio

> **Пишите векторную анимацию и моушн-дизайн как SQL-запросы. Компилируйте напрямую в Lottie JSON и видео в один клик.**

**Lottie Scenario Language (LSL)** — это декларативный, SQL-подобный предметно-ориентированный язык (DSL) и однофайловая браузерная студия для создания 2D-анимаций, презентационных карточек, инфографики и вертикальных видео (Shorts / Reels) без тяжёлых графических редакторов.

---

## ✨ Ключевые особенности

- **Читаемый SQL-синтаксис:** Сценарий описывается через привычные инструкции `INSERT INTO layers` и `UPDATE ... SET ... WHERE ... AT <t> WITH (...)`.
- **Управляемая 2D-камера (`CAMERA_RIG`):** Размещайте объекты в большом виртуальном мире и управляйте панорамами, наездами (`zoom`) и мгновенными монтажными катами (`duration = 0`) через `UPDATE camera`.
- **Чистый Lottie (Bodymovin JSON) на выходе:** Компилятор транслирует сценарий в стандартный `.lottie.json` с ключевыми кадрами и кривыми Безье (`linear`, `in`, `out`, `inOut`), совместимый с Web, iOS и Android.
- **Двухпанельная студия без сборки (Zero-Build):** Весь движок, парсер, превью на базе `lottie-web`, просмотр Raw JSON и покадровый экспорт видео (`MP4` / `WebM`) упакованы в один автономный HTML-файл.
- **Дружелюбность к LLM:** Благодаря строгой и знакомой грамматике SQL, языковые модели генерируют валидные `.lsl`-сценарии с первого раза.

---

## 🚀 Быстрый старт

1. Скачайте файл `index.html` из этого репозитория.
2. Откройте его в любом современном браузере (Chrome, Edge, Firefox, Safari).
3. Напишите или вставьте сценарий в левую панель и нажмите **«▶ Собрать»** (`Ctrl + Enter`).
4. Экспортируйте результат как **`.lottie.json`**, скачайте исходник **`.lsl`** или запишите готовое видео кнопкой **«⏺ Видео»**.

---

## 📖 Справочник языка LSL

### 1. Настройка холста (`composition`)
Задаёт разрешение окна вывода, частоту кадров и общую длительность ролика в секундах:

```sql
UPDATE composition SET width = 540, height = 960, fps = 60, duration = 10.0;
```

### 2. Добавление объектов (`INSERT INTO layers`)
Создаёт слои на сцене. Поддерживаются типы `rect` (прямоугольник), `ellipse` (круг/эллипс) и `text` (текст):

```sql
INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('bg',   'rect',    400, 480, 1400, 1800, '#090d16', 0,  100),
  ('card', 'rect',    400, 480, 420,  260,  '#1e293b', 28, 0),
  ('dot',  'ellipse', 250, 480, 36,   36,   '#38bdf8', 0,  100);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('title', 'text', 'Hello, LSL!', 400, 480, 36, '#f8fafc', 0);
```

| Параметр | Описание | По умолчанию |
| :--- | :--- | :--- |
| `id` | Уникальный идентификатор слоя | *(обязательно)* |
| `type` | Тип объекта: `'rect'`, `'ellipse'`, `'text'` | `'rect'` |
| `x`, `y` | Координаты центра объекта в мировом пространстве | `0, 0` |
| `width`, `height` | Ширина и высота фигуры (`rect` / `ellipse`) | `100, 100` |
| `radius` | Скругление углов для `'rect'` | `0` |
| `color` | Цвет заливки или текста в формате HEX (`'#38bdf8'`) | `'#ffffff'` |
| `text`, `size` | Содержимое и кегль шрифта для `'text'` | `'', 24` |
| `scale`, `rotation` | Масштаб (в %) и угол поворота (в градусах) | `100, 0` |
| `opacity` | Непрозрачность (`0` — невидим, `100` — полностью виден) | `100` |
| `fixed` | Если `true`, слой игнорирует камеру (HUD / титры поверх экрана) | `false` |

### 3. Анимация объектов (`UPDATE layers`)
Изменяет любые свойства одного или нескольких слоёв в заданный момент времени `AT <секунды>` с плавностью `WITH (...)`:

```sql
-- Плавное появление и сдвиг одного слоя
UPDATE layers SET opacity = 100, y = 450 WHERE id = 'card' AT 0.5 WITH (duration = 0.7, ease = 'out');

-- Перемещение и смена цвета
UPDATE layers SET x = 550, color = '#22c55e' WHERE id = 'dot' AT 1.2 WITH (duration = 1.0, ease = 'inOut');

-- Массовое скрытие группы слоёв через IN (...)
UPDATE layers SET opacity = 0 WHERE id IN ('card', 'dot', 'title') AT 8.5 WITH (duration = 0.8, ease = 'in');
```

**Модификаторы блока `WITH (...)`:**
* `duration` *(или `dur`)* — длительность анимации в секундах. Если не указана (`0`), изменение происходит мгновенно.
* `ease` — функция плавности: `'linear'`, `'in'`, `'out'`, `'inOut'` (по умолчанию `'inOut'`).

### 4. Управление камерой (`UPDATE camera`)
Позволяет перемещать объектив по большому виртуальному полотну и менять приближение (`zoom`):

```sql
-- Начальная позиция камеры
UPDATE camera SET x = 400, y = 480, zoom = 1.5 AT 0.0;

-- Плавный отъезд камеры на общий план
UPDATE camera SET x = 400, y = 480, zoom = 1.0 AT 2.0 WITH (duration = 1.2, ease = 'inOut');

-- Мгновенный монтажный кат (без WITH / duration = 0) в другую часть мира
UPDATE camera SET x = 1600, y = 480, zoom = 1.2 AT 5.0;
```

---

## 🧩 Пример полного сценария (`hello.lsl`)

```sql
UPDATE composition SET width = 540, height = 960, fps = 60, duration = 6.0;
UPDATE camera SET x = 270, y = 480, zoom = 1.2 AT 0.0;

INSERT INTO layers (id, type, x, y, width, height, color, radius, opacity) VALUES
  ('bg',   'rect', 270, 480, 1200, 1600, '#090d16', 0,  100),
  ('card', 'rect', 270, 510, 400,  220,  '#1e293b', 28, 0);

INSERT INTO layers (id, type, text, x, y, size, color, opacity) VALUES
  ('msg',  'text', 'Привет из LSL!', 270, 515, 34, '#38bdf8', 0);

UPDATE camera SET x = 270, y = 480, zoom = 1.0 AT 0.4 WITH (duration = 1.0, ease = 'out');
UPDATE layers SET opacity = 100, y = 480 WHERE id IN ('card', 'msg') AT 0.4 WITH (duration = 0.7, ease = 'out');
UPDATE layers SET rotation = -3, scale = 105 WHERE id = 'card' AT 2.0 WITH (duration = 0.5, ease = 'inOut');
UPDATE layers SET rotation = 0,  scale = 100 WHERE id = 'card' AT 2.6 WITH (duration = 0.5, ease = 'inOut');
UPDATE layers SET opacity = 0 WHERE id IN ('card', 'msg') AT 5.0 WITH (duration = 0.8, ease = 'in');
```

---

## 🛠 Как это устроено внутри

1. **Парсер SQL-DSL:** Разбирает инструкции `INSERT` и `UPDATE`, извлекает временны́е метки `AT`, условия `WHERE` и параметры кривых `WITH`.
2. **Компилятор в Lottie JSON:** Преобразует временны́е отрезки в кадры (`frame = Math.round(t * fps)`), вычисляет касательные Безье (`i`/`o`), конвертирует HEX-цвета в нормализованный RGBA `[0..1]` и создаёт родительский Null-слой `CAMERA_RIG` (`ty: 3`), к которому привязываются все объекты сцены.
3. **Рендер и экспорт:** В реальном времени анимация проигрывается через `lottie-web` (SVG), а при экспорте видео покадрово растеризуется на `<canvas>` и записывается средствами браузерного `MediaRecorder`.

---

## 📄 Лицензия

MIT License — свободно используйте, модифицируйте и создавайте свои анимации.
