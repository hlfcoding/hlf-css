# CSS Framework

_last modified_     __July 2009__  
_document version_  __0.1__  
_framework version_ __1.1__  
_author_            __peng@pengxwang.com__  

_other flavors_

*   Rich
*   Light (soon) - no elastic support
*   Far (tba) - emphasis on mobile screens
*   Shiny (soon) - css3, no ie6/ie7 support
*   Strong (tba) - programmatic

_description_

This framework and document espouse my view on working with CSS.

Since most browsers are not CSS3-compliant, advanced CSS selectors 
and properties cannot be used. Instead we have to rely on better 
programming practices. While CSS is actually markup, what it allows 
through organization is powerful. That's why this framework uses an 
Object-Oriented approach, in the sense of property inheritance and 
property visibility. This approach completes with progressive 
enhancement, which allows consistency with less redundancy and a 
cleaner organizational core.

> "A CSS framework is a library that is meant to allow for easier, 
more standards-compliant styling of a webpage using the Cascading 
Style Sheets language. Just like programming and scripting language 
libraries, CSS frameworks package a number of ready-made options 
for designing and outlaying a webpage." -- [Wikipedia](http://en.wikipedia.org/wiki/CSS_framework)

_notes_

*   PREG regex patterns are used to describe certain variable values


## Stylesheets

Filenames can differ depending on the asset loader's parsing pattern.

*   layout.css
    
    Empty sheet that loads media-type dependent, standalone CSS files.  
    It's empty because `@import` statements must be at the top, so reset rules can't be in it.  
    If needed, you can add global layout rulesets _below_ the import statements, but beware of conflicts.  
    Each of the imported sheets has its own versions of the __Sections__.  
    This separation allows for [progressive enhancement](http://www.alistapart.com/articles/progressiveenhancementwithcss/).
    There is a compromise in speed, but it's only 3 more files.  
    
    *   layout_screen.css
    
        *   _reset_
        
            basically [Eric Meyer's version](http://meyerweb.com/eric/tools/css/reset/)  
        
        *   _extend > reset_
        
            New, possibly site-specific reset rules.  
            You should add new rules, not 
            This section is outside of `unique` because you might use custom rules in several projects.  
            So this is also where you would import other custom rules for use.  
        
        *   _grid_
        
            Fluid layout container system inspired by [YUI Grids](http://developer.yahoo.com/yui/grids/), but uses [clearfix](http://www.positioniseverything.net/easyclearing.html)  
        
        *   _extend > grid_
        
            New, possibly site-specific gridsets; or appending rulesets of base gridsets.  
            This section is outside of `unique` because you might use custom gridsets in several projects.  
            So this is also where you would import other custom gridsets for use.  
        
        *   _modules_
        
            Abstractions of common page elements, so all shared properties are included and protected.  
            Core also inspired by YUI Grids rules and OOP-CSS.  
        
        *   _extend > modules_
        
            New, possibly site-specific modules; or appending rulesets of base modules.  
            This section is outside of `unique` because you might use custom modules in several projects.  
            So this is also where you would import other custom modules for use.  
        
        *   _unique_
        
            Site-specific rulesets that refine the rulesets thus far.  
            Do the heavy, site-specific overriding here.  
    
    *   layout_print.css
    
        *   _reset_ -- [Hartija](http://code.google.com/p/hartija/)
        *   _extend > reset_ -- unique print version
        *   _grid_ -- framework's print version
        *   _extend > grid_ -- unique print version
        *   _module_ -- framework's print version
        *   _extend > module_ -- unique print version
    
    *   layout_mobile.css
    
        *   _reset_ -- framework's mobile version
        *   _extend > reset_ -- unique print version
        *   _grid_ -- framework's mobile version
        *   _extend > grid_ -- unique print version
        *   _module_ -- framework's mobile version
        *   _extend > module_ -- unique print version
    
    Layout sheets are basically master sheets. They have unlimited property scope __as long as 
    the property is positioning-relevant.

*   color.css
*   type.css

    As part of progressive enhancement, separate global stylesheets for typography and color are kept.  
    Incidentally this also allows us to separate the often less changed and less developer-relevant 
    type and color rules.  
    
    `color` only holds text, background, and border colors.  
    If a simple element's size is not affected by `layout` (ex: `body`), other background properties are 
    allowed for it.  
    
    `type` only holds layout-irrelevant font and text properties. 

    Both files have starter sets of properties for rapid development. 

*   \_1\_lte\_ie8.css
*   \_2\_lte\_ie7.css
*   \_3\_lte\_ie6.css

    Internet Explorer rendering fixes stack based on inheritance. `ie8` has cross-version fixes, `ie7` 
    fixes for itself and `ie6`, etc.  
    With a numerical prefix, other ie stylesheets can be added in order, assuming an assets loader is 
    being used. Also, each older version can now override the more recent, more global version.  
    Following progressive enhancement, layout media sheets are loaded beforehand as link tags.  
    Use the inline hacks `*property: value;` and `_property: value;` if a section can be maintained better or more 
    easily.


## Style Guide

Consistent style is not a requirement but a suggestion. 

### Section Folding

To help separate sections and create a truly modular document structure, sections are marked by 
`/** section comment */` -> `/* ^ section comment **/`--where `section comment` means 
`(action|) + inheritance trail + ( ! notice|)`--so each section can be folded in the IDEs: 
[Textmate](http://macromates.com/), [E](http://e-texteditor.com).  This is a hack so it doesn't work 
in all IDEs. For example, this structure is meant to be nested together:

    /** grid  */
    /** grid > cols */
    /** grid > cols > core ! protected */
        
    .gd .inG .col {
        float: left;
    }
        
    /* ^ grid > cols > core ! protected **/    
    /** grid > cols > widths */
    
    /* etc. */
    
    /* ^ grid > cols > widths **/
    /* ^ grid > cols **/    
    /* ^ grid  **/
    /** extend grid */
    
    /* etc. */
    
    /* ^ extend grid **/

This replaces using empty line breaks to denote sections, or a diverse range of non-fold-inducing 
section headers. While nesting sections is potentially infinite, do so only when necessary. 
Sometimes an `/* inline */` comment is enough.  
Hopefully the example shows how useful the end comment line can be. Notice the inheritance trail 
also acts as a translator of the usually terse selector values, so we get simplicity and clarity.  

### Indentation, Comments, Speed

The framework tries to minize blank lines to limit file size, without sacrificing clarity. 
It's also why the original block comments are all incorporated into this document. 
If files are too many / big, you can try using a [compressor](http://code.google.com/p/minify/) 
to serve the sheets. Duplicating rulesets for organization is discouraged unless it's for reuse.  
The only documentation missing in this document are inline comments within various implementations, 
labels for default implementations, translations of values, sub-subsection dividers, etc.  
Tabs (soft) are important and used when logical.  

### Naming conventions

For reusable code, the general pattern for naming selectors is to be as simple as possible, 
but still human. This is why the framework itself does not use a prefix like `yui-`.  
It simply becomes your framework upon first use. There are guidelines, not rules.  
The opposite is suggested for naming unique selectors. Be descriptive.  
The general rule of thumb follow by the framework is to define by _both_ content and visuals.

#### Selectors

For framework elements, there are core and sub classes. Cores are lower-case, non-camelized, 
2-3 letter logical abbreviations like `.gd` or `.col` or `.doc`. Subs are camelized, with the 
first letter from the respective core, like `.mnVeryLongName` or `.g2A` or `.g2AB` for a sub-sub 
class of two-column uneven grid with special bleed. For extending modules, the abbreviation can 
be used. There are also utility cores like fixes (`fix`), inner (`in`), outer (`ou`), child (`ch`), 
parent (`pa`), sibling(`sib`), descendant (`des`) and ancestor (`anc`), before (`bf`) and after (`af`). Use them 
_only as needed_. Example: `.paFix .fixC .ch1 a.des1`.  
While selector queries are generally kept short, unneeded global namespace pollution is kept in mind.


## Descriptions and Usage

### Grid

Generates gridsets using % column widths and em wrapper widths with the base font size of 16px.  
IE7 and below can overround 1px for each col, so with the fixes the default gridsets, 
nesting included, work until _grid_ width is less than 600px.

*   wrapper (`.doc`)
    
        It's easier to have the pixel number be base 5, 10, 2, 4, 6, 8, 12, 16
    
*   grid (`.gd`)
*   inner-grid (`.inG`)

        The style for most block elements in the framework is to have an inner block element. 
        This is a pattern I use often to have `width` and `padding` not affect each other.  
        To hide grid borders use `border-color: transparent;` instead of `border-width: 0;`

*   cols (`.col`)
    
        Uses padding for the gutter to avoid IE double margin bug

    *   inner-col (`.inC`)
    
        To avoid a mis-aligned right page edge in IE, avoid showing the shape of this.
    
    *   colsets (`.g[0-9][A-Z]` > `.c[0-9]`)
    
        Some of the larger colsets are shortcuts for nested grids.  
        You can get the same thing through nesting, but maybe more bugs.  
        The percentages are set so all gridsets align.

    *   formula for calculating col-widths

        (100% - [ncols - 1] * 1.99%) / [ncols]
        for IE: - 1.125%

### Module

Modules are divide into sections that contain different implementations. Most 
modules are stand-alone and do not require another class.

*   boxes (`.box`)
*   menus (`.mn`) - standard vertical linked list


### Misc. 

*   clearfix hack (`.fixC`)
*   w3c clear hack (`.clearer`)

## Implementation

### General Rules

*   __Only modify lines and sections not commented as ` ! protected `.  
    And put the new properties in a new ruleset, to keep code reusable.__


### Unique Section

Only for elements with ids. 

> Example: `#hd`, `#bd`, `#ft`  
> These are irregular, one-instance wrapping containers  

Use this section (and ids) sparingly, instead extend modules and grid in the sections below.

### Extending Gridsets and Modules

Keep in mind to balance adding and omitting properties, from being too straightforward or too abstract.

Extending a gridset simply means giving it new widths.  
You may also want to test it with other gridsets for nesting compatibility.

Extending a module means giving an element multiple classes.

> `class="box box_FB"` <- where `FB` is the acronym of this project (Foo Bar Video Group Ltd.).

For more control, you can add a unique instance or use more selectors.

> `#myBox` or `#bd .c1 .box_FB`

Use your best judgment on where to assign the class. Suggested: `.inC`.  
But just try to avoid situations like:

> `class="box box_FB gd gB g2A"`

And in such situations make sure the base -> custom order is clear.

Avoid using actual html tags in your selectors like `ul.mnPlus li a` if you just want to 
be clear. Doing so limits the power of the module, so don't include the html tag unless 
the it's by design.
 

## CSS Reference

To add more weight to certain rulesets, use the #html weight.

> `#html #bd .c1 .box_FB`

Since the child selector syntax `>` is not feasible to use, understand:

> `.a .b` as applies to `.a .b .b` -- so add a new reset ruleset for the second selector.

IE debugging reference: 

*   [http://www.positioniseverything.net/explorer.html]()
*   [http://www.satzansatz.de/cssd/onhavinglayout.html]()
*   [http://johncrenshaw.net/blog/ie-list-item-margin-hack]()
*   [http://www.ojctech.com/content/css-jumping-columns-and-ies-percentage-rounding-algorithm]()