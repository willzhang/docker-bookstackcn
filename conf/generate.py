#!/usr/bin/env python3
import os
import sys
from jinja2 import Environment, FileSystemLoader

template_file = sys.argv[1]
config_file = sys.argv[2]
config_path = '/bookstack/conf/'


def generate_conf():
    config = config_path + config_file
    if not os.path.exists(config):
        env = Environment(loader=FileSystemLoader(searchpath='/tmp/conf/'))
        int_template = env.get_template(template_file)
        cnfs = {
            'db_host': os.environ.get('DB_HOST', 'db'),
            'db_port': os.environ.get('DB_PORT', '3306'),
            'db_username': os.environ.get('DB_USERNAME', 'bookstack'),
            'db_password': os.environ.get('DB_PASSWORD', 'bookstack123'),
            'db_database': os.environ.get('DB_DATABASE', 'bookstack'),
            'runmode': os.environ.get('RUN_MODE', 'prod')
        }
        int_template.globals = cnfs
        with open(config, 'w+') as fout:
            render_content = int_template.render()
            fout.write(render_content)


if __name__ == "__main__":
    generate_conf()
