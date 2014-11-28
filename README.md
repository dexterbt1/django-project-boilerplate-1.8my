# django-project-boilerplate

### Usage

You might want to just download the tarball / zipfile and extract to your project repo, since you are probably just interested in the 
structure this project provides.

    cd path/to/project-parent
    wget -c https://github.com/dexterbt1/django-project-boilerplate/archive/master.zip
    unzip master.zip 

    # rename to the project name
    mv django-project-boilerplate my-project

    # initialize deps
    cd my-project
    virtualenv py
    source py/bin/activate
    pip install -r requirements.pip
    

### Motivation

I started this repository since I'm tired of manually editing settings.py files, capturing lessons-learned 
from previous projects then porting them over to a new project. My goal is to enable rapid development by providing
a very basic generic project structure for starting Django Projects.

### TODO

- Supervisord.conf
- Dockerfile
- Vagrantfile

