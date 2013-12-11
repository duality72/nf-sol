nf-sol
======

Environment Setup
-----------------

Using vagrant and a minimal CentOS 6.3 box, I ran the following commands to setup the environment.

    sudo yum -y install git perl-CPAN
    curl -L http://cpanmin.us | perl - --sudo App::cpanminus
    sudo cpanm Test::More Test::Exception Moose Time::ParseDate Date::Format

I've included a vagrant file in the git repo that can be used to stand up a VM with this environment setup done automatically.

Running the Script
------------------

Here is a sample of commands to run to check out the code, run the tests, and run the deployment strategy script.

    git clone https://github.com/duality72/nf-sol.git
    cd nf-sol
    perl Build.PL
    ./Build test
    ./deployStrategy.pl -?
    ./deployStrategy.pl --startTime 'tomorrow noon' --waitTime 4 --buildId 32

