## Overview/Checklist

Since this workflow documentation is quite exhaustive we start off with a short
summary in checklist format. This should give you a quick overview if you are
new to Autostrap and serve as a handy reminder of the steps involved in
configuring and deploying an Autostrap based setup.

1. Create a project-config repository accessible from the Internet using a deploy key.

2. Create a heat template with one or more servers In this heat template...

     1. ...assign [topics](/glossary/#topic) to your servers (`puppet-masterless`
        at the very least).

     2. ...create an [AS::autostrap][heat::autostrap] resource and pass it to
        your servers as user data. This should at the very have your
        [project-config](/config/#project) repository's URL in its `config_repo`
        parameter and a deploy key able to access it in its `deploy_key`
        parameter.

3. Configure Hiera using general (`config.d` and `repos.d`) and node/nodetype
   specific configuration in your project-config repository.

4. Instantiate your heat template,

5. Repeat previous steps as needed until your setup builds flawlessly.
