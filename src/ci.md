% Containers for continuous integration <br>(in science)
% Frederick &#8220;Erick" Matsen
% [http://matsen.fredhutch.org/](http://matsen.fredhutch.org/) <br> [\@ematsen](https://twitter.com/ematsen)


<section data-background="figures/octocat.svg"> </section>

## Welcome to <br> the future
<ul style="list-style-type: none;">
<li> <span style="color:green">✔</span> Code under version control
<li class="fragment"> <span style="color:green">✔</span> Example inputs included in repository
<li class="fragment"> <span style="color:red">✗</span> Code compiles
<li class="fragment"> <span style="color:red">✗</span> Code runs on example inputs
<li class="fragment"> <span style="color:red">✗</span> Code does the right thing on example inputs
</ul>


## What do the <br> pros do?
Check out [pull requests for Rails](https://github.com/rails/rails/pulls)<br>and click on the little <span style="color:green">✔</span>s and <span style="color:red">✗</span>s.

&nbsp;

<div class="fragment">
Uh oh, one of
[my builds is failing](https://travis-ci.org/matsen/p-neq-np/builds/87144991).
</div>

<div class="fragment">
No `cowsay`????
</div>


## &nbsp;
<section data-background="figures/hopeless.jpg"> </section>


##
<section data-background="figures/docker.svg"> </section>

##
<img src="https://www.docker.com/sites/default/files/what-is-docker-diagram.png" height=600 />

##
<img src="https://www.docker.com/sites/default/files/what-is-vm-diagram.png" />

## Scientific workflows are complex

&nbsp;

Docker enables us to bring together lots of working parts, unusual languages, and heavy dependencies.

##
Dockerfile ([docs](https://docs.docker.com/engine/reference/builder/)):

    from ubuntu:trusty

    RUN apt-get update -q && \
        apt-get install -y -q --no-install-recommends \
            cowsay \
            make

    RUN ln -s /usr/games/cowsay /usr/bin

<div class="fragment">
On command line:

    git clone https://github.com/matsen/cowsay-build-env.git
    cd cowsay-build-env/
    docker build -t <USERNAME>/cowsay-build-env .
    docker run -it <USERNAME>/cowsay-build-env /bin/bash
    cowsay
</div>


## Exercise
* add `nyancat` to your Dockerfile
* build
* run it from within your container


## [Docker hub](https://hub.docker.com/)
Either push directly:

    docker push <USERNAME>/cowsay-build-env

&nbsp;

Or set up an [automated build](https://docs.docker.com/docker-hub/builds/) as I have for this project:

<https://hub.docker.com/r/matsen/cowsay-build-env/>


## We could stop here!
In fact, I wrote [a little shim](https://github.com/matsengrp/relay) that would post to our Slack channel with the results of an automated build.

But, there are tools that make the process smoother and more logical, such as [Wercker](http://wercker.com).


##
<section data-background="http://blog.wercker.com/images/posts/2015-08-13-Introducing-our-newest-teammember/walter_bay.png"> </section>


## wercker.yml
Specify the Docker image used for the build:

    box: matsen/cowsay-build-env

Specify what the build should do:

    build:
        steps:
            - script:
                name: build
                code: make

When pushed to Wercker, you get a build page like [this](https://app.wercker.com/#applications/562ac0e50ee6b2c40f0936b4).


## More [fun](https://github.com/matsen/pplacer/blob/master/wercker.yml)
Notify:

    build:
        after-steps:
            - slack-notifier:
                url: $SLACK_URL
                channel: microbiome
                username: pplacer build

Upload docs to Github pages:

    deploy:
        steps:
            - ematsen/gh-pages:
                token: $GITHUB_TOKEN
                repo: matsen/pplacer
                path: docs/_build/html



## [YAML](http://yaml.org/) is great*

&nbsp;

&nbsp;

&nbsp;

\* and a little fussy to debug.
Use [yamllint.com](http://www.yamllint.com/).

## Related things

* [Rabix](https://www.rabix.org/): portable workflows via Docker
* [Bioboxes](http://bioboxes.org/): modularize bioinformatics tools via Docker
* [Shippable](https://app.shippable.com/): another CI solution with Docker

## Thank you!
