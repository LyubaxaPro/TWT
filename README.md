# TWT

Проект по технологии командной разработки. Приложение для поиска событий в некоторых городах России. Работает на платформе iOS, версия iOS 13+. Данные о событиях берутся из API KudaGo https://docs.kudago.com/api/.

# Использование шаблона VIPER.xctemplate

Для использования шаблона необходимо:

1. Скачать шаблон

2. Скопировать его в директорию /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates

Для создания VIPER модуля:

* В верхнем меню выбрать File -> New -> file

* Шаблон для VIPER модуля должен появиться в шаблонах к файлу, выбрать его -> Next

<img width="729" alt="image" src="https://user-images.githubusercontent.com/30967616/159124376-7984cd7f-eca4-4a43-a29d-4cac2ca6cf72.png">

* Написать название VIPER модуля исходя из логики экрана для которого этот модуль создается -> Next

<img width="729" alt="image" src="https://user-images.githubusercontent.com/30967616/159124456-db7594ae-7a89-4480-9861-04b7296dee3c.png">

* Выбрать папку проекта для создания файла

* Файлы которые принадлежат к одному VIPER модулю называются как название модуля + сущность

<img width="256" alt="image" src="https://user-images.githubusercontent.com/30967616/159124557-91d1e520-eeaa-4b57-9992-689fdb997463.png">

* Создать директорию с названием идентичным названию VIPER модуля, разместить все файлы, относящиеся к одному модулю в этой директории. 
