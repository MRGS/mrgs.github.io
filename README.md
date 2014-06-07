# MRGS/SLMR Blog

Hi! Here's the source for the new MRGS/SLMR blog, located at [mrgs.ca](http://mrgs.ca) and hosted here as a [Jekyll](http://jekyllrb.com)-based [Github Page](https://pages.github.com/).

### IF YOU WANT TO WRITE A POST OR ADD A PAGE:

-   [Sign up for a Github account](https://github.com/join) if you don't have one! Then get write access to this repo: poke someone with ownership of the MRGS Github organization and they'll add you.

-   Head over to [prose.io](http://prose.io) and authorize it to access your Github credentials.

-   To create a post, enter the "mrgs.github.io" repository in Prose, then head to the *_posts* or *_drafts* directory and hit "New File" to start drafting one up. Simple as that.

-   If you want to add a new static page instead (like "*mrgs.ca/parcade*",) just hit "New File" from the site root in Prose, and change the filename to something like "*parcade/index.md*" -- that is, the directory name should match the path to the page.

    (Note that there'll be a way to change the layout to a static page-specific one when we get there. Sooooon.)

That should be all you need to start making pages and posts! The Prose interface can be a little confusing at first, but it should provide all the tools you need to preview your as they'll appear on the live site.

---

### IF YOU WANT TO EDIT THE SITE'S LAYOUT OR CSS

Hacking on the site's look is a bit more complicated. We want to be able to tweak things and see how they look locally, without having to push those changes up to the live site. That means installing a local toolchain, unfortunately.

*You only need to do this stuff if you're editing layouts!*

#### On OSX:

- Clone the repo locally, if you haven't already.
- The easiest way to get all the dependencies is to install [Brew](http://brew.sh) if you don't have it. Follow the instructions on the site and you'll be up and running in no time.
- Open the Terminal and run `brew install node`.
- Run `npm install -g bower npm` and `npm install -g gulp`. (These'll install the Node-based tools [Bower](http://bower.io) and [Gulp](http://gulpjs.com/).)
- Run `gem install jekyll` and `gem install bundler`. (You might need to run these as `sudo`, as in `sudo gem install jekyll`.)

#### On Windows:

- You'll need to install [node.js](http://nodejs.org/) manually. It should add itself to your PATH so that you can execute it from the command line.
- You'll also need Ruby -- probably the easiest way to install it is to use the aptly-named [RubyInstaller](http://rubyinstaller.org/).
- From a command prompt, run `npm install -g bower` and `npm install -g gulp` to grab [Bower](http://bower.io) and [Gulp](http://gulpjs.com/).
- Run `gem install jekyll` and `gem install bundler` to grab the Ruby-based dependencies.

#### On Linux:

- You can grab node.js and Ruby via your favourite package manager. Remember that the packages in your distro's repositories might lag behind the latest versions by a significant factor, so if you're getting weird errors you might want to seek out PPAs/repos that offer binaries from closer upstream.
- `sudo npm install -g bower`, `sudo npm install -g gulp`, `sudo gem install jekyll` and `sudo gem install bundler` to install all the dependencies.


#### All platforms:

- `cd` into the local directory to which you cloned the repo and `run npm install`, `bower install` and `bundle install`.

Now from the command line in the project directory you can run the build task: `gulp serve` will launch your browser and crank up a compact local server that watches for changes on the site and automatically rebuild and refresh the view as you make changes. Hooray! Edit the files in the *_less*, *_src*, *_layouts*, and *_includes* directories to your heart's content.