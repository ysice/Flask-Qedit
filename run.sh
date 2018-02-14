#!/bin/bash

if [ "$1" = "release" ];then
    pip install twine
    python setup.py sdist
    twine upload dist/*
else
    exec /bin/bash
fi