#!/usr/bin/env python3
# coding=utf-8

"""
@version:0.1
@author: ysicing
@file: /finit.py
@time: 18-1-23 上午12:19
"""

import click

@click.group()
def  cli():
    """A simple cmd line tool"""

@cli.command('new')
def new():
    click.echo('new project')


def main():



if __name__ == '__main__':
    main()

