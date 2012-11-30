###
// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

// TwitterCLDR (JavaScript) v{{version}}
// Authors:     Cameron Dutro [@camertron]
                Kirill Lashuk [@KL_7]
                portions by Sven Fuchs [@svenfuchs]
// Homepage:    https://twitter.com
// Description: Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Javascript.
###

# required alias definition that adds twitter_cldr to Twitter's static build process
###<<module_def>>###

TwitterCldr = {}
{{#is_rtl?}}
TwitterCldr.is_rtl = true;
{{/is_rtl?}}
{{^is_rtl?}}
TwitterCldr.is_rtl = false;
{{/is_rtl?}}

{{> utilities}}
{{{contents}}}

root = if exports?
  exports
else
  this.TwitterCldr = {}
  this.TwitterCldr

root[key] = obj for key, obj of TwitterCldr
