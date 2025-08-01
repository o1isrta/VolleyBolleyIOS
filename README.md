# VolleyBolleyIOS

[Дизайн](https://www.figma.com/design/kUzSCCWxdcfhQY4W1afEw1/Volleybolley?node-id=1-30113&p=f&t=S6NJ24EMynBq0IND-0)

# Стек

- Moya;
- Kingfisher;
- Swinject DI;
- SwiftLint;
- Swift Package Manager (SPM);
- Архитектура приложения: VIPER;
- Минимальная версия операционной системы: iOS 16.

# Merge requests & commits

Есть две ветки:

- main
- develop

> [!IMPORTANT]
> Основная работа ведется с веткой develop. От нее отводим свои ветки feature/bugfix, в нее же и вливаем.

Пример создания ветки фичи: <br>
feature/фамилия/VB-1-что-сделал-кратко

Пример создания ветки фикса бага: <br>
bugfix/фамилия/VB-1-что-сделал-кратко

> [!NOTE]
> Номер (VB-*номер*) привязывается к номеру issue.

## Коммиты пишутся на русском языке.

Пример: <br>
[VB-1] - Поправил баг/ Добавил фичу, которая делает что-то

> [!IMPORTANT]
> Перед влитием в ветку develop, необходимо подтянуть её в свою ветку, чтобы проверить наличие конфликтов перед слиянием.


# CodeStyle

## Перенос параметров

> [!NOTE]
> Функция, имеющая больше двух параметров переносится на новую строку

Пример функции с двумя параметрами : <br>
```
func set(str: String, str: String) -> Int
```

Пример функции с тремя и более параметрами : <br>
```
func set(
    str: String,
    str: String,
    str: String
) -> Int
```

## Перенос скобок

Пример: <br>
```
let model = Model(
set1,
set2
)
```

## Нейминг функций / свойств

- func setup*Название*() - Настройка, что вызовется единожды

- func configure*Название*() - Переиспользование

- func get*Название*() / func fetch*Название* - Получение запроса

- func handle*Название*() - Обработка

- func map*Название*() - Маппинг из одного в другое

- func is*Название*() -> Bool - Функция, возвращающая bool

## Отступы

> [!NOTE]
> В классах и расширениях используется дополнительная пустая строка.
> В структурах, функциях и протоколах отступ не нужен.

Пример использования класса: <br>
```
class A {

func set() {}
}
```

Пример использования расширения: <br>
```
extension A {

func set() {}
}
```

Пример использования структуры: <br>
```
struct A {
func set() {}
}
```

> [!NOTE]
> Все константы выносятся в отдельный enum.

Пример использования перечисления: <br>
```
class A {

enum Constants {
    static let num = 1
}
}
```

## Разделение по MARK

- Constants;
- Public Properties;
- Internal Properties;
- Private Properties;
- Initializers;
- Public Methods;
- Internal Methods;
- Private Methods.

Пример: <br>
```
class A {
// MARK: - Constants
// MARK: - Initializers
}
```

## Комментарии

Комментарии пишем по возможности на свойства / функции, но если логика названия свойста или функции простая и понятная, то комментарий можно не писать.

Пример: <br>
```
/// Проверка на валидацию
var isValid: Bool
```

## Дополнительные сведения

Использование self без необходимости стараемся избегать.

По возможности используем SOLID, DRY, KISS и YAGNI.
