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

TwitterCldr = {}
{{#is_rtl?}}
TwitterCldr.is_rtl = true;
{{/is_rtl?}}
{{^is_rtl?}}
TwitterCldr.is_rtl = false;
{{/is_rtl?}}
{{> utilities}}
{{{contents}}}
exports[key] = obj for key, obj of TwitterCldr if exports?  # for node
