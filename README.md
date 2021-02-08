# Boozter

1. В приложении 2 экрана, но весь код нацелен на то, чтобы сделать жизнь разработчику сложнее и больнее.
2. Всё в лучших традициях начала хайпа с архитектурой VIPER (+ mobile SOA) подхода. 
3. Для Assembly-уровня в качестве DI-контейнера выбрал Typhoon, для передачи данных с модуля на модуль — ViperMcFlurry. 
4. Больше сторонних зависимостей в проекте нет.
5. Сетевое взаимодействие реализовано через NSOperationQueue с приоритетами. 
6. Загрузка картинок происходит асинхронно, присутствует prefetch для collectionView.
7. Слой с работой кеширования в CoreData пока не доработан (всё отрабатывает на viewContext 🥴).

Приложение готово на 40%, но посмотреть и покрасоваться кодом на Objective-C уже можно сполна.
