## Now defunct! Sorry Velocity residents. If you're interested in getting the site working again, contact me at hi@psobot.com.

Lndr.me (formerly lndry) is a laundry tracking app made for the University of Waterloo's VeloCity residence.

Email washer1@lndr.me when you put in your clothes, and two good things happen:
  - You get an email when it's done (based on a timer)
  - Others can tell that the machine is busy
  - You used my app, so I'm happy

<img width="891" alt="lndrme" src="https://cloud.githubusercontent.com/assets/213293/19216250/3cbab54c-8d82-11e6-9a13-bc359bc162ae.png">

It's a simple Rails app, but it uses Whenever to send emails out every 2 minutes, and a Postfix alias to recieve mail:

    washer:		"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"
    washer1:	"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"
    washer2:	"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"
    dryer:		"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"
    dryer1:		"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"
    dryer2:		"| /usr/local/bin/ruby /var/www/lndr.me/current/script/receive.rb"

As well, it makes use of PostageApp (http://postageapp.com) to send transactional email - you'll need an API key from the wonderful folks there.
Note: to deploy, place settings.yml and database.yml in your capistrano "shared" directory on production/staging. The deploy script then copies them into ./config/.

This has never been tested outside of my Ubuntu server, so have fun.
It has an HTTP API, but a very simple one - check http://lndr.me/api for details. (Rather, for an email I sent a friend outlining the API.)

I committed many sins in the name of getting this app out quickly, so you'll notice a lot of conventions broken and imperfect code.
Let me know if you need help getting the code up and running, or if you're having any trouble at all.
Pull requests and bugfixes welcome!

Also, I forgot to write any tests. Whoops.
