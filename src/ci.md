% Continuous integration
% Frederick &#8220;Erick" Matsen
% [http://matsen.fredhutch.org/](http://matsen.fredhutch.org/) <br> [\@ematsen](https://twitter.com/ematsen)

<!-- I'm a computational biology PI at the Fred Hutch.

http://travis-ci.org/rails/rails/
http://doc.sagemath.org/html/en/reference/calculus/sage/symbolic/expression.html
https://docs.docker.com/reference/builder/
http://yaml.org/
http://yamllint.com/
-->


<section data-background="figures/octocat.svg"> </section>

## Welcome to the future
<ul style="list-style-type: none;">
<li> <span style="color:green">✔</span> Code under version control
<li class="fragment"> <span style="color:green">✔</span> Example inputs included in repository
<li class="fragment"> <span style="color:red">✗</span> Code compiles
<li class="fragment"> <span style="color:red">✗</span> Code runs on example inputs
<li class="fragment"> <span style="color:red">✗</span> Code does the right thing on example inputs
</ul>


## What about the pros?
Check out [pull requests for Rails](https://github.com/rails/rails/pulls)<br>and click on the little <span style="color:green">✔</span>s and <span style="color:red">✗</span>s

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
![](https://www.docker.com/sites/default/files/what-is-docker-diagram.png)

##
![](https://www.docker.com/sites/default/files/what-is-vm-diagram.png)


##
Dockerfile:

    from ubuntu:trusty
    RUN apt-get update -q && \
        apt-get install -y -q --no-install-recommends \
            cowsay \
            make
    RUN ln -s /usr/games/cowsay /usr/bin

On command line:

    git clone https://github.com/matsen/cowsay-build-env.git
    cd cowsay-build-env/
    docker build -t <USERNAME>/cowsay-build-env .
    docker run -it <USERNAME>/cowsay-build-env /bin/bash
    cowsay


## [Docker hub](https://hub.docker.com/)
Either push directly:

    docker push <USERNAME>/cowsay-build-env

&nbsp;

Or set up an [automated build](https://docs.docker.com/docker-hub/builds/) as I have for this project:

https://hub.docker.com/r/matsen/cowsay-build-env/


## One could stop here!
In fact, I wrote [a little shim](https://github.com/matsengrp/relay) that would post to our Slack channel with the results of an automated build.

But, there are tools that make the process smoother and more logical, such as [Wercker](http://wercker.com).


##
<section data-background="http://blog.wercker.com/images/posts/2015-08-13-Introducing-our-newest-teammember/walter_bay.png"> </section>


## wercker.yml
Here's the Docker image used for the build:

    box: matsen/cowsay-build-env

Here's what the build should do:

    build:
        steps:
            - script:
                name: build
                code: make

When pushed to Wercker, you get a build page like [this](https://app.wercker.com/#applications/562ac0e50ee6b2c40f0936b4).


## More fun (from [pplacer](https://github.com/matsen/pplacer/blob/master/wercker.yml))
    build:
        after-steps:
            - slack-notifier:
                url: $SLACK_URL
                channel: microbiome
                username: pplacer build

    deploy:
        steps:
            - ematsen/gh-pages:
                token: $GITHUB_TOKEN
                repo: matsen/pplacer
                path: docs/_build/html


## Thank you!
