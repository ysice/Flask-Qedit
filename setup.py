#!/usr/bin/env python3

import sys
import os
import re
from io import open
from setuptools import setup, find_packages, Command


if sys.version_info < (2, 7) or (3, 0) <= sys.version_info < (3, 5):
    print('Glances requires at least Python 2.7 or 3.5 to run.')
    sys.exit(1)

with open(os.path.join('flask_init', '__init__.py'), encoding='utf-8') as f:
    version = re.search(r"^__version__ = ['\"]([^'\"]*)['\"]", f.read(), re.M).group(1)

if not version:
    raise RuntimeError('Cannot find flask-init version information.')

with open('README.md', encoding='utf-8') as f:
    long_description = f.read()


def get_data_files():
    data_files = [
        ('share/doc/flask_init', ['README.md'])
    ]
    return data_files


def get_install_requires():
    requires = ['flask>=0.12.2', 'click>=6.7']
    # if sys.platform.startswith('win'):
    #    requires.append('bottle')
    return requires


class tests(Command):

    user_options = []

    def initialize_option(self):
        pass

    def run(self):
        import pytest
        errno = pytest.main(self.test_args)
        sys.exit(errno)


setup(
    name='Flask-init',
    version=version,
    description="Quickly initialize the flask application Edit",
    long_description=long_description,
    author='ysicing',
    author_email='ops.ysicing@gmail.com',
    url='https://github.com/ysicing/Flask-init',
    license='GPLv3',
    keywords='flask',
    install_requires=get_install_requires(),
    packages=find_packages(),
    include_package_data=True,
    data_files=get_data_files(exclude=['tests']),
    entry_points={"console_scripts": [
        'finit = flask_init:main'
        ]
    },
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console :: Curses',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: General Public License v3 (GPLv3)',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6'
    ],
    platforms='any'
)