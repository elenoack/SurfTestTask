# SurfTestTask
Тестовое задание в мобильную студию Surf
# Техническое задание на стажировку

Получи возможность проявить навыки iOS-разработки в крутой компании и стать частью большой опытной команды. Выполни тестовое задание, мы его оценим и решим, готов ли ты проходить стажировку в команде iOS-разработки Surf. 

## Что нужно сделать?

Необходимо сверстать экран, чтобы он полностью повторял [дизайн](https://www.figma.com/file/S4ucVLUHYc0vLg2p1Xnart/IOS-%D1%81%D1%82%D0%B0%D0%B6%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B0?node-id=45%3A77&t=N4eUtEGJu7LxSAnC-1). 

Помимо верстки на UIKit, нет никаких ограничений в выборе способов реализации данной задачи. Будет это MVP или VIPER? UITableView или ScrollView? Решать тебе! 

Данные для отображения зашиваем в приложении, запросы в сеть не используем.

Задание представлено в двух версиях, в базовой и продвинутой. В базовой описаны общие требования к экрану. В продвинутой предложены варианты для улучшения, которые расположены в порядке увеличения сложности. Некоторые варианты исключают друг друга, так что не нужно делать их все (но чем больше сделаешь сложных вариантов, тем выше шансы на успех).

### Базовая версия:

- Картинка должна быть пропорциональных размеров согласно первому макету;
- Экран статичный, без возможности скролла;
- В карусели максимум 10 элементов, карусель можно проскролить вправо. Ширина элемента карусели должна зависеть от текста;
- По нажатию на кнопку «Отправить заявку» отображать системный алерт об успехе с заголовком «Поздравляем!» и текстом «Ваша заявка успешно отправлена!» и кнопкой «Закрыть».

### Продвинутая версия:

- У всех кнопок присутствует состояние нажатия (*press state*). Изменение цвета делаем на свое усмотрение;
- Экран имеет возможность скролла, картинка уезжает вместе с контентом;
- Элементы «Отправить заявку» и «Хочешь к нам?» должны быть прибиты к низу экрана и не должны скроллиться;
- По нажатию на элемент в карусели его состояние меняется на выбранное, по повторному нажатию возвращается в обычное состояние;
- По нажатию на элемент в карусели он анимировано переходит на первую позицию;
- Зацикленная и бесконечная карусель, то есть ее можно скроллить в любую сторону и сколько угодно, при этом количество элементов должно остаться равным 10, за десятым элементом следует первый;
- Дополнительная карусель, элементы которой располагаются в два ряда и подстраиваются в зависимости от ширины ячеек. Если элементы не помещаются на экран в два ряда, они не должны отображаться;
- Скроллить можно только контент, картинка при этом статична. Контент может скроллится вплоть до статус бара;
- В дополнительной карусели добавить возможность скроллить контент, если на экран не поместились все элементы, которые в нее добавлены. Количество рядов должно остаться так же равным двум. Скроллится должны сразу оба ряда, а не по отдельности.


## Technology stack
> - UIKit
> - MVP
> - Building UI programmatically 
> - Using collection view with compositional layout

|      Screen     | 
|:---------------:|
|![Simulator Screen Recording - iPhone 14 Pro - 2023-02-11 at 16 28 28](https://user-images.githubusercontent.com/96373604/218261045-5fe99972-87d9-49d5-b59e-7190c007eb64.gif)|
