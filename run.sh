#!/bin/bash

if [ "$1" = "release" ];then
    [ ! -z "$version"  ] && (
        sed -i "s#0.0.0#$version#g" /build/pypi/flask_qedit/__init__.py
    )
    pip install twine
    python setup.py sdist
    twine upload dist/*
else
    exec /bin/bash
fi