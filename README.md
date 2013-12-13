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

Example Output
--------------
```
Raven:nf-sol chilton$ ./deployStrategy.pl -?
Usage: deployStrategy.pl [--startTime <time>] [--waitTime #] [--buildId #]

  startTime - The earliest time a deployment can start.
              Ex. '12/08/13 07:00:00' or '3pm tomorrow'.
              Defaults to 'now' and parsing in PST.
  waitTime  - Time to wait between deployments in hours.
              Defaults to 1.
  buildId   - The build ID that will be deployed.
              Used to report on drift of already deployed builds.
              Defaults to 0 (no report)
Raven:nf-sol chilton$ ./deployStrategy.pl
     EU: 12/13/13 10:36:18 PST   12/13/13 13:36:18 EST   12/13/13 18:36:18 GMT
US-East: 12/13/13 12:36:18 PST   12/13/13 15:36:18 EST   12/13/13 20:36:18 GMT
US-West: 12/13/13 15:36:18 PST   12/13/13 18:36:18 EST   12/13/13 23:36:18 GMT
Raven:nf-sol chilton$ ./deployStrategy.pl --startTime 'tomorrow noon'
US-East: 12/14/13 12:00:00 PST   12/14/13 15:00:00 EST   12/14/13 20:00:00 GMT
     EU: 12/14/13 13:00:00 PST   12/14/13 16:00:00 EST   12/14/13 21:00:00 GMT
US-West: 12/14/13 15:00:00 PST   12/14/13 18:00:00 EST   12/14/13 23:00:00 GMT
Raven:nf-sol chilton$ ./deployStrategy.pl --startTime 'tomorrow noon' --buildId 32
US-East: 12/14/13 12:00:00 PST   12/14/13 15:00:00 EST   12/14/13 20:00:00 GMT Drift: 12
     EU: 12/14/13 13:00:00 PST   12/14/13 16:00:00 EST   12/14/13 21:00:00 GMT
US-West: 12/14/13 15:00:00 PST   12/14/13 18:00:00 EST   12/14/13 23:00:00 GMT Drift: 22
Raven:nf-sol chilton$ 
```
