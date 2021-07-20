
# ComicSplash

### Author
Marco Boerner

### Description

### Notes
The apps shows the latest comic first. When going to the next page what is shows is actually the previous comic. Throughout the code this is also handled like that.

The app tries to implement the following data flow:

View
runs
WorkflowAction
OR
ReducerActions (if no side effects and only a state update is required.)

WorkflowAction
triggers
Workflow

Workflow
uses Models, Protocols etc. with side effects, Async tasks etc.
finished Workflow
optionally runs
ReducerAction

ReducerAction
triggers
Reducer

Reducer
changes State using pure functions.

State
is an ObservableObject
and publishes its changes

View
listens and reacts to state changes.


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
https://xkcd.com (License: https://creativecommons.org/licenses/by-nc/2.5/)


### Credits
Modified scale effect taken from the SDWebImageSwiftUI Example 

Image Download:
https://stackoverflow.com/a/50082267/12764795

https://stackoverflow.com/a/46852224/12764795
(License: https://creativecommons.org/licenses/by-sa/4.0/ Changes: Yes)


Image used in Logo 'Abstract vector' by macrovector
https://www.freepik.com/vectors/abstract


https://medium.com/@WilliamJones/text-to-speech-in-swift-in-5-lines-e6f6c6139086

https://bendodson.com/weblog/2014/10/02/showing-todo-as-warning-in-swift-xcode-project/

### Discussions
https://stackoverflow.com/q/68422128/12764795
https://stackoverflow.com/a/68428787/12764795

