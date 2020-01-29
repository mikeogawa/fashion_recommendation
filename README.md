# Intro
This is a simple project for apparel recommendation system



# How to use

These instructions are for macOS users.
Docker or Django is required.

**Summary:**   
1. Run Django App first. Do not close until you want to stop using this app. Read below for further description.
2. Run Flutter. Read below for further description.



## Running Django

### Method 1. Local Image Build and Container Installation
Type in the following command in a terminal:
```
cd 'current/directory'
docker build -t appa:2.0 .
docker container run -it -p 8000:8000 --name appa2 appa:2.0
```
**Note:** Building will take time.   


### Method 2. Remote Image Pull Installation 
Type in the following command in a terminal:
```
docker pull mikeogawa/appa2:2.0
docker container run -it -p 8000:8000 --name appa2 appa:2.0
```

### Method 3. Local installation
Type in the following command in a terminal:
```
cd 'current/directory'
cd src
python manage.py runserver
```
### To Stop Container
To stop container, press `control` + `c`, then run the following command:
```
docker container stop appa2
docker container rm appa2
```



## Running Flutter

1. Install Adroid Studio and Flutter: https://flutter.dev/docs/get-started/install/macos   
2. Open `apparael/` using Android Studio.
3. Run app using a simluator from Android Studio.(Details are in the Andriod Setup section in the URL above)   
4. Once loaded, click the Run Button (Green Play Mark) located on the top right of the application screen.
5. The terminal will pop up. Wait until the console is clear. 
6. If you want to see the result of different recommendations with different user parameters, change the user parameter at `lib > main.dart` line 36, and then hot restart, which is located at the terminal section(at the top of the terminal area).



Set up the Android emulator.   
For details, go to https://developer.android.com/studio for details.   





# Requirements
## For App run
- flutter
- django
- numpy
- ReNom (http://www.renom.jp/packages/renomdl/index.html)
- Docker

## For Jupyter NB
- jupyter
- ReNomRL (http://www.renom.jp/packages/renomrl/index.html)
