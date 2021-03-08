# Boozter
## Search for cocktails and their recipes through the open [TheCocktailDB](https://www.thecocktaildb.com) API

[![Build Status](https://travis-ci.com/bukshev/Boozter.svg?branch=master)](https://travis-ci.com/bukshev/Boozter)
![N|Solid](https://img.shields.io/tokei/lines/github/bukshev/boozter)

Boozter — приложение для поиска коктейлей и их рецептов через открытый API ([TheCocktailDB](https://www.thecocktaildb.com)).

> Я пью, чтобы окружающие меня люди становились интереснее. (Джордж Жан Натан)

## Features

- Просмотр коктейлей в виде списка.
- Просмотр деталей по каждому из коктейлей: 
  - какой бокал необходим;
  - к какой категории принадлежит коктейль;
  - состав коктейля;
  - способ приготовления.
- Поиск коктейлей по доступным ингредиентам.
- Просмотр информации и истории о доступных ингредиентах.
- Добавление понравившихся коктейлей в "избранные" с функцией локального сохранения.

## Screens

В приложении 3 основных экрана:

| Module name | Short Brief |
| ------ | ------ |
| **HomeDashboard** | Список коктейлей. UICollectionView + separated DataSource |
| **Coctail** | Детальное представление коктейля. Storyboard + AutoLayout |
| **Ingredients** | Список доступных ингредиентов. UITableView + UIContextualAction |


## Dependencies

В приложении две сторонних библиотеки. Остальной код написан с использованием нативных средств.

| Dependency | Source Code | For what? |
| ------ | ------ | ------ |
| **Typhoon** | https://github.com/appsquickly/typhoon | DI-контейнер для всего приложения. Assembly-layer построен именно на нём. |
| **VIPER McFlurry** | https://github.com/rambler-digital-solutions/ViperMcFlurry | Передача данных с модуля на модуль и обратно в VIPER'е — интересная задача. Чтобы не создавать собственные костыли, была заиспользована библиотека от Rambler с moduleInput и moduleOutput. |

## Tech Brief

Код приложения отлично отражает подход **Hype Driven Development** середины 2014 года, когда многие проекты бездумно переписывались с использованием архитектурного подхода [VIPER](https://www.objc.io/issues/13-architecture/viper/) (View Interactor Presenter Entity Router). Концепция: простая идея — сложная реализация.

## Interestingness

| Feature | Short Description |
| ------ | ------ |
| **Clean architecture** | Код, хоть и написан дабы усложнить жизнь разработчикам, но всё же +/- (два программиста — три мнения) соответствует общепринятым понятиям о "чистой архитектуре" со всеми сопутствующими SOLID, KISS, DRY, YAGNI, etc. |
| **NSOperationQueue with priorities** | Сетевой слой построен на NSOperationQueue и кастомных NSOperation для каждой из задач. Для оптимизации скорости работы/отклика приложения были реализованы приоритеты — так, для ячеек которые уже находятся на экране, приоритет загрузки выше, нежели для ячеек, которые должны вот-вот появиться (к примеру, через prefetching). |
| **Image caching** | Для загруженных изображений коктейлей (в рамках одной сессии) imageData помещается в NSCache, чтобы оптимизировать потребление сетевого трафика и скорость работы приложения. |
| **Separated data-sources** | Для того, чтобы разгрузить "любимый" Presenter-layer, методы DataSource для UITableView и UICollectionView были вынесены в отдельные классы. |
| **UICollectionViewDataSourcePrefetching** | Для основного UICollectionView реализованы методы протокола для prefetching'а данных. |
| **Asynchronous work** | По проекту, код, который можно вынести в фоновые потоки, был вынесен через GCD. |
| **CoreData with background contexts** | Сохранение, получение и изменение данных (с merge'м контекстов) происходит в background'е. |
| **Some animations** | Слегка анимированы ячейки в UICollectionView и показ контейнера с выбором "все/избранные коктейли". |

## License

MIT License
-----------

Copyright (c) 2019-2021 Ivan Bukshev
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
