# UseGalaxy.org.au Page

This repository contain the source for the Galaxy Australia website and Landing page.

The root of [https://usegalaxy-au.github.io](https://usegalaxy-au.github.io) (i.e. - the plain URL) contains the full website with the menus etc.

The landing page view is located at [https://usegalaxy-au.github.io/galaxy](https://usegalaxy-au.github.io/galaxy)

## Collaboration/Addition to the website Instructions

If you wish to add a **News item**, an **Event** or a **Notice bar**, you will need to edit the files here. Best practice suggests you *fork* this repository to your own github workspace and then *clone* it from there. Any changes you make to your own copy can then be added to the website via a *Pull Request* from your *fork* to the original repository.

The website is built automatically via a *Jenkins* automation server every time the *master* branch of the original repository is changed.

If you want to set up an environment on your computer (maybe not Windows.. :( ) so that you can preview the changes you are making, you can install the Jekyll webpage builder. If you do not want to preview your changes, you can just skip this part.

### Install software necessary to build the website.

If you want to look at your changes before you submit a pull request, you will need to install the Jekyll static webpage builder. Jekyll is written in Ruby - it's a tad complicated so we've written a Makefile to make it a bit easier.

First, clone the repository to your computer.

```bash
git clone https://github.com/usegalaxy-au/website
```

If you don't already have conda installed, install it.

```bash
cd website
make conda-install
```

Create a new conda environment for Jekyll to live in (this will stop it interfering with anything else on your computer.)

```bash
make create-env
```

Finally, install Jekyll and it's dependencies.

```bash
make install
```

* If you encounter an error about `libxml2` on Linux, please try to install `libxml2-dev` (executing `sudo apt install libxml2-dev`) if on Debian/Ubuntu or `libxml2-devel` (executing `sudo yum install libxml2-devel`) if on Fedora/RedHat/CentOS, and re-run `make install`.

Once this is complete, you can look at the current local website using:

```bash
make run
```

View this local version of the website at [http://localhost:4000](http://localhost:4000)

Other things you can do with the Makefile are:

* `make clean` - this cleans up any old builds

## Common updates

Some of the common updates done to the website are for:

* A notification bar
* A news item
* An event listing

Instructions for each follow.

### Notification bar

Edit the file `_data/notices.yml`.

The format of this file is:

```yml
- title: The title of the Notification
  class: type #type can be: "info" (blue background), "warning" (orange background) or "danger" (red background)
  site: galaxy #always leave set as galaxy
  messages:
    - message: |
        Put your message here! It is in markdown format and so you can use [URL](link) and mailtos etc: [help@genome.edu.au](mailto:help@genome.edu.au)
        * list items
        * other markdown too.
```

### A news item for the News list

These files are all stored in `_posts/`. One news item per file. The easiest way to add a news item is to copy an existing one and change the file name with the new date and title and then edit its contents.

Any markdown file put into the `_posts/` directory will be rendered as a news item but there are some things that need to be in the yaml header delineated by the upper and lower `---`.

An example news item file looks like:

```yml
---
site: freiburg
title: 'Galaxy Australia moves to new hardware'
tags: [devops]
supporters:
    - galaxyaustralia
    - qcif
    - uqrcc
    - melbinfo
    - ardc
---
**Galaxy Australia moves to the new QRIS cloud stage 5 hardware**
<br/>
This morning after a planned outage, the Galaxy Australia main queue was moved from it's original home on QRIS cloud to their shiny new hardware! The stage 5 hardware is faster, better connected and much more flexible. This will help Galaxy Australia be more responsive to it's users as we are now able to launch bigger jobs and have them run faster.

For more information about Galaxy Australia's home, see the [QRIScloud website](https://qriscloud.org.au) and the [ARDC](https://ardc.org.au) refresh of the [ NeCTAR Australian Research Cloud](https://ardc.edu.au/collaborations/strategic-activities/storage-and-compute/research-cloud-request-for-proposals/)
```

The *yaml* at the top of the file includes the following fields:

Key             |  Description and possible values
----------------|------------------------------------------------------
site:           | `freiburg` at this stage we only have one site
tags:           | An array of tag values that this news item is associated with. Each on has an icon. Can be a collection from the following: [devops,training,update,tools,downtime,paper,release,job]
supporters:     | A yaml array of supporters for the news. Each supporter's logo will be appended to the end of the news item in the order presented here.

### An event/training item for the Events list

These files are all located in the `_events/` folder. To create a new event listing, copy one of the old files and change its data and title.

The format of the file is similar to a news item - a bit of *yaml* at the top with markdown below.

An example:

```yml
---
site: freiburg
tags: [training]
title: Galaxy training workshops Melbourne - March 2019
starts: 2019-03-21
ends: 2018-03-26
organiser:
  name: Melbourne Bioinformatics
  email: help@genome.edu.au
location:
  name: Melbourne Bioinformatics
  street: 187 Grattan St
  city: Carlton
  region: Victoria
  country: Australia
supporters:
 - melbinfo
 - galaxyaustralia
 - emblabr
---

Melbourne Bioinformatics, in association with Galaxy Australia and EMBL-ABR will be running a series of half day Galaxy Training Workshops in March 2019. The workshops will be run at Melbourne Bioinformatics, 187 Grattan St, Carlton.

<br/>
<style>
  th, td {
    padding: 10px
  }
  table tr:nth-child(even) {
    background-color: #eee;
  }
  table tr:nth-child(odd) {
    background-color: #fff;
  }
  table th {
    color: white;
    background-color: black;
  }
</style>

| Workshop Title | Date | Time | Last Run | Details |
|----------------|------|------|----------|---------|
| Introduction to Galaxy and the Genomics Virtual Laboratory | 21 March 2019 | 1:30pm - 4:30pm | 20 June 2018 | [Details and Sign Up](https://www.melbournebioinformatics.org.au/training-events/introduction-to-galaxy-and-the-genomics-virtual-laboratory/#more-2583) |
| RNA-Seq Differential Gene Expression Analysis using Galaxy and the GVL | 22 March 2019 | 9:30am - 12:30pm | 18 October 2018 | [Details and Sign Up](https://www.melbournebioinformatics.org.au/training-events/rna-seq-dge-analysis-galaxy-gvl/#more-1720) |
| Introduction to Variant Calling with Galaxy & the GVL | 26 March 2019 | 9:30am - 12:30pm | 21 March 2018 | [Details and Sign Up](https://www.melbournebioinformatics.org.au/training-and-events/) |

<br/>

There are also some non-Galaxy workshops being run in and around the same dates. These workshops include:
* Genome browsers and using UCSC Genome Browser tools
* Introduction to long-read genome assembly
* Data tidying with Python and Pandas
* Data visualisation with Python
* Best practices in Bioinformatics software development

<br/>

Sign up here: [https://www.melbournebioinformatics.org.au/training-and-events/](https://www.melbournebioinformatics.org.au/training-and-events/)

---
```

The top section of the file contains some *yaml* to describe the facts about the event. Hopefully everything is pretty self explanatory - just remember that correct indentation is important here.

The bottom section is written in markdown and can contain anything you want to put in the details of the event.



## Other bits and pieces.

## Duplication

You will notice there is some duplication in the templates:

Parent                            | Duplicate
---------------                   | --------------
`_layout/event.html`              | `_layout/event-galaxy.html`
`_layout/event_list.html`         | `_layout/event_list-galaxy.html`
`_layout/news.html`               | `_layout/news-galaxy.html`
`_layout/news_list.html`          | `_layout/news_list-galaxy.html`
`_layout/news.md`                 | `_layout/gxnews.md`
`_layout/events.md`               | `_layout/gxevents.md`
`_layout/default.md`              | `_layout/default-galaxy.md`
`_includes/home_news_events.html` | `_includes/home_news_events-galaxy.html`

This duplication is intentional, it is part of the `collections` configuration
and allows us to produce "two" sites from one set of source documents. This is
done intentionally in order to allow authors to add posts once, and then on the
code side we generate both a "normal" site with the full header, and a "galaxy"
version without the header since a duplicate header looks quite strange in
Galaxy.

If you need to edit templates, I would recommend editing the parent / normal
template and then `vimdiff`ing (or other tool of your choice) to compare that
with its `-galaxy.html` sibling. Most of the templates will be identical except for
the template they are inheriting from. The only major differences is that the
normal templates read `for post in site.posts` (or `site.events`) while the
galaxy templates read `for post in site.posts_plain` (`or site.events_plain`)


## Deploying

The scripts `.build.sh` and `.publish.sh` are run by our Jenkins bot to update the website. They are not designed to be run standalone.
