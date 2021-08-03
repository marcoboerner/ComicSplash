
# ComicSplash

### Author
Marco Boerner

### Description
Still under development. An app that fetches comics from an api with simple drag and pinch gestures. A favorited manager and persinstant storage implemented with a local Realm.

The app follows a similar concept of unidirectional dataflow as does Redux/ReSwift. However there is no store, and there are two different kind of actions that either trigger a Workflow (Similar to Middleware with sideeffects) or a Reducer, which changes the state with pure functions.

The store is an Observabale Object. The view is all SwiftUI and reacts to changes in the Observable Object. The Workflows and Reducers are their own Observable Objects. Store, Workflows, and Reducers are made available to the views as Environment Objects.

This setup is my attempt to find an alternative to the Redux implementation as I always had issues debugging larger Redux apps as it was not always clear which middleware is triggered when and which action is intercepted by what middleware. The way my app works is, there is either a Workflow that has sideeffects and might trigger its own Reducer Action. Or there are Reducers which will directly change the state without any sideeffects.

It's still possible to intercept each of thsoe actions for debugging purposes.

Feedback and suggestions re more than welcome!

### Notes
The apps shows the latest comic first. When going to the next page what is shows is actually the previous comic. Throughout the code this is also handled like that.

### Modules & Dependencies
Database for favorites:
Realm
RealmDatabase

Image retrieval:
SDWebImage
SDWebImageSwiftUI

Debugging Actions:
EnumKit

Code formatting:
SwiftLint via Homebrew

### API
https://xkcd.com
(License: https://creativecommons.org/licenses/by-nc/2.5/)

### Credits
Modified scale effect taken from the SDWebImageSwiftUI Example 

Image Download:
https://stackoverflow.com/a/50082267/12764795
(License: https://creativecommons.org/licenses/by-sa/3.0/ Changes: Yes)

https://stackoverflow.com/a/46852224/12764795
(License: https://creativecommons.org/licenses/by-sa/4.0/ Changes: Yes)

Image used in Logo 'Abstract vector' by macrovector:
https://www.freepik.com/vectors/abstract

Launch screen workaround:
https://danielbernal.co/stretched-launch-screen-images-in-swiftui-the-fix/

Text to speech:
https://medium.com/@WilliamJones/text-to-speech-in-swift-in-5-lines-e6f6c6139086

ToDo's as warnings:
https://bendodson.com/weblog/2014/10/02/showing-todo-as-warning-in-swift-xcode-project/

Combining Combine publishers:
https://swiftwithmajid.com/2021/05/12/combining-multiple-combine-publishers-in-swift/

### Discussions
https://stackoverflow.com/q/68422128/12764795
https://stackoverflow.com/a/68428787/12764795


### Screenshots

#### Main screen
![IMG_3356](https://user-images.githubusercontent.com/55633868/126513571-b41081d4-a6ed-423a-a502-c4fdb7d8782e.PNG)

#### Favorites
![IMG_3357](https://user-images.githubusercontent.com/55633868/126513575-90cf7226-4651-4c3a-a86c-9b3ed4be5caa.PNG)

#### Loading screen (animates)
![IMG_3359](https://user-images.githubusercontent.com/55633868/126513562-bafc9efd-2468-4a59-801a-a31585a9090d.PNG)

#### Pinch and drag gestures
![IMG_3358](https://user-images.githubusercontent.com/55633868/126513566-9d25003d-7d21-46a3-ae03-7c93aa657fc3.PNG)
