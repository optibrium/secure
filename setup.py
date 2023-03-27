from setuptools import setup
from com.optibrium.buildcontainer import get_version_from_git_tag

setup(
    name='secureclip',
    version=get_version_from_git_tag(),

    author='Graham, DevOps, Optibrium',
    author_email='graham@optibrium.com',
    classifiers=[
        'Development Status :: 4 - Beta',
        'Environment :: Web Environment',
        'Framework :: Flask',
        'Intended Audience :: Developers',
        'Intended Audience :: Internal Pasters',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Natural Language :: English',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Topic :: Internet :: WWW/HTTP :: WSGI :: Application',
        'Topic :: Business Development :: Secrets Sharing'
    ],
    description='An secure clipboard for sharing secrets',
    install_requires=[
        'Flask==1.1.1',
        'flask_limiter==1.1.0',
        'redis==4.5.3'
    ],
    keywords='secure clip clipboard',
    long_description='''
    ''',
    long_description_content_type='text/markdown',
    packages=[
        'com.optibrium.secureclip'
    ],
    package_data={
        '': ['templates/*', 'static/*', 'static/vendor/*']
    },
    python_requires='>=3.4, <4',
    project_urls={
        'Our Company': 'https://optibrium.com',
        'The Clipboard': 'https://clip.infra.optibrium.com',
        'Bug Reports': 'https://github.com/optibrium/secureclip/issues',
        'Source': 'https://github.com/optibrium/secureclip'
    },
    url='https://github.com/optibrium/secureclip'
)
