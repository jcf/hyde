## hyde
### Every Jekyll needs it's Hyde

I wrote this little bundle of files to serve static assets using Sinatra
so I could have make use of the free hosting provided by Heroku.

#### URL rewriting

Any folder will have index.html appended before being sent.

Any file with an extension will be sent directly.

I've overwritten Sinatra's not_found to render a view but eventually
this will redirect elsewhere.