# MappyMapAdyen

This project is a sample coding challenge app for Adyen to show some venues around user location and the user have the ability to change the region and search the venues around this specific region.

Now we will show a quick guide about the main classes in the project, the structure of the targets, as well as the pattern used.

## Installation
Clone or download the project 


## App Archicture:

The app uses a MVVM pattern with Combine and  Coordinator, but not being 100% faithful because it was built with Layered Architecture in mind.
The components are the followings:

##### - ViewController - ( HomeViewController)
    
  It'll act as the "View" component of the MVVM module. It'll only draw what the view model tells him. It doesn't know anything about requests, models, data or some kind of business/model tasks.
  What concerns a view in this pattern is to draw, animate, take care of the view lifecycle and show the user the data in a pretty manner.
  
  layout is done programmatically
  

##### - ViewModel - ( HomeViewModel)

HomeViewModel some business logic and the middleWare between HomeViewController and the model


##### - WorkerRepo - ( placesWorkerRepo)

Data ( models ) fetcher for the places to seprate the concerns, and to be reusable and not tighted to the viewModel 

#### - Networking  
  The app uses URLSession with Combine
  
## UX

User can choose specific region on the map and then press search to show the venues around this region of the map


## FAQ
  
#### - Why there are just a few tests?
 in the future if it's needed, I'll add some new tests to all targets!

