# Django-pet inspired by https://www.w3schools.com/django/index.php
#
To run locally:
1) Upload code into your machine:
   https://github.com/wannabelll/Django-pet.git
2) You must install python and PIP on your system:
   python --version
   pip --version
3) Create a virtual environment for project:
   Windows:
     python -m venv myworld
   Unix/MacOS:
     python -m venv myworld
This will set up a virtual environment, and create a folder named "myworld" with subfolders and files, like this:
myworld
  Include
  Lib
  Scripts
  pyvenv.cfg
4) Then you have to activate the environment, by typing this command:
  Windows:
    myworld\Scripts\activate.bat 
  Unix/MacOS:
    source myworld/bin/activate
5) Install dependencies from "requirements.txt" file:
    pip install -r .\my_team\requirements.txt 
6) To run project:
   python .\my_team\manage.py runserver

You will get something like:
  Performing system checks...

System check identified no issues (0 silenced).
January xx, xxxx - xx:xx:xx
Django version x.x.x, using settings 'my_team.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.

![image](https://github.com/user-attachments/assets/3af4165b-d7ca-441c-a613-1889cc766578)


